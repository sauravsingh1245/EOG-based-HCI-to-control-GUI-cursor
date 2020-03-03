function [svm] = SVMsetup()
% train SVM


load NewSamples.mat;                % load first set
fm1=featureMatrix;
lb1=label;
load NewSamples0422.mat;            % load second set
featureMatrix=[fm1;featureMatrix];
label=[lb1;label];
clear fm1 lb1;

[~,classNo]=size(action);
[totalSampleNo,featureNo]=size(featureMatrix);

classLoss=[];
[~,classNo]=size(action);
trainCvFM=[];
trainCvLBL=[];
testsetFM=[];
testsetLBL=[];
TrCvTs=[65 10];     % [training_samples% CrossVal_samples%] 
p= TrCvTs(2)/sum(TrCvTs);

idx=randperm(totalSampleNo);
label=label(idx);
featureMatrix=featureMatrix(idx,:);
id_test=floor(sum(TrCvTs)*totalSampleNo/100);
trainCvFM=featureMatrix(1:id_test,:);
trainCvLBL=label(1:id_test,:);
testsetFM=featureMatrix(id_test+1:end,:);
testsetLBL=label(id_test+1:end,:);

%% Train Support Vector Machine in one-VS-all fashion
classLoss=[];

for i=1:classNo
    opTrainCv=zeros(length(trainCvLBL),1);
    opTrainCv(trainCvLBL==i)=1;
    cvp = cvpartition(opTrainCv,'HoldOut',p);
    
    % Training
    SVMModel{i} = fitcsvm(trainCvFM,opTrainCv,'Standardize',true,...
        'KernelFunction','gaussian','KernelScale','auto',...
        'CrossVal','on','CVPartition',cvp);
    svm{i}=SVMModel{i}.Trained{1};
    % Estimate the out-of-sample misclassification rate.
    classLoss = [classLoss kfoldLoss(SVMModel{i})];
end

%% Classify test set and calculate accuracy

y_traindata=ClassPredict(svm,trainCvFM);
y_testset=ClassPredict(svm,testsetFM);

acc1=y_testset-testsetLBL;
acc2=y_traindata-trainCvLBL;

acc1(acc1~=0)=1;
acc2(acc2~=0)=1;

acc1=(1-(sum(acc1)/length(testsetLBL)))*100;
acc2=(1-(sum(acc2)/length(trainCvLBL)))*100;

fprintf('Accuracy on test set is: %.2f%%\nAccuracy on training set is: %.2f%%\n',acc1,acc2);
for i=1:classNo
    fprintf('Class Loss for %s is %.2f%%\n',action{i},classLoss(i));
end

end

