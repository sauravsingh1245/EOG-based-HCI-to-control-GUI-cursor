function varargout = paraKeyboard(varargin)
%PARAKEYBOARD MATLAB code file for paraKeyboard.fig
%      PARAKEYBOARD, by itself, creates a new PARAKEYBOARD or raises the existing
%      singleton*.
%
%      H = PARAKEYBOARD returns the handle to a new PARAKEYBOARD or the handle to
%      the existing singleton*.
%
%      PARAKEYBOARD('Property','Value',...) creates a new PARAKEYBOARD using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to paraKeyboard_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PARAKEYBOARD('CALLBACK') and PARAKEYBOARD('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PARAKEYBOARD.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help paraKeyboard

% Last Modified by GUIDE v2.5 14-Apr-2018 12:15:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @paraKeyboard_OpeningFcn, ...
                   'gui_OutputFcn',  @paraKeyboard_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before paraKeyboard is made visible.
function paraKeyboard_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for paraKeyboard
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes paraKeyboard wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global svm;
initGlobals();
svm=SVMsetup;
reset_keyboard(handles);

% --- Outputs from this function are returned to the command line.
function varargout = paraKeyboard_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnBrowse.
function btnBrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.xlsx','Select Input Signal File');
set(handles.txtinputPath,'String',[PathName FileName]);


function txtinputPath_Callback(hObject, eventdata, handles)
% hObject    handle to txtinputPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtinputPath as text
%        str2double(get(hObject,'String')) returns contents of txtinputPath as a double


% --- Executes during object creation, after setting all properties.
function txtinputPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtinputPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnProcess.
function btnProcess_Callback(hObject, eventdata, handles)
% hObject    handle to btnProcess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global axisMetaData svm keyboard cursor msg speech;

pause(0.1);    
channelNumbers=2;
fs=960;
time=1;
t=0:1/fs:time-1/fs;
FilePath = get(handles.txtinputPath,'String');
noisyx=xlsread(FilePath);
x=filterSample(noisyx,false);

for i=1:channelNumbers
   subplot(channelNumbers,1,i);
   plot(t,noisyx(i,:));
   if axisMetaData(1,i)==1
      ylim([axisMetaData(3,i) axisMetaData(4,i)]);
   end
   ylabel('A ->');
   xlabel('time ->');
   title(['CH-' num2str(i)]);
end
        
%implement classification here; 
fm=featureExtractor(x,false);
y=ClassPredict(svm,fm);

classPrint(y,handles);
if y==1 || y==2 || y==6 || y==7
    cursor = moveCursor(y,cursor);
    setKeyboard(handles);
elseif y==8
    [msg,speech]=msgHandle(msg,cursor,keyboard);
    msgPrint(msg,handles);
    if speech
        tts(msg,'Microsoft Zira Desktop - English (United States)',0,44100);
        msg=[];
        pause(0.5);
        msgPrint(msg,handles);
        speech=0;
    end
end

pause(0.080);






function txtMinY_Callback(hObject, eventdata, handles)
% hObject    handle to txtMinY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMinY as text
%        str2double(get(hObject,'String')) returns contents of txtMinY as a double


% --- Executes during object creation, after setting all properties.
function txtMinY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMinY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtMaxY_Callback(hObject, eventdata, handles)
% hObject    handle to txtMaxY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMaxY as text
%        str2double(get(hObject,'String')) returns contents of txtMaxY as a double


% --- Executes during object creation, after setting all properties.
function txtMaxY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMaxY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSetAxis.
function btnSetAxis_Callback(hObject, eventdata, handles)
% hObject    handle to btnSetAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global axisMetaData;
ch = get(handles.chAxis,'Value');
axisMetaData(1,ch)=1;
axisMetaData(3,ch)=str2double(get(handles.txtMinY,'String'));
axisMetaData(4,ch)=str2double(get(handles.txtMaxY,'String'));


% --- Executes on selection change in chAxis.
function chAxis_Callback(hObject, eventdata, handles)
% hObject    handle to chAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns chAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chAxis


% --- Executes during object creation, after setting all properties.
function chAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function txtMsg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMsg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
