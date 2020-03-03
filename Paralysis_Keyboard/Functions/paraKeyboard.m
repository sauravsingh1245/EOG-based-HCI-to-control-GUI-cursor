function varargout = paraKeyboard(varargin)
% PARAKEYBOARD MATLAB code for paraKeyboard.fig
%      PARAKEYBOARD, by itself, creates a new PARAKEYBOARD or raises the existing
%      singleton*.
%
%      H = PARAKEYBOARD returns the handle to a new PARAKEYBOARD or the handle to
%      the existing singleton*.
%
%      PARAKEYBOARD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAKEYBOARD.M with the given input arguments.
%
%      PARAKEYBOARD('Property','Value',...) creates a new PARAKEYBOARD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before paraKeyboard_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to paraKeyboard_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help paraKeyboard

% Last Modified by GUIDE v2.5 13-Apr-2018 16:48:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @paraKeyboard_OpeningFcn, ...
                   'gui_OutputFcn',  @paraKeyboard_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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
% varargin   command line arguments to paraKeyboard (see VARARGIN)

% Choose default command line output for paraKeyboard
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes paraKeyboard wait for user response (see UIRESUME)
% uiwait(handles.figure1);
initGlobals();

% --- Outputs from this function are returned to the command line.
function varargout = paraKeyboard_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtSamplefreq_Callback(hObject, eventdata, handles)
% hObject    handle to txtSamplefreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSamplefreq as text
%        str2double(get(hObject,'String')) returns contents of txtSamplefreq as a double


% --- Executes during object creation, after setting all properties.
function txtSamplefreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSamplefreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtTime_Callback(hObject, eventdata, handles)
% hObject    handle to txtTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtTime as text
%        str2double(get(hObject,'String')) returns contents of txtTime as a double


% --- Executes during object creation, after setting all properties.
function txtTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnDLLPath.
function btnDLLPath_Callback(hObject, eventdata, handles)
% hObject    handle to btnDLLPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.dll','Select BioRadio DLL');
set(handles.lblDLLPath,'String',PathName);


function txtDLLPath_Callback(hObject, eventdata, handles)
% hObject    handle to lblDLLPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lblDLLPath as text
%        str2double(get(hObject,'String')) returns contents of lblDLLPath as a double

% --- Executes during object creation, after setting all properties.
function txtDLLPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lblDLLPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function lblDLLPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lblDLLPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnConnect.
function btnConnect_Callback(hObject, eventdata, handles)
% hObject    handle to btnConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bioRadioHandle isCollecting axisMetaData test processingEN keyboard cursor rawdata msg speech;
buttonString = get(handles.btnConnect,'String');
if( strcmp(buttonString,'Connect') )
        
    % Get Configuration info
    dllPath = get(handles.lblDLLPath,'String');
    
    portNames = get(handles.cboPortName,'String');
    portSel = get(handles.cboPortName,'Value');
    portName = portNames{portSel};

    % Change the Button
    set(handles.btnConnect,'String', 'Connecting');
    set(handles.btnConnect,'Enable','off');

    pause(0.1);

    % Connect to the Radio
    if ~test
        bioRadioHandle = connectBioRadio(dllPath,portName);
    end
    
    % train SVM
    
    svm=SVMsetup();
    
    % Change the Button
    set(handles.btnConnect,'String', 'Disconnect');
    set(handles.btnConnect,'Enable','on');
    pause(0.1);

    % Set the collecting flag
    isCollecting = 1;
    % Setup the intial collection interval
    reset_keyboard(handles);
    fs = str2double(get(handles.txtSamplefreq,'String'));
    time = str2double(get(handles.txtTime,'String'));
    collectionInterval = fs*time;
    
    if test
         channelNumbers=2;
    else
        currentData = collectBioRadioData();          % Collected Data
        channelNumbers=length(currentData(:,1));      % Number of Channels received from BioRadio 150
    end
    
    rawData = zeros(channelNumbers,collectionInterval); % Initial Data Matrix
    t=0:1/fs:time -1/fs;
    for i=1:channelNumbers
       subplot(channelNumbers,1,i);
       plot(t,rawData(1,:));
       if axisMetaData(1,i)==1
           ylim([axisMetaData(3,i) axisMetaData(4,i)]);
       end
       ylabel('A ->');
       xlabel('time ->');
       title(['CH-' num2str(i)]);
    end
    
    while( isCollecting == 1 )
        % Get the current collection interval size
        windowSize = collectionInterval;
        
        % Collect the channel data from the BioRadio
        if test
            currentData=ones(channelNumbers,ceil(collectionInterval/10))*rand(ceil(collectionInterval/10));
        else
            currentData = collectBioRadioData();  
        end
        rawData = horzcat(rawData, currentData);
        
        % Get the total Size of the concatinated data
        tSize= length( rawData(1,:) );
        if windowSize > tSize
            % Pad with zeros
            rawData = horzcat( zeros(channelNumbers,windowSize-tSize), rawData );
        else
            % Resize data to specified window size padding zeros if need be
            rawData = rawData(1:channelNumbers,tSize-windowSize+1:tSize);
        end
        rawdata=rawData;
        offset=axisMetaData(2,1:channelNumbers)';
        data=rawData - offset*ones(1,collectionInterval);
        
        if processingEN
            data=filterSample(data,false);
        end
        
        for i=1:channelNumbers
           subplot(channelNumbers,1,i);
           plot(t,data(i,:));
           if axisMetaData(1,i)==1
              ylim([axisMetaData(3,i) axisMetaData(4,i)]);
           end
           ylabel('A ->');
           xlabel('time ->');
           title(['CH-' num2str(i)]);
        end
        
        event_detect=0;
        
        event_detect=detectEvent(data,[2 2],[100 860]);
        if ~event_detect
            set(handles.txtCls,'String', 'No Event');
            repeat=0;
        end
        
        %implement classification here; 
        if event_detect && ~repeat
            repeat=1;
            fm=featureExtractor(data,false);
            y=ClassPredict(svm,fm);
            classPrint(y,handles);
            set(handles.txtCls,'String', 'No Event');
            if y==1 || y==2 || y==6 || y==7
                cursor = moveCursor(y,cursor);
                setKeyboard(handles);
            elseif y==8
                [msg,speech]=msgHandle(msg,cursor,keyboard);
                msgPrint(msg,handles);
                if speech
                    tts(msg,'Microsoft Zira Desktop - English (United States)',0,44100);
                    msg=[];
                    speech=0;
                end
            end
            event_detect=0;
        end
        
        pause(0.080);
    end
else
    
    % Change the Button
    set(handles.btnConnect,'String', 'Disconnecting');
    set(handles.btnConnect,'Enable','off');
    pause(0.1);
    
    if ~test
        disconnectBioRadio(bioRadioHandle);
    end
    
    isCollecting = 0;
     
    % Flag that radio is disconnected
    bioRadioHandle = -1;
    
    % Change the Button
    set(handles.btnConnect,'String', 'Connect');
    set(handles.btnConnect,'Enable','on');
    pause(0.1);
    
end

% --- Executes on selection change in cboPortName.
function cboPortName_Callback(hObject, eventdata, handles)
% hObject    handle to cboPortName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cboPortName contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cboPortName


% --- Executes during object creation, after setting all properties.
function cboPortName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cboPortName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in btnCalibrate.
function btnCalibrate_Callback(hObject, eventdata, handles)
% hObject    handle to btnCalibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global axisMetaData rawdata;
ch = get(handles.chAxis,'Value');
axisMetaData(2,ch)=mean(rawdata(ch,:));


function txtMsg_Callback(hObject, eventdata, handles)
% hObject    handle to txtMsg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtMsg as text
%        str2double(get(hObject,'String')) returns contents of txtMsg as a double


% --- Executes during object creation, after setting all properties.
function txtMsg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtMsg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
