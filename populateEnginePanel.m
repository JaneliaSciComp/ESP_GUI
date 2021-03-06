function populateEnginePanel(hObject, eventdata, handles)

% populate the engine panel for the currently selected engine
%set the HS radio button
switch handles.engine(handles.SelectedEngine).HeadStage   
    case 1
        set(handles.radiobutton69, 'Value', 1);
    case 2
        set(handles.radiobutton70, 'Value', 1);
    case 3
        set(handles.radiobutton71, 'Value', 1);
    case 4
        set(handles.radiobutton72, 'Value', 1);
    case 5
        set(handles.radiobutton114, 'Value', 1);
    case 6
        set(handles.radiobutton115, 'Value', 1);
    otherwise
        set(handles.radiobutton69, 'Value', 1);
end
% set the channel button, two types for now 16 and 32
if (handles.HSType == 16)
    button = sprintf('handles.chan%d', handles.engine(handles.SelectedEngine).Channel); 
    set(eval(button), 'Value', 1);                  % eval converts the string into the handle
else                    % other types of headstages can go here
    button = sprintf('handles.chanButton%d', handles.engine(handles.SelectedEngine).Channel); 
    set(eval(button), 'Value', 1);                  % eval converts the string into the handle
end

% decimation
set(handles.DecimationEntry, 'String', sprintf('%d', handles.engine(handles.SelectedEngine).Decimation));

% threshold
set(handles.ThresholdEdit, 'String', sprintf('%f', handles.engine(handles.SelectedEngine).Threshold));

% filter filename
set(handles.FilterFileText, 'String', handles.engine(handles.SelectedEngine).FilterFilename);

% template filename
set(handles.TemplateFileText, 'String', handles.engine(handles.SelectedEngine).TemplateFilename);

% put up the plot of the appropriate function
if (strcmp(handles.engine(handles.SelectedEngine).CurrentGraphSelection, 'Filter'))
    plot(handles.WaveformAxis, handles.engine(handles.SelectedEngine).Filter);
else 
    plot(handles.WaveformAxis, handles.engine(handles.SelectedEngine).Template);
end





