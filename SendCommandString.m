function SendCommandString(handles, sendString)
    fprintf('%s', sendString);
    fprintf(handles.serConn, sendString);
    fwrite(handles.serConn, 13);
    currList = cat(1,get(handles.SerialMonitorWindow, 'String'), {sendString});
    set(handles.SerialMonitorWindow, 'String', currList);
    set(handles.SerialMonitorWindow, 'Value', length(currList) );
