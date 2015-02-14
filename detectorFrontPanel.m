

function varargout = detectorFrontPanel(varargin)
% DETECTORFRONTPANEL MATLAB code for detectorFrontPanel.fig
%      DETECTORFRONTPANEL, by itself, creates a new DETECTORFRONTPANEL or raises the existing
%      singleton*.
%
%      H = DETECTORFRONTPANEL returns the handle to a new DETECTORFRONTPANEL or the handle to
%      the existing singleton*.
%
%      DETECTORFRONTPANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECTORFRONTPANEL.M with the given input arguments.
%
%      DETECTORFRONTPANEL('Property','Value',...) creates a new DETECTORFRONTPANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detectorFrontPanel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detectorFrontPanel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detectorFrontPanel

% Last Modified by GUIDE v2.5 13-Feb-2015 14:24:41
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detectorFrontPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @detectorFrontPanel_OutputFcn, ...
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


% --- Executes just before detectorFrontPanel is made visible.
function detectorFrontPanel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detectorFrontPanel (see VARARGIN)

% Choose default command line output for detectorFrontPanel
handles.HSType = 0;
for i = 1:4  
    handles.engine(i).HeadStage = 1;            % HS for this engine
    handles.engine(i).Channel = 1;              % Channel for this engine
    handles.engine(i).Decimation = i;           % Decimation Factor for this engine
    handles.engine(i).Threshold = 45;           % Threshold for this engine
    handles.engine(i).Filter=[1:64];            % Filter for this engine
    handles.engine(i).Template=[1:32];          % Template for this engine
    handles.engine(i).nFilterCoef = 64;         % number of filter coeff 
    handles.engine(i).FilterFilename = '<none>';     % filter file name
    handles.engine(i).nTemeplatePoints = 32;    % number of template points
    handles.engine(i).TemplateFilename = '<none>';  % template file name
    handles.engine(i).FileEntryChoice = 'Filter';   % filter or template
    handles.engine(i).CurrentGraphSelection = 'None';
end

handles.output = hObject;
    serialPorts = instrhwinfo('serial');
    nPorts = length(serialPorts.SerialPorts);
    if nPorts == 0
        errordlg ('no serial ports found...exiting');
        
        % output the first string to the serial port monitor listbox.
        % don't concatinate because there is nothing there yet
        myString{1} = 'No serial ports found';
        set(handles.SerialMonitorWindow, 'String', myString);
        set(handles.SerialMonitorWindow, 'Value',  1 );
    else    
        set(handles.ComPortSelection, 'String', ...
            [{'Select a port'} ; serialPorts.SerialPorts ]);
    	set(handles.ComPortSelection, 'Value', 2);
        myString{1} = 'Serial Ports Found';
        set(handles.SerialMonitorWindow, 'String', myString);
        set(handles.SerialMonitorWindow, 'Value',  1 );
        set(handles.ProgramEngineButton, 'Visible','Off');
        set(handles.EventSeqButton, 'Visible', 'Off');
        set(handles.WaveformAxis, 'Visible','Off');
        set(handles.ProcessingEnginePanel,'Visible', 'Off');
    end
   % Update handles structure
   handles.output = hObject;
   guidata(hObject, handles);
    

% UIWAIT makes detectorFrontPanel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = detectorFrontPanel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in chanSelectPanel.
function chanSelectPanel_SelectionChangeFcn(hObject, eventdata, handles)
switch get(eventdata.NewValue, 'Tag')
    case 'chanButton1'
        chan = 1;
    case 'chanButton2'
        chan = 2;
    case 'chanButton3'
        chan = 3;
    case 'chanButton4'
        chan = 4;
    case 'chanButton5'
        chan = 5;
    case 'chanButton6'
        chan = 6;
    case 'chanButton7'
        chan = 7;
    case 'chanButton8'
        chan = 8;
    case 'chanButton9'
        chan = 9;
    case 'chanButton10'
        chan = 10;
    case 'chanButton11'
        chan = 11;
    case 'chanButton12'
        chan = 12;
    case 'chanButton13'
        chan = 13;
    case 'chanButton14'
        chan = 14;
    case 'chanButton15'
        chan = 15;
    case 'chanButton16'
        chan = 16;
    case 'chanButton17'
        chan = 17;
    case 'chanButton18'
        chan = 18;
    case 'chanButton19'
        chan = 19;
    case 'chanButton20'
        chan = 20;
    case 'chanButton21'
        chan = 21;
    case 'chanButton22'
        chan = 22;
    case 'chanButton23'
        chan = 23;
    case 'chanButton24'
        chan = 24;
    case 'chanButton25'
        chan = 25;
    case 'chanButton26'
        chan = 26;
    case 'chanButton27'
        chan = 27;
    case 'chanButton28'
        chan = 28;
    case 'chanButton29'
        chan = 29;
    case 'chanButton30'
        chan = 30;
    case 'chanButton31'
        chan = 31;
    case 'chanButton32'
        chan = 32;
    otherwise
        chan = 1;                            % default
end
handles.engine(handles.SelectedEngine).Channel = chan;
guidata(hObject, handles);


    

% hObject    handle to the selected object in chanSelectPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in ComPortSelection.
function ComPortSelection_Callback(hObject, eventdata, handles)
% hObject    handle to ComPortSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ComPortSelection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ComPortSelection
if strcmp(get(handles.figure1, 'SelectionType'), 'open')      
     if strcmp(get(handles.ConnectToggle,'String'),'Connect') % currently disconnected
         CPindex=get(handles.ComPortSelection,'Value');
         if CPindex == 1                                       %fist line is "select " text
             errordlg('Select valid COM port');              % not a serial port name
         else
             comPortList = get(handles.ComPortSelection, 'String');
             comPortName = comPortList{CPindex};
     
             try
                 serConn = serial(comPortName, 'TimeOut', 1, ...
                                                        'BaudRate', 9600);   
                 fopen(serConn);
                 get (serConn,'Status')
                 handles.serConn = serConn;  % store serCon in the handles structure
                 guidata(hObject,handles);
                 % enable Tx text field and Rx button
% %                 set(handles.TX_CMD,                 'Enable', 'On');
% %                 set(handles.rxButton,               'Enable', 'On');
% %                 set(handles.SetFPGAParameters,      'Enable', 'On');
% %                 set(handles.GetFPFAStatus,          'Enable', 'On');
% %                 set(handles.LaserTest,              'Visible', 'On');
% %                 set(handles.LaserTest,              'Enable', 'On');
% %                 set(handles.Start_Stop,             'Enable', 'On');
                  set(handles.ConnectToggle, 'String','Disconnect');
                  set(handles.ConnectToggle, 'Visible', 'On');
                  set(handles.ComPortSelection, 'Visible', 'Off');
                  set(handles.configPanel, 'Visible','On');
             catch e
                 errordlg(e.message);
             end        
         end
     else
% %        set(handles.TX_CMD,             'Enable', 'Off');
% %        set(handles.rxButton,           'Enable', 'Off'); 
% %        set(handles.SetFPGAParameters,  'Enable', 'Off');
% %        set(handles.GetFPFAStatus,      'Enable', 'Off');
        set(handles.ConnectToggle, 'String', 'Connect');
        set(handles.ComPortSelection, 'Visible', 'On');
        fclose(handles.serConn);
     end
end
     guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function ComPortSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ComPortSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when selected object is changed in headStageSelectPanel.
function headStageSelectPanel_SelectionChangeFcn(hObject, eventdata, handles)
switch get(eventdata.NewValue, 'Tag')
    case 'radiobutton69'
        headstage = 1;
    case 'radiobutton70'
        headstage = 2;
    case 'radiobutton71'
        headstage = 3;
    case 'radiobutton72'
        headstage = 4;
    case 'radiobutton114'
        headstage = 5;
    case 'radiobutton115'
        headstage = 6;
    otherwise
        headstage = 1;
end
fprintf('HS Set  %d\n', headstage);
handles.engine(handles.SelectedEngine).HeadStage = headstage;
guidata(hObject, handles);


% --- Executes on button press in ConnectToggle.
function ConnectToggle_Callback(hObject, eventdata, handles)
% hObject    handle to ConnectToggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ConnectToggle
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')                       % connect pushed
% Toggle button is pressed, take appropriate action
% pop up the serial list
    set(handles.ComPortSelection, 'Visible', 'On');         % turn on the list
    set(hObject, 'Visible', 'Off');                         % turn off this button
else                                                        % disconnect pushed
    set(hObject, 'String', 'Connect');                      % change button to say 'connect'
    fclose(handles.serConn);                                % close the serial port
end
guidata(hObject, handles);

% --- Executes on selection change in SerialMonitorWindow.
function SerialMonitorWindow_Callback(hObject, eventdata, handles)
% hObject    handle to SerialMonitorWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SerialMonitorWindow contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SerialMonitorWindow


% --- Executes during object creation, after setting all properties.
function SerialMonitorWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SerialMonitorWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ComPortSelection.
function ComPortSelection_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ComPortSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Runs if the window is closed, just release the serial port
function figure1_CloseRequestFcn(hObject, eventdata, handles)
selection = questdlg('Are you sure you want to close EPSP?',...
'Close Request','Yes','No','Yes');
switch selection
    case 'Yes',
        if isfield(handles, 'serConn')
                 fclose(handles.serConn);
                 delete(handles.serConn);
        end
        fclose ('all');                     % close all files including serial port(important)
        delete(hObject);                    % this closes the GUI
    case 'No'
        return;
end %switch 




% --- Executes during object deletion, before destroying properties.
function EngineSelect_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to EngineSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in EngineSelect.
function EngineSelect_SelectionChangeFcn(hObject, eventdata, handles)

% hObject    handle to the selected object in EngineSelect 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in HSselectPanel.
function HSselectPanel_SelectionChangeFcn(hObject, eventdata, handles)
    
    
    

% hObject    handle to the selected object in HSselectPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ProcessingEnginePanel_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ProcessingEnginePanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in chanSelect16.
function chanSelect16_SelectionChangeFcn(hObject, eventdata, handles)
switch get(eventdata.NewValue, 'Tag')
    case 'chan1'
        chan = 1;
    case 'chan2'
        chan = 2;
    case 'chan3'
        chan = 3;
    case 'chan4'
        chan = 4;
    case 'chan5'
        chan = 5;
    case 'chan6'
        chan = 6;
    case 'chan7'
        chan = 7;
    case 'chan8'
        chan = 8;
    case 'chan9'
        chan = 9;
    case 'chan10'
        chan = 10;
    case 'chan11'
        chan = 11;
    case 'chan12'
        chan = 12;
    case 'chan13'
        chan = 13;
    case 'chan14'
        chan = 14;
    case 'chan15'
        chan = 15;
    case 'chan16'
        chan = 16;
    otherwise
        chan = 1;                            % default
end
handles.engine(handles.SelectedEngine).Channel = chan;
guidata(hObject, handles);
% hObject    handle to the selected object in chanSelect16 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AmpConfigOK.
function AmpConfigOK_Callback(hObject, eventdata, handles)
    switch get(get(handles.HSselectPanel, 'SelectedObject'),'Tag')     % get the tag of selected object
        case 'HS16Button'
            handles.HSType = 16;
        case 'HS32Button'
            handles.HSType = 32;
        otherwise
            handles.HSType = 16;
    end
    % turn on HS 1 button, all others off
    set(handles.radiobutton69, 'Visible', 'On');
    set(handles.radiobutton70, 'Visible', 'Off');
    set(handles.radiobutton71, 'Visible', 'Off');
    set(handles.radiobutton72, 'Visible', 'Off');
    set(handles.radiobutton114, 'Visible', 'Off');
    set(handles.radiobutton115, 'Visible', 'Off');

    switch get(get(handles.numHSgroup, 'SelectedObject'),'Tag')
        case 'numHS1'
            handles.NumHS = 1;
        case 'numHS2'
            handles.NumHS = 2;
            set(handles.radiobutton70, 'Visible', 'On');
        case 'numHS3'
            handles.NumHS = 3;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.radiobutton71, 'Visible', 'On');
       case 'numHS4'
            handles.NumHS = 4;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.radiobutton71, 'Visible', 'On');
            set(handles.radiobutton72, 'Visible', 'On');
        case 'numHS5'
            handles.NumHS = 5;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.radiobutton71, 'Visible', 'On');
            set(handles.radiobutton72, 'Visible', 'On');
            set(handles.radiobutton114, 'Visible', 'On');
        case 'numHS6'
            handles.NumHS = 6;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.radiobutton71, 'Visible', 'On');
            set(handles.radiobutton72, 'Visible', 'On');
            set(handles.radiobutton114, 'Visible', 'On');
            set(handles.radiobutton115, 'Visible', 'On');
        otherwise
            handles.NumHS = 1;
    end
    
guidata(hObject, handles);          % this saves data stored in 'handles'
set(handles.configPanel, 'Visible', 'Off')
set(handles.ProgramEngineButton, 'Visible', 'On');
set(handles.EventSeqButton, 'Visible', 'On');
handles.HSType
handles.NumHS

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over AmpConfigOK.
function AmpConfigOK_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to AmpConfigOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in numHSgroup.
function numHSgroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in numHSgroup 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)



function DecimationEntry_Callback(hObject, eventdata, handles)
% hObject    handle to DecimationEntry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DecimationEntry as text
handles.engine(handles.SelectedEngine).Decimation = ...
                                         str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function DecimationEntry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DecimationEntry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in EngineSelectOK.
function EngineSelectOK_Callback(hObject, eventdata, handles)
switch get(get(handles.EngineSelect, 'SelectedObject'),'Tag')
    case 'EngOne'
        handles.SelectedEngine = 1;
    case 'EngTwo'
        handles.SelectedEngine = 2;
    case 'EngThree'
        handles.SelectedEngine = 3;
    case 'EngFour'
        handles.SelectedEngine = 4;
    otherwise
        handles.SelectedEngine = 1;
end
guidata(hObject, handles);  % save user data in handles
set(handles.EngineSelect,'Visible', 'Off');
populateEnginePanel(hObject, eventdata, handles);
set(handles.ProcessingEnginePanel, 'Visible', 'On');
guidata(hObject, handles);  % save user data in handles
% PutUpPresetProcessingEnginePanel(handles);
guidata(hObject, handles);  % save user data in handles

% put up appropriate HS channel selection panel
if (handles.HSType == 16)
    set(handles.chanSelect16, 'Visible', 'On');
    set(handles.chanSelectPanel, 'Visible', 'Off');
elseif(handles.HSType == 32)
    set(handles.chanSelect16, 'Visible', 'Off');
    set(handles.chanSelectPanel, 'Visible', 'On');
else
    set(handles.chanSelect16, 'Visible', 'On');
    set(handles.chanSelectPanel, 'Visible', 'Off');
end



% --- Executes on button press in EnginePanelOK.
function EnginePanelOK_Callback(hObject, eventdata, handles)
% hObject    handle to EnginePanelOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setEngineHardware(hObject,eventdata,handles);
set(handles.ProcessingEnginePanel,'Visible', 'Off');
set(handles.ProgramEngineButton, 'Visible','On');
set(handles.EventSeqButton, 'Visible', 'On');
set(handles.SerialMonitorWindow, 'Visible', 'On');

% --- Executes on button press in ProgramEngineButton.
function ProgramEngineButton_Callback(hObject, eventdata, handles)
% hObject    handle to ProgramEngineButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.EngineSelect, 'Visible', 'On');
set(handles.ProgramEngineButton, 'Visible','Off');
set(handles.EventSeqButton, 'Visible', 'Off');



% --- Executes on button press in SelectFilterButton.
function SelectFilterButton_Callback(hObject, eventdata, handles)
% set(handles.EngineWaveformListbox, 'Visible', 'On');
handles.engine(handles.SelectedEngine).FileEntryChoice ='Filter';
% load the listbox with contents of current directory
d = dir(pwd());
set(handles.EngineWaveformListbox, 'Value', 1);
set(handles.EngineWaveformListbox, 'String',{d.name});
guidata(hObject, handles);

% Return figure handle as first output argument   
% UIWAIT makes lbox2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Executes on button press in SelectTemplateButton.
function SelectTemplateButton_Callback(hObject, eventdata, handles)
% set(handles.EngineWaveformListbox, 'Visible', 'On');
handles.engine(handles.SelectedEngine).FileEntryChoice ='Template';
% load the listbox with contents of current directory
d = dir(pwd());
set(handles.EngineWaveformListbox, 'Value', 1);
set(handles.EngineWaveformListbox, 'String',{d.name});
guidata(hObject, handles);

% --- Executes on selection change in EngineWaveformListbox.
function EngineWaveformListbox_Callback(hObject, eventdata, handles)
% hObject    handle to EngineWaveformListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns EngineWaveformListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from EngineWaveformListbox
fprintf ('engine waveform callback\n');
ProcessListboxEntry(hObject, eventdata, handles);
fprintf ('back from process listbox entry\n');


% --- Executes during object creation, after setting all properties.
function EngineWaveformListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EngineWaveformListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ThresholdEdit_Callback(hObject, eventdata, handles)
% hObject    handle to ThresholdEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.engine(handles.SelectedEngine).Threshold = ...
                                         str2double(get(hObject,'String'));
fprintf('threshold %d\n', handles.engine(handles.SelectedEngine).Threshold);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function ThresholdEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ThresholdEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in GraphChoiceButtons.
function GraphChoiceButtons_SelectionChangeFcn(hObject, eventdata, handles)
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
switch get(eventdata.NewValue, 'Tag')
    case 'GraphFilterButton'
        handles.engine(handles.SelectedEngine).CurrentGraphSelection = 'Filter';
        plot(handles.WaveformAxis, handles.engine(handles.SelectedEngine).Filter);
    case 'GraphTemplateButton'
        handles.engine(handles.SelectedEngine).CurrentGraphSelection = 'Template';
        plot(handles.WaveformAxis, handles.engine(handles.SelectedEngine).Template);
    otherwise
end
% update data structure
guidata(hObject, handles);


% --- Executes on button press in EventSeqButton.
function EventSeqButton_Callback(hObject, eventdata, handles)
% hObject    handle to EventSeqButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over EventSeqButton.
function EventSeqButton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to EventSeqButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on EngineWaveformListbox and none of its controls.
function EngineWaveformListbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to EngineWaveformListbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)






% --- Executes on key press with focus on EnginePanelOK and none of its controls.
function EnginePanelOK_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to EnginePanelOK (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
