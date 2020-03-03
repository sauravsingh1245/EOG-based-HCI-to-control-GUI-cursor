close all;
clear;
clc;

%% Load Feature Matrix and their corresponding labels

plotStream=false;
loadStoredData=true;
iteration=3;

tempacc=zeros(3,iteration);

for itr=1:iteration

    fprintf('\n\n\nIteration %d:\n',itr);
    if loadStoredData
        load NewSamples.mat;                % load first set
        fm1=featureMatrix;
        lb1=label;
        load NewSamples0422.mat;            % load second set
        featureMatrix=[fm1;featureMatrix];
        label=[lb1;label];
        clear fm1 lb1;
    else
        action={'Up','Down','center','InvoluntaryBlink','Rejection','Left','Right','VoluntaryBlink'};
        [~,classNo]=size(action);
        label=[];
        featureMatrix=[];

        for q=1:classNo
            filename=['SJEOG_' action{q} '_Sample']; 
            tempFileName=filename;
            n=0;
            while(exist([tempFileName '.xlsx'],'file'))
                noisy_x=xlsread([tempFileName '.xlsx']);
                fprintf('Processing file: %s\n',tempFileName);
                label=[label ; q];
                x=filterSample(noisy_x,plotStream);
                featureMatrix=[featureMatrix ; featureExtractor(x,plotStream)];
                tempFileName=[filename num2str(n)];
                n=n+1;
            end
        end
        clear x tempFileName q n filename garbage; 
    end

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

    NNlabel=zeros(totalSampleNo,classNo);
    for i=1:classNo
        NNlabel(label==i,i)=1;
    end

    featureMatrix=featureMatrix(idx,:);
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

%     net = feedforwardnet(30);
    net=cascadeforwardnet(30);
    net.trainParam.showWindow = false;
    net = configure(net,trainx,trainy);
    [net,tr]=train(net,trainx,trainy);
    predy=net(CVx);
    [~,py]=max(predy',[],2);
    [~,ty]=max(CVy',[],2);
    C=confusionmat(ty,py);
    tempacc(1,itr)=trace(C)/length(ty);
    fprintf('Accuracy on CV set %d is: %f\n',i,tempacc(1,itr));
    
    predy=net(testx);
    [~,py]=max(predy',[],2);
    [~,ty]=max(testy',[],2);
    L=length(ty);
    C=confusionmat(ty,py);
    tempacc(2,itr)=trace(C)/L;
    fprintf('Accuracy on test set is: %f\n',tempacc(2,itr));
    
    predy=net(trainx);
    [~,py]=max(predy',[],2);
    [~,ty]=max(trainy',[],2);
    L=length(ty);
    C=confusionmat(ty,py);
    tempacc(3,itr)=trace(C)/L;
    fprintf('Accuracy on training set is: %f\n',tempacc(3,itr));
end

fprintf('\n\nMean accuracy on CV set is: %.4f%%\nMean accuracy on test set is: %.4f%%\nMean accuracy on training set is: %.4f%%\n\n\n',mean(tempacc(1,:)),mean(tempacc(2,:)),mean(tempacc(3,:)));

%% confusion on training set

figure;
predy=net(testx);
[~,py]=max(predy',[],2);
[~,ty]=max(testy',[],2);
L=length(ty);
targets = zeros(8,L);
outputs = zeros(8,L);
targetsIdx = sub2ind(size(targets), py', 1:L);
outputsIdx = sub2ind(size(outputs), ty', 1:L);
targets(targetsIdx) = 1;
outputs(outputsIdx) = 1;
% Plot the confusion matrix for a 8-class problem
plotconfusion(targets,outputs,'Test Set - ');

h = gca;
h.XTickLabel = {'Up','Down','Cen','In-Blink','Rej','Left','Right','Vol-Blink',''};
h.YTickLabel = {'Up','Down','Cen','In-Blink','Rej','Left','Right','Vol-Blink',''};
h.YTickLabelRotation = 90;

%% confusion on training set

figure;
predy=net(trainx);
[~,py]=max(predy',[],2);
[~,ty]=max(trainy',[],2);
L=length(ty);
targets = zeros(8,L);
outputs = zeros(8,L);
targetsIdx = sub2ind(size(targets), py', 1:L);
outputsIdx = sub2ind(size(outputs), ty', 1:L);
targets(targetsIdx) = 1;
outputs(outputsIdx) = 1;
% Plot the confusion matrix for a 8-class problem
plotconfusion(targets,outputs,'Training Set - ');

h = gca;
h.XTickLabel = {'Up','Down','Cen','In-Blink','Rej','Left','Right','Vol-Blink',''};
h.YTickLabel = {'Up','Down','Cen','In-Blink','Rej','Left','Right','Vol-Blink',''};
h.YTickLabelRotation = 90;