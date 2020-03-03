function setKeyboard(handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
global keyboard cursor; 

set(handles.textA,'BackgroundColor','white');
set(handles.textB,'BackgroundColor','white');
set(handles.textC,'BackgroundColor','white');
set(handles.textD,'BackgroundColor','white');
set(handles.textE,'BackgroundColor','white');
set(handles.textF,'BackgroundColor','white');
set(handles.textG,'BackgroundColor','white');
set(handles.textH,'BackgroundColor','white');
set(handles.textI,'BackgroundColor','white');
set(handles.textJ,'BackgroundColor','white');
set(handles.textK,'BackgroundColor','white');
set(handles.textL,'BackgroundColor','white');
set(handles.textM,'BackgroundColor','white');
set(handles.textN,'BackgroundColor','white');
set(handles.textO,'BackgroundColor','white');
set(handles.textP,'BackgroundColor','white');
set(handles.textQ,'BackgroundColor','white');
set(handles.textR,'BackgroundColor','white');
set(handles.textS,'BackgroundColor','white');
set(handles.textT,'BackgroundColor','white');
set(handles.textU,'BackgroundColor','white');
set(handles.textV,'BackgroundColor','white');
set(handles.textW,'BackgroundColor','white');
set(handles.textX,'BackgroundColor','white');
set(handles.textY,'BackgroundColor','white');
set(handles.textZ,'BackgroundColor','white');
set(handles.textspace,'BackgroundColor','white');
set(handles.textback,'BackgroundColor','white');
set(handles.textenter,'BackgroundColor','white');


c=keyboard(cursor==1);
switch c
    case 'A'
        set(handles.textA,'BackgroundColor','yellow');
    case 'B'
        set(handles.textB,'BackgroundColor','yellow');
    case 'C'
        set(handles.textC,'BackgroundColor','yellow');
    case 'D'
        set(handles.textD,'BackgroundColor','yellow');
    case 'E'
        set(handles.textE,'BackgroundColor','yellow');
    case 'F'
        set(handles.textF,'BackgroundColor','yellow');
    case 'G'
        set(handles.textG,'BackgroundColor','yellow');
    case 'H'
        set(handles.textH,'BackgroundColor','yellow');
    case 'I'
        set(handles.textI,'BackgroundColor','yellow');
    case 'J'
        set(handles.textJ,'BackgroundColor','yellow');
    case 'K'
        set(handles.textK,'BackgroundColor','yellow');
    case 'L'
        set(handles.textL,'BackgroundColor','yellow');
    case 'M'
        set(handles.textM,'BackgroundColor','yellow');
    case 'N'
        set(handles.textN,'BackgroundColor','yellow');
    case 'O'
        set(handles.textO,'BackgroundColor','yellow');
    case 'P'
        set(handles.textP,'BackgroundColor','yellow');
    case 'Q'
        set(handles.textQ,'BackgroundColor','yellow');
    case 'R'
        set(handles.textR,'BackgroundColor','yellow');
    case 'S'
        set(handles.textS,'BackgroundColor','yellow');
    case 'T'
        set(handles.textT,'BackgroundColor','yellow');
    case 'U'
        set(handles.textU,'BackgroundColor','yellow');
    case 'V'
        set(handles.textV,'BackgroundColor','yellow');
    case 'W'
        set(handles.textW,'BackgroundColor','yellow');
    case 'X'
        set(handles.textX,'BackgroundColor','yellow');
    case 'Y'
        set(handles.textY,'BackgroundColor','yellow');
    case 'Z'
        set(handles.textZ,'BackgroundColor','yellow');
    case '#'
        set(handles.textback,'BackgroundColor','yellow');
    case '$'
        set(handles.textenter,'BackgroundColor','yellow');
    otherwise
        set(handles.textspace,'BackgroundColor','yellow');
end

end