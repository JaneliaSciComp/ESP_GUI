function SendCommandString(handles, sendString)
    fprintf('%s', sendString);
    fprintf(handles.serConn, sendString);
    fwrite(handles.serConn, 13);
    currList = cat(1,get(handles.SerialMonitorWindow, 'String'), {sendString});
    set(handles.SerialMonitorWindow, 'String', currList);
    set(handles.SerialMonitorWindow, 'Value', length(currList) );
    pause(.1);
%     try 
%         RxText = fscanf(handles.serConn);
%         if length(RxText) >= 1
%                 currList = get(handles.SerialMonitorWindow, 'String');
%                 currList = cat(1,get(handles.SerialMonitorWindow, 'String'), {RxText});
%                 set(handles.SerialMonitorWindow, 'String', currList);
%                 set(handles.SerialMonitorWindow, 'Value', length(currList) );
%         end
%     catch e
%         disp(e)
%     end 
    