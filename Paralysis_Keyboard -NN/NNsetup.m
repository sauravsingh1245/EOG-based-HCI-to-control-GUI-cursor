function [net] = NNsetup()
% train SVM

load NewSamples.mat;                % load first set
fm1=featureMatrix;
lb1=label;
load NewSamples0422.mat;            % load second set
featureMatrix=[fm1;featureMatrix];
label=[lb1;label];
clear fm1 lb1;

featureMatrix=[featureMatrix;featureMatrix;featureMatrix];
label=[label;label;label];
[~,classNo]=size(action);
[totalSampleNo,featureNo]=size(featureMatrix);

%% Divide the complete dataset into Training, cross-validatioon and test sets

trainx=[];
trainy=[];
testx=[];
testy=[];
CVx=[];
CVy=[];
TrCvTs=[50 25];     % [training_samples% CrossVal_samples%] 
p= TrCvTs(2)/sum(TrCvTs);


idx=randperm(totalSampleNo);
label=label(idx);
featureMatrix=featureMatrix(idx,:);

NNlabel=zeros(totalSampleNo,classNo);
for i=1:classNo
    NNlabel(label==i,i)=1;
end

id_cv=floor(TrCvTs(1)*totalSampleNo/100);
id_test=floor(sum(TrCvTs)*totalSampleNo/100);
trainx=featureMatrix(1:id_cv,:);
trainy=NNlabel(1:id_cv,:);
CVx=featureMatrix(id_cv+1:id_test,:);
CVy=NNlabel(id_cv+1:id_test,:);
testx=featureMatrix(id_test+1:end,:);
testy=NNlabel(id_test+1:end,:);

trainx=trainx';
trainy=trainy';
testx=testx';
testy=testy';
CVx=CVx';
CVy=CVy';

%% Train neural network

% net = feedforwardnet(30);
net=cascadeforwardnet(30);
net.trainParam.showWindow = false;
net = configure(net,trainx,trainy);
[net,tr]=train(net,trainx,trainy);
predy=net(CVx);
[~,py]=max(predy',[],2);
[~,ty]=max(CVy',[],2);
C=confusionmat(ty,py);
acc=trace(C)/length(ty);
fprintf('Accuracy on CV set is: %f\n',acc);

predy=net(testx);
[~,py]=max(predy',[],2);
[~,ty]=max(testy',[],2);
L=length(ty);
C=confusionmat(ty,py);
acc=trace(C)/L;
fprintf('Accuracy on test set is: %f\n',acc);

predy=net(trainx);
[~,py]=max(predy',[],2);
[~,ty]=max(trainy',[],2);
L=length(ty);
C=confusionmat(ty,py);
acc=trace(C)/L;
fprintf('Accuracy on training set is: %f\n',acc);

end

