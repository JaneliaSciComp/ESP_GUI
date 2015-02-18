% this function puts up and populates the scope output selection panel. It
% gets the DtoA channel parameters for the panel from the dtoaChan array of structures
% one structure for each D to A channel. The variable selectedDtoAChannel
% tells which D to A channel is selected to be displayed.

function putupDtoAChannelPanel(handles)

set (handles.SigSelect, 'Visible', 'On');
set (handles.DtoAChanSelect, 'Visible', 'On');


if(handles.dtoaChan(handles.selectedDtoAChannel).ChannelData == 1)  % display Channel Data
    set(handles.DEngSelect, 'Visible', 'Off');                  % turn off the engine select panel
    set(handles.EngOutDisplay, 'Visible', 'Off');               % turn off the Eng Output Select Panel
    set (handles.DHSSelect, 'Visible', 'On');                   % turn on the HS select panel
    % set the proper radio button for the data type selection
    set(handles.ChannelButton, 'Value', 1);
    fprintf('set Channel Button\n');
    % set the HS button for this dtoa channel
    set(eval(sprintf('handles.DHS%d', handles.dtoaChan(handles.selectedDtoAChannel).HS)), 'Value', 1);  
    % put up the proper channel select panel for the type of HS being used
    if(handles.HSType == 16)  % 16 channel HS
        set (handles.D32Panel, 'Visible', 'Off');
        set (handles.D16Panel, 'Visible', 'On');
        % set the button on the panel for the selected DtoA channel
        set(eval(sprintf('handles.SChan%d', handles.dtoaChan(handles.selectedDtoAChannel).Channel)), 'Value', 1);  
    else                    % 32 channel HS
        set (handles.D32Panel, 'Visible', 'On');
        set (handles.D16Panel, 'Visible', 'Off');
        % set the button on the panel for the selected DtoA channel
        set(eval(sprintf('handles.DChan%d', handles.dtoaChan(handles.selectedDtoAChannel).Channel)), 'Value', 1);  
    end
else                        % display engine output
    set (handles.D32Panel, 'Visible', 'Off');
    set (handles.D16Panel, 'Visible', 'Off');
    set (handles.DHSSelect, 'Visible', 'Off');
    set(handles.EngineButton, 'Value', 1);
    fprintf('set Channel Button\n');
    set(handles.DEngSelect, 'Visible', 'On');
    %Turn on the button of the last used engine for this DtoA channel
    set(eval(sprintf('handles.DEng%d', handles.dtoaChan(handles.selectedDtoAChannel).Engine)), 'Value', 1);  
    set(handles.EngOutDisplay, 'Visible', 'On');
    %Turn on the last used button in the Engine Output Select Panel
    if (handles.dtoaChan(handles.selectedDtoAChannel).Filter == 1)
        set(handles.FilterOutButton, 'Value', 1);  
    else
        set(handles.LSDOutButton, 'Value', 1);
    end
end
set (handles.DChanSelectOK, 'Visible', 'On');


