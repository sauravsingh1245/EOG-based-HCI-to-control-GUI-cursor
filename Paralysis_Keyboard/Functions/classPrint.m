function classPrint(class,handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

action={'Unclassified','Up','Down','center','InvoluntaryBlink','Rejection','Left','Right','VoluntaryBlink'};
set(handles.txtCls,'String', action{class+1});

end

