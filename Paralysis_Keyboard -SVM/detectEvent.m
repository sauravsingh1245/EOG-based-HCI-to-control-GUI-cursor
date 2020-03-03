function [ event ] = detectEvent( x, TH, W )
% TH=[TH1 TH2] Threshold
% W=[Wstart Wend] window

event=0;
t1=find(abs(x(1,:))>TH(1));
t2=find(abs(x(2,:))>TH(2));
if length(t1)>=2
    if W(1)<t1(1) %&& W(2)>t1(end)
        event=1;
    end
end

if length(t2)>=2
    if W(1)<t2(1) %&& W(2)>t2(end)
        event=1;
    end
end

end

