function [y] = ClassPredict(SVM,x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    classNo=length(SVM);
    [m,~]=size(x);
    y=zeros(m,1);
    tempy=zeros(m,classNo);

    for i=1:classNo
        tempy(:,i)=predict(SVM{i},x);
    end
    for i=1:m
        yclass=find(tempy(i,:)==1);
        if length(yclass)==1
            y(i)=yclass;
        else
            y(i)=0;
        end
    end
end

