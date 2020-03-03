function reset_keyboard(handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global cursor;

cursor=zeros(5,7);
cursor(4,7)=1;

setKeyboard(handles);

end

