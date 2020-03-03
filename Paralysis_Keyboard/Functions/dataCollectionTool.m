function varargout = dataCollectionTool(varargin)
% DATACOLLECTIONTOOL MATLAB code for dataCollectionTool.fig
%      DATACOLLECTIONTOOL, by itself, creates a new DATACOLLECTIONTOOL or raises the existing
%      singleton*.
%
%      H = DATACOLLECTIONTOOL returns the handle to a new DATACOLLECTIONTOOL or the handle to
%      the existing singleton*.
%
%      DATACOLLECTIONTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATACOLLECTIONTOOL.M with the given input arguments.
%
%      DATACOLLECTIONTOOL('Property','Value',...) creates a new DATACOLLECTIONTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dataCollectionTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dataCollectionTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dataCollectionTool

% Last Modified by GUIDE v2.5 09-Mar-2018 20:32:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dataCollectionTool_OpeningFcn, ...
                   'gui_OutputFcn',  @dataCollectionTool_OutputFcn, ...
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


% --- Executes just before dataCollectionTool is made visible.
function dataCollectionTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dataCollectionTool (see VARARGIN)

% Choose default command line output for dataCollectionTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dataCollectionTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);
initGlobals();
global timeAxis dataset data label axisMetaData test taskSub processingEN sampleNo;
timeAxis=[];
dataset=[];
data=[];
label=[];
axisMetaData=zeros(4,15);
sampleNo=1;

% program purpose control variables
test=true;         % test GUI without BioRadio150 with random signal
taskSub=true;       % save function for data collection task submission
processingEN=true;  % enable signal processing before ploting and saving

% --- Outputs from this function are returned to the command line.
function varargout = dataCollectionTool_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in btnCapture.
function btnCapture_Callback(hObject, eventdata, handles)
% hObject    handle to btnCapture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data timeAxis dataset label axisMetaData taskSub sampleNo;

lblno = get(handles.lblNumber,'Value');
channelNumbers=length(data(:,1));
for i=1:channelNumbers
   subplot(channelNumbers,2,2*i);
   plot(timeAxis,data(i,:));
   if axisMetaData(1,i)==1
       ylim([axisMetaData(3,i) axisMetaData(4,i)]);
   end
   ylabel('A ->');
   xlabel('time ->');
   title(['CH-' num2str(i) ' for label# ' num2str(lblno) '  (Captured)']);
end

if taskSub
    dataset=data;
else
    dataset = [dataset;data];
end
label = [label; [sampleNo*ones(channelNumbers,1) (1:1:channelNumbers)' lblno*ones(channelNumbers,1)]];
sampleNo=sampleNo+1;



% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataset label taskSub;
 fs = str2double(get(handles.txtSamplefreq,'String'));
 time = str2double(get(handles.txtTime,'String'));
 collectionInterval = fs*time;
 saveFileName=get(handles.txtFileSave,'String');
 tempFileName=saveFileName;
 i=0;
 
 if taskSub
      while(exist([tempFileName '.xlsx'],'file'))
        tempFileName=[saveFileName num2str(i)];
        i=i+1;
      end
      saveFileName=tempFileName;
      xlswrite([saveFileName '.xlsx'],dataset);
     dataset=[];
     label=[];
 else
     while(exist([tempFileName '.mat'],'file'))
       tempFileName=[saveFileName num2str(i)];
       i=i+1;
     end
     saveFileName=tempFileName;
    save([saveFileName '.mat'],'dataset','fs','time','collectionInterval','label');
 end


function txtFileSave_Callback(hObject, eventdata, handles)
% hObject    handle to txtFileSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtFileSave as text
%        str2double(get(hObject,'String')) returns contents of txtFileSave as a double


% --- Executes during object creation, after setting all properties.
function txtFileSave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtFileSave (see GCBO)
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
set(handles.txtDLLPath,'String',PathName);


function txtDLLPath_Callback(hObject, eventdata, handles)
% hObject    handle to txtDLLPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtDLLPath as text
%        str2double(get(hObject,'String')) returns contents of txtDLLPath as a double


% --- Executes during object creation, after setting all properties.
function txtDLLPath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtDLLPath (see GCBO)
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

global bioRadioHandle isCollecting data timeAxis axisMetaData test processingEN;

buttonString = get(handles.btnConnect,'String');
if( strcmp(buttonString,'Connect') )
        
    % Get Configuration info
    dllPath = get(handles.txtDLLPath,'String');
    
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

    % Change the Button
    set(handles.btnConnect,'String', 'Disconnect');
    set(handles.btnConnect,'Enable','on');
    pause(0.1);

    % Set the collecting flag
    isCollecting = 1;
    % Setup the intial collection interval
    fs = str2double(get(handles.txtSamplefreq,'String'));
    time = str2double(get(handles.txtTime,'String'));
    collectionInterval = fs*time;
    
    % filter initialization
    if processingEN
        fn=60;                          % notch filter center frequency
        Qf=30;                          % quality factor for notch filter
        nf=6;
        df=fn/Qf;
        Wn=[fn-df/2 fn+df/2];
        [bn,an]=butter(nf,2*Wn/fs,'stop');
        lvl=6;                          % SWT level
        % **********************
    end

    if test
         channelNumbers=3;
    else
        currentData = collectBioRadioData();          % Collected Data
        channelNumbers=length(currentData(:,1));      % Number of Channels received from BioRadio 150
    end
    rawData = zeros(channelNumbers,collectionInterval); % Initial Data Matrix
    t=0:1/fs:time -1/fs;
    timeAxis=t;
    lblno = get(handles.lblNumber,'Value');
    for i=1:channelNumbers*2
       subplot(channelNumbers,2,i);
       plot(t,rawData(1,:));
       ch=ceil(i/2);
       if axisMetaData(1,ch)==1
           ylim([axisMetaData(3,ch) axisMetaData(4,ch)]);
       end
       ylabel('A ->');
       xlabel('time ->');
       if rem(i,2)~=0
        title(['CH-' num2str(i)]);
       else
        title(['CH-' num2str(i/2) ' for label# ' num2str(lblno) '  (Captured)']);
       end
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
        
        offset=axisMetaData(2,1:channelNumbers)';
        data=rawData + offset*ones(1,collectionInterval);
        if processingEN
            data=data-mean(data,2)*ones(1,collectionInterval);          % removing DC component
            data=filter(bn,an,data);  % appplying Filtering
            for i=1:channelNumbers
                [swa,swd] = swt(data(i,:),lvl,'db1');                     % applying SWT for denoising
                data(i,:)=swa(lvl,:);
            end
        end
        for i=1:channelNumbers
           subplot(channelNumbers,2,2*i-1);
           plot(t,data(i,:));
           if axisMetaData(1,i)==1
              ylim([axisMetaData(3,i) axisMetaData(4,i)]);
           end
           ylabel('A ->');
           xlabel('time ->');
           title(['CH-' num2str(i)]);
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


% --- Executes on selection change in lblNumber.
function lblNumber_Callback(hObject, eventdata, handles)
% hObject    handle to lblNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lblNumber contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lblNumber


% --- Executes during object creation, after setting all properties.
function lblNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lblNumber (see GCBO)
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



function txtOffset_Callback(hObject, eventdata, handles)
% hObject    handle to txtOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtOffset as text
%        str2double(get(hObject,'String')) returns contents of txtOffset as a double


% --- Executes during object creation, after setting all properties.
function txtOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtOffset (see GCBO)
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
axisMetaData(2,ch)=str2double(get(handles.txtOffset,'String'));
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
