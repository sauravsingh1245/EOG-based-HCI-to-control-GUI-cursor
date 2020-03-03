close all;
clear;
clc;

%% Load Feature Matrix and their corresponding labels

plotStream=false;
loadStoredData=true;
iteration=3;

tempacc=zeros(2,iteration);

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

    [~,classNo]=size(action);
    [totalSampleNo,featureNo]=size(featureMatrix);

    %% Divide the complete dataset into Training, cross-validatioon and test sets

    trainCvFM=[];
    trainCvLBL=[];
    testsetFM=[];
    testsetLBL=[];
    TrCvTs=[50 25];     % [training_samples% CrossVal_samples%] 
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

    tempacc(1,itr)=acc1;
    tempacc(2,itr)=acc2;
    
end

fprintf('\n\nMean accuracy on test set is: %.2f%%\nMean accuracy on training set is: %.2f%%\n\n\n',mean(tempacc(1,:)),mean(tempacc(2,:)));

%% print class loss for the last SVM Model
for i=1:classNo
    fprintf('Class Loss for %s is %.2f%%\n',action{i},classLoss(i));
end

L=length(y_testset);
C=confusionmat(testsetLBL,y_testset);
acc=trace(C)/L;
targets = zeros(9,L);
outputs = zeros(9,L);
targetsIdx = sub2ind(size(targets), (y_testset+1)', 1:L);
outputsIdx = sub2ind(size(outputs), (testsetLBL+1)', 1:L);
targets(targetsIdx) = 1;
outputs(outputsIdx) = 1;
% Plot the confusion matrix for a 8-class problem
plotconfusion(targets,outputs,'Test Set - ');

h = gca;
h.XTickLabel = {'NoClass','Up','Down','Cen','In-Blink','Rej','Left','Right','Vol-Blink',''};
h.YTickLabel = {'NoClass','Up','Down','Cen','In-Blink','Rej','Left','Right','Vol-Blink',''};
h.YTickLabelRotation = 90;

figure;
L=length(y_traindata);
C=confusionmat(trainCvLBL,y_traindata);
acc=trace(C)/L;
targets = zeros(9,L);
outputs = zeros(9,L);
targetsIdx = sub2ind(size(targets), (y_traindata+1)', 1:L);
outputsIdx = sub2ind(size(outputs), (trainCvLBL+1)', 1:L);
targets(targetsIdx) = 1;
outputs(outputsIdx) = 1;
% Plot the confusion matrix for a 8-class problem
plotconfusion(targets,outputs,'Training Set - ');

h = gca;
h.XTickLabel = {'NoClass','Up','Down','Cen','In-Blink','Rej','Left','Right','Vol-Blink',''};
h.YTickLabel = {'NoClass','Up','Down','Cen','In-Blink','Rej','Left','Right','Vol-Blink',''};
h.YTickLabelRotation = 90;