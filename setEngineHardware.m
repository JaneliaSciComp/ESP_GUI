% This function takes the info from the Engine setup front panel and sends
% out the ASCI to set the parameters for an engine

function setEngineHardware(handles)
    % Headstage %
    sendString = sprintf('~h:E%1d:%1d\n', handles.SelectedEngine, handles.engine(handles.SelectedEngine).HeadStage);
    SendCommandString(handles, sendString);
    % Channel %
    sendString = sprintf('~c:E%1d:%2d\n', handles.SelectedEngine, handles.engine(handles.SelectedEngine).Channel); 
    SendCommandString(handles, sendString);
    % Decimation  - is really samples to skip so 0 is every sample, 1 is every other etc. %
    sendString = sprintf('~d:E%1d:%3d\n', handles.SelectedEngine, handles.engine(handles.SelectedEngine).Decimation); 
    SendCommandString(handles, sendString);
    % Threshold  - Should be sent in unsigned Fixed point 16.12 format as a 4 character hex %
    sendString = sprintf('~T:E%1d:%s\n', handles.SelectedEngine, hex(ufi(handles.engine(handles.SelectedEngine).Threshold, 16, 12))); 
    SendCommandString(handles, sendString);
    %filter values are sent as a signed 16.15 fixedpoint numbers converted
    %to 4 hex digits
    for i=1:handles.engine(handles.SelectedEngine).nFilterCoef
        sendString = sprintf('~f:E%1d:%3X %s\n', handles.SelectedEngine, i-1, hex(sfi(handles.engine(handles.SelectedEngine).Filter(i), 16, 15)));
        SendCommandString(handles, sendString);
    end
    %template values are sent as a signed 16.15 fixedpoint numbers converted
    %to 4 hex digits
    for i=1:handles.engine(handles.SelectedEngine).nTemplatePoints
        sendString = sprintf('~t:E%1d:%3X %s\n', handles.SelectedEngine, i-1, hex(sfi(handles.engine(handles.SelectedEngine).Template(i), 16, 15)));
        SendCommandString(handles, sendString);
    end
    
        



