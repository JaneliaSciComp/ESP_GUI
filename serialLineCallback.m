% this is a callback for the serial port bytes available event.  Just read the port and put the
% lines in the serial monitor on the screen.

function serialLineCallback (obj, event, handles);
    line = fscanf (handles.serConn);    % read the line
    currList = get(handles.SerialMonitorWindow, 'String');
    currList = cat(1,get(handles.SerialMonitorWindow, 'String'), {line});
    set(handles.SerialMonitorWindow, 'String', currList);
    set(handles.SerialMonitorWindow, 'Value', length(currList) );
end
