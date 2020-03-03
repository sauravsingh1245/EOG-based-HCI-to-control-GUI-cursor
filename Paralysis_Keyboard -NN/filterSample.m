function [filter_x] = filterSample(x,plotStream)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[ch,~]=size(x);
fs=960;
nf=5;                           % filter order for notch filter
fn=60;                          % notch filter center frequency
Qf=30;                          % quality factor for notch filter
swt_lvl=6;

df=fn/Qf;
Wn=[fn-df/2 fn+df/2];
[bn,an]=butter(nf,2*Wn/fs,'stop');

filter_x=filter(bn,an,x);  % appplying Filtering
for i=1:ch
        [swa,~] = swt(filter_x(i,:),swt_lvl,'db1');                     % applying SWT for denoising
        filter_x(i,:)=swa(swt_lvl,:);
end
if plotStream
    figure('Name','Filtering Sample');
    for i=1:ch
        subplot(ch,2,2*i-1);
        plot(x(i,:));
        ylim([-6 6]);
        title(['Noisy EOG Signal CH-' num2str(i)]);
        xlabel('t->');
        ylabel('A->');
        subplot(ch,2,2*i);
        plot(filter_x(i,:));
        ylim([-6 6]);
        title(['Denoised EOG Signal CH-' num2str(i)]);
        xlabel('t->');
        ylabel('A->');
    end
end
end

