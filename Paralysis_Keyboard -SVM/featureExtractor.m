function [featureVector] = featureExtractor(x,plotStream)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    [m,n]=size(x);
    lvl=6;
    THon=0.1;
    THoff=-0.1;


    xdiff=diff(x,1,2);
    xdiff=[xdiff xdiff(:,end)];
   
    xd=xdiff;    
    for i=1:m
        [swa,~] = swt(xdiff(i,:),lvl,'db1');                     % applying SWT for denoising
        xd(i,:)=swa(lvl,:);
    end

    [xdMax,posMax]=max(xd,[],2);
    [xdMin,posMin]=min(xd,[],2);
    UWL_pos{1}=find(xd(1,:)>THon);
    UWL_pos{2}=find(xd(2,:)>THon);
    LWL_pos{1}=find(xd(1,:)<THoff);
    LWL_pos{2}=find(xd(2,:)<THoff);
    UWL=[length(UWL_pos{1});length(UWL_pos{2})]/n;
    LWL=[length(LWL_pos{1});length(LWL_pos{2})]/n;

    psi=zeros(4,2*n);
    psi(1,:)=[-ones(1,n) zeros(1,n)];
    psi(2,:)=[ones(1,n) zeros(1,n)];
    psi(3,:)=[zeros(1,n) -ones(1,n)];
    psi(4,:)=[zeros(1,n) ones(1,n)];
    
    xCon=[x(1,:) x(2,:)];
    V=xCon;
    for i=1:4
        V(i,:)=xCon.*psi(i,:);
    end
    
    final_V=[V(1,:) V(2,:) V(3,:) V(4,:)];
    [Vmax,Imax]=max(final_V,[],2);
    
    featureVector=[xdMax' xdMin' UWL' LWL' Vmax Imax/(8*n)];
    
    if plotStream
        figure('Name','Derivative of the sample');
        for i=1:m
            subplot(m,3,3*i-2);
            plot(x(i,:));
            ylim([-6 6]);
            title(['Denoised EOG Signal CH-' num2str(i)]);
            xlabel('t->');
            ylabel('A->');
            subplot(m,3,3*i-1);
            plot(xdiff(i,:));
            ylim([-1 1]);
            title(['Noisy differentiated Signal CH-' num2str(i)]);
            xlabel('t->');
            ylabel('A->');
            subplot(m,3,3*i);
            plot(xd(i,:));
            ylim([-1 1]);
            title(['Denoised differentiated Signal CH-' num2str(i)]);
            xlabel('t->');
            ylabel('A->');
        end
        for i=1:m
            figure('Name',['Feature extraction: CH' num2str(i)]);
            plot(xd(i,:));
            ylim([-1 1]);
            hold on;
            plot(THon*ones(1,n),'r');
            plot(THoff*ones(1,n),'r');
            stem(posMax(i),xdMax(i));
            stem(posMin(i),xdMin(i));
            plot(UWL_pos{i},(3*THon/2)*ones(1,length(UWL_pos{i})),'g');
            plot(LWL_pos{i},(3*THoff/2)*ones(1,length(LWL_pos{i})),'g');
            title(['Feature Extraction from differentiated Signal CH-' num2str(i)]);
            xlabel('t->');
            ylabel('A->');
            hold off;
        end
        figure('Name','Decomposition templates');
        for i=1:4
            subplot(2,2,i);
            plot(psi(i,:));
            ylim([-2 2]);
            title(['Decomposition template psi-' num2str(i)]);
            xlabel('t->');
            ylabel('A->');
        end
        figure('Name','Decomposed signals');
        for i=1:4
            subplot(4,1,i);
            plot(V(i,:));
            ylim([-6 6]);
            title(['Decomposed Signal -' num2str(i)]);
            xlabel('t->');
            ylabel('A->');
        end 
        figure('Name','Decomposed signals concadinated');
        plot(final_V);
        title('Feature Exxtraction from concadinated Decompostion Signals');
        xlabel('t->');
        ylabel('A->');
        hold on;
        stem(Imax,Vmax);
        hold off;
    end
end