% This function takes the info from the Engine setup front panel and sends
% out the ASCI to set the parameters for an engine
% HS, channel and Engine all go 1-N in the GUI and 0-(N-1) in hardware

function setEngineHardware(handles)
    % Headstage %
    sendString = sprintf('~h:E%1d:%1d\n', (handles.SelectedEngine-1), (handles.engine(handles.SelectedEngine).HeadStage-1));
    SendCommandString(handles, sendString);
    % Channel %
    sendString = sprintf('~c:E%1d:%02d\n', (handles.SelectedEngine-1), (handles.engine(handles.SelectedEngine).Channel-1)); 
    SendCommandString(handles, sendString);
    % Decimation  - is really samples to skip so 0 is every sample, 1 is
    % every other etc.  0-99 with leading zeros
    sendString = sprintf('~d:E%1d:%02d\n', (handles.SelectedEngine-1), handles.engine(handles.SelectedEngine).Decimation); 
    SendCommandString(handles, sendString);
    % Threshold  - Should be sent in unsigned Fixed point 16.12 format as a 4 character hex %
    sendString = sprintf('~T:E%1d:%s\n', (handles.SelectedEngine-1), hex(ufi(handles.engine(handles.SelectedEngine).Threshold, 16, 12))); 
    SendCommandString(handles, sendString);
    % Filter Length 3 decimal digits
    sendString = sprintf('~l:E%1d:%03d\n', (handles.SelectedEngine-1), handles.engine(handles.SelectedEngine).nFilterCoef);
    SendCommandString(handles, sendString);
    %filter values are sent as a signed 16.15 fixedpoint numbers converted
    %to 4 hex digits
    for i=1:handles.engine(handles.SelectedEngine).nFilterCoef
        sendString = sprintf('~f:E%1d:%03x %s\n', (handles.SelectedEngine-1), i-1, hex(sfi(handles.engine(handles.SelectedEngine).Filter(i), 16, 15)));
        SendCommandString(handles, sendString);
    end
    % template size 3 decimal digits
    sendString = sprintf('~s:E%1d:%03d\n', (handles.SelectedEngine-1), handles.engine(handles.SelectedEngine).nTemplatePoints);
    SendCommandString(handles, sendString);
    %template values are sent as a signed 16.15 fixedpoint numbers converted
    %to 4 hex digits
    for i=1:handles.engine(handles.SelectedEngine).nTemplatePoints
        sendString = sprintf('~t:E%1d:%03x %s\n', (handles.SelectedEngine-1), i-1, hex(sfi(handles.engine(handles.SelectedEngine).Template(i), 16, 15)));
        SendCommandString(handles, sendString);
    end
    
        



