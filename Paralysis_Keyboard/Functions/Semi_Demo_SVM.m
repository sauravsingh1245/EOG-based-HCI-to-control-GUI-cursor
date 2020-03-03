close all;
clear;
clc;

%% Load Feature Matrix and their corresponding labels

plotStream=false;
loadStoredData=true;

if loadStoredData
    load samples.mat;
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
TrCvTs=[65 10];     % [training_samples% CrossVal_samples%] 
p= TrCvTs(2)/sum(TrCvTs);

for i=1:classNo
    idx=find(label==i);
    sampleNo=length(idx);
    TC=floor(sampleNo*TrCvTs([1 2])/100);
    trainCvFM=[trainCvFM ;featureMatrix(idx(1:TC(1)+TC(2)),:)];
    trainCvLBL=[trainCvLBL ;label(idx(1:TC(1)+TC(2)),:)];
    testsetFM=[testsetFM ;featureMatrix(idx(TC(1)+TC(2)+1:end),:)];
    testsetLBL=[testsetLBL ;label(idx(TC(1)+TC(2)+1:end),:)];
end

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