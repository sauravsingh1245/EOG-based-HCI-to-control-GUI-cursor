function [cursor] = moveCursor(label,cursor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

action={'Up','Down','center','InvoluntaryBlink','Rejection','Left','Right','VoluntaryBlink'};
switch label
    case 1
        cursor=[cursor(2:end,:);cursor(1,:)];
    case 2
        cursor=[cursor(end,:);cursor(1:end-1,:)];
    case 6
        cursor=[cursor(:,2:end) cursor(:,1)];
    case 7
        cursor=[cursor(:,end) cursor(:,1:end-1)];
    otherwise
end

end

