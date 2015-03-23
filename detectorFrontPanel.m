

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

% Last Modified by GUIDE v2.5 17-Feb-2015 19:10:30
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
    handles.engine(i).nTemplatePoints = 32;    % number of template points
    handles.engine(i).TemplateFilename = '<none>';  % template file name
    handles.engine(i).FileEntryChoice = 'Filter';   % filter or template
    handles.engine(i).CurrentGraphSelection = 'None';
end

handles.selectedDtoAChannel = 1;
for i=1:4
    handles.dtoaChan(i).active = 0;
    handles.dtoaChan(i).ChannelData = 1;            % 0 if Engine Data, 1 if Channel Data
    handles.dtoaChan(i).HS = 1;                     % if Channel Data this is the HS
    handles.dtoaChan(i).Channel = 1;                    % if CHannel Data this is the channel on the HS 
    handles.dtoaChan(i).Engine = 1;                     % if Engine Data, this is the Engine #
    handles.dtoaChan(i).Filter = 1;                 % 0 if LSD output, 1 if Filter output
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
        set (handles.ProgramScope, 'Visible', 'Off');
        set (handles.DtoAPanel, 'Visible', 'Off');
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
chan = sscanf(get(hObject, 'String'), '%d', 1);
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


% --- Executes on selection change in ComPortSelection.
function ComPortSelection_Callback(hObject, eventdata, handles)
% hObject    handle to ComPortSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ComPortSelection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ComPortSelection
if strcmp(get(handles.figure1, 'SelectionType'), 'open')      
     if strcmp(get(handles.ConnectToggle,'String'),'Connect') % if it says 'connect' then currently disconnected
         CPindex=get(handles.ComPortSelection,'Value');
         if CPindex == 1                                       %first line is "select " text
             errordlg('Select valid COM port');              % not a serial port name
         else
             comPortList = get(handles.ComPortSelection, 'String');
             comPortName = comPortList{CPindex};
     
             try
                 serConn = serial(comPortName, 'TimeOut', 1, ...
                                                        'BaudRate', 9600);
                 handles.serConn = serConn;
                 guidata(hObject,handles);
                 handles.serConn.BytesAvailableFcnMode = 'terminator';                      % set serial port to 'event' on a terminator
                 handles.serConn.BytesAvailableFcn = {@serialLineCallback, handles};                   %assign the event callback function
                 
                 fprintf ('about to open serConn\n');
                 fopen(serConn);
                 get (serConn,'Status')
                 guidata(hObject,handles);
                  set(handles.ConnectToggle, 'String','Disconnect');
                  set(handles.ConnectToggle, 'Visible', 'On');
                  set(handles.ComPortSelection, 'Visible', 'Off');
                  set(handles.configPanel, 'Visible','On');
             catch e
                 errordlg(e.message);
             end        
         end
     else
        set(handles.ConnectToggle, 'String', 'Connect');
        set(handles.ComPortSelection, 'Visible', 'On');
        fclose(handles.serConn);
     end
end
     guidata(hObject, handles);
     try 
        RxText = fscanf(handles.serConn);
        if length(RxText) >= 1
            currList = get(handles.SerialMonitorWindow, 'String');
            currList = cat(1,get(handles.SerialMonitorWindow, 'String'), {RxText});
            set(handles.SerialMonitorWindow, 'String', currList);
            set(handles.SerialMonitorWindow, 'Value', length(currList) );
        end
    catch e
        disp(e)
end

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
headstage = sscanf(get(hObject, 'String'),'HS %d', 1);
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
chan = sscanf(get(hObject, 'String'), '%d', 1)
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
    % this section turns off the visibility of the HS buttons that are not
    % valid based on the number of headstages entered
    % turn on HS 1 button, all others off
    set(handles.radiobutton69, 'Visible', 'On');
    set(handles.radiobutton70, 'Visible', 'Off');
    set(handles.radiobutton71, 'Visible', 'Off');
    set(handles.radiobutton72, 'Visible', 'Off');
    set(handles.radiobutton114, 'Visible', 'Off');
    set(handles.radiobutton115, 'Visible', 'Off');
    
    % only light up HS buttons that are valid, there are two panels with HS
    % buttons, one for selecting Engine HS(above) and second(below) for DtoA channel HS
    
    set(handles.DHS1, 'Visible', 'On');
    set(handles.DHS2, 'Visible', 'Off');
    set(handles.DHS3, 'Visible', 'Off');
    set(handles.DHS4, 'Visible', 'Off');
    set(handles.DHS5, 'Visible', 'Off');
    set(handles.DHS6, 'Visible', 'Off');

    switch get(get(handles.numHSgroup, 'SelectedObject'),'Tag')
        case 'numHS1'
            handles.NumHS = 1;
        case 'numHS2'
            handles.NumHS = 2;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.DHS2, 'Visible', 'On');
        case 'numHS3'
            handles.NumHS = 3;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.radiobutton71, 'Visible', 'On');
            set(handles.DHS2, 'Visible', 'On');
            set(handles.DHS3, 'Visible', 'On');
       case 'numHS4'
            handles.NumHS = 4;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.radiobutton71, 'Visible', 'On');
            set(handles.radiobutton72, 'Visible', 'On');
            set(handles.DHS2, 'Visible', 'On');
            set(handles.DHS3, 'Visible', 'On');
            set(handles.DHS4, 'Visible', 'On');
        case 'numHS5'
            handles.NumHS = 5;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.radiobutton71, 'Visible', 'On');
            set(handles.radiobutton72, 'Visible', 'On');
            set(handles.radiobutton114, 'Visible', 'On');
            set(handles.DHS2, 'Visible', 'On');
            set(handles.DHS3, 'Visible', 'On');
            set(handles.DHS4, 'Visible', 'On');
            set(handles.DHS5, 'Visible', 'On');
        case 'numHS6'
            handles.NumHS = 6;
            set(handles.radiobutton70, 'Visible', 'On');
            set(handles.radiobutton71, 'Visible', 'On');
            set(handles.radiobutton72, 'Visible', 'On');
            set(handles.radiobutton114, 'Visible', 'On');
            set(handles.radiobutton115, 'Visible', 'On');
            set(handles.DHS2, 'Visible', 'On');
            set(handles.DHS3, 'Visible', 'On');
            set(handles.DHS4, 'Visible', 'On');
            set(handles.DHS5, 'Visible', 'On');
            set(handles.DHS6, 'Visible', 'On');
        otherwise
            handles.NumHS = 1;
    end
    
guidata(hObject, handles);          % this saves data stored in 'handles'
set(handles.configPanel, 'Visible', 'Off')
set(handles.ProgramEngineButton, 'Visible', 'On');
set(handles.EventSeqButton, 'Visible', 'On');
set(handles.ProgramScope, 'Visible', 'On');
handles.HSType
handles.NumHS


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
setEngineHardware(handles);
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


% --- Executes on button press in ProgramScope.
function ProgramScope_Callback(hObject, eventdata, handles)
% hObject    handle to ProgramScope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set (handles.ProgramScope, 'Visible', 'Off');
set (handles.DtoAPanel, 'Visible', 'On');
putupDtoAChannelPanel(handles);
guidata(hObject, handles);


% --- Executes on button press in DChanSelectOK.
function DChanSelectOK_Callback(hObject, eventdata, handles)
% hObject    handle to DChanSelectOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set (handles.DtoAPanel, 'Visible', 'Off');
set(handles.ProgramScope, 'Visible', 'On');


% --- Executes when selected object is changed in D16Panel.
function D16Panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in D16Panel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
chan = sscanf(get(eventdata.NewValue, 'Tag'), 'SChan%d', 1);
fprintf('chan:%d', chan);
handles.dtoaChan(handles.selectedDtoAChannel).Channel = chan;
guidata(hObject, handles);
str=sprintf('~D%d:h%d:c%02d\n', (handles.selectedDtoAChannel-1), (handles.dtoaChan(handles.selectedDtoAChannel).HS-1),...
            (handles.dtoaChan(handles.selectedDtoAChannel).Channel-1));
SendCommandString(handles, str);



% --- Executes when selected object is changed in EngOutDisplay.
function EngOutDisplay_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in EngOutDisplay 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if(strcmp(get(eventdata.NewValue, 'Tag'), 'FilterOutButton'))
    handles.dtoaChan(handles.selectedDtoAChannel).Filter = 1;
else
    handles.dtoaChan(handles.selectedDtoAChannel).Filter = 0;
end
guidata(hObject, handles);
str=sprintf('~D%d:e%d:s%1d\n', (handles.selectedDtoAChannel-1), (handles.dtoaChan(handles.selectedDtoAChannel).Engine-1),...
            handles.dtoaChan(handles.selectedDtoAChannel).Filter);
SendCommandString(handles, str);

% --- Executes when selected object is changed in DtoAChanSelect.
function DtoAChanSelect_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in DtoAChanSelect 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

% set the currently selected channel in the handles structure
handles.selectedDtoAChannel = sscanf(get(get(handles.DtoAChanSelect, 'SelectedObject'),'Tag'),'ScopeChan%d', 1);
putupDtoAChannelPanel(handles);
guidata(hObject, handles);
if(handles.dtoaChan(handles.selectedDtoAChannel).ChannelData == 1)
    str=sprintf('~D%d:h%d:c%02d\n', (handles.selectedDtoAChannel-1), (handles.dtoaChan(handles.selectedDtoAChannel).HS-1),...
            (handles.dtoaChan(handles.selectedDtoAChannel).Channel-1));
else
    handles.dtoaChan(handles.selectedDtoAChannel).ChannelData = 0;
    str=sprintf('~D%d:e%d:s%02d\n', (handles.selectedDtoAChannel-1), (handles.dtoaChan(handles.selectedDtoAChannel).Engine-1),...
            handles.dtoaChan(handles.selectedDtoAChannel).Filter);
end
SendCommandString(handles, str);


% --- Executes when selected object is changed in SigSelect.
function SigSelect_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in SigSelect 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if(strcmp(get(hObject, 'String'), 'Channel Data'))
    handles.dtoaChan(handles.selectedDtoAChannel).ChannelData = 1;
    str=sprintf('~D%d:h%d:c%02d\n', (handles.selectedDtoAChannel-1), (handles.dtoaChan(handles.selectedDtoAChannel).HS-1),...
            (handles.dtoaChan(handles.selectedDtoAChannel).Channel-1));
else
    handles.dtoaChan(handles.selectedDtoAChannel).ChannelData = 0;
    str=sprintf('~D%d:e%d:s%02d\n', (handles.selectedDtoAChannel-1), (handles.dtoaChan(handles.selectedDtoAChannel).Engine-1),...
            handles.dtoaChan(handles.selectedDtoAChannel).Filter);
end
SendCommandString(handles, str);
putupDtoAChannelPanel(handles);
guidata(hObject, handles);


% --- Executes when selected object is changed in DHSSelect.
function DHSSelect_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in DHSSelect 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles.dtoaChan(handles.selectedDtoAChannel).HS = sscanf(get(get(handles.DHSSelect, 'SelectedObject'),'String'),'HS %d', 1);
putupDtoAChannelPanel(handles);
guidata(hObject, handles);
str=sprintf('~D%d:h%d:c%02d\n', (handles.selectedDtoAChannel-1), (handles.dtoaChan(handles.selectedDtoAChannel).HS-1),...
            (handles.dtoaChan(handles.selectedDtoAChannel).Channel-1));
SendCommandString(handles, str);


% --- Executes when selected object is changed in D32Panel.
function D32Panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in D32Panel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
chan = sscanf(get(eventdata.NewValue, 'Tag'), 'DChan%d', 1);
handles.dtoaChan(handles.selectedDtoAChannel).Channel = chan;
guidata(hObject, handles);
str=sprintf('~D%d:h%d:c%02d\n', (handles.selectedDtoAChannel-1), (handles.dtoaChan(handles.selectedDtoAChannel).HS-1),...
            (handles.dtoaChan(handles.selectedDtoAChannel).Channel-1));
SendCommandString(handles, str);



% --- Executes when selected object is changed in DEngSelect.
function DEngSelect_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in DEngSelect 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
eng = sscanf(get(eventdata.NewValue, 'Tag'), 'DEng%d', 1);
handles.dtoaChan(handles.selectedDtoAChannel).Engine = eng;
guidata(hObject, handles);
str=sprintf('~D%d:e%d:s%02d\n', handles.selectedDtoAChannel, handles.dtoaChan(handles.selectedDtoAChannel).Engine,...
            handles.dtoaChan(handles.selectedDtoAChannel).Filter);
SendCommandString(handles, str);
