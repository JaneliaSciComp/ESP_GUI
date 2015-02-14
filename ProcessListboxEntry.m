function ProcessListboxEntry (hObject, eventdata, handles)
if strcmp(get(handles.figure1,'SelectionType'),'open')
    contents = cellstr(get(hObject,'String'));
    SelectedFilename = contents{get(hObject,'Value')};
    fprintf('Selected filename christmas: %s\n', SelectedFilename);  
    if  isdir(SelectedFilename)
        cd (SelectedFilename);
        d=dir;                                                   %get a directory listing
        set(handles.EngineWaveformListbox, 'Value', 1);          % to make string go in at the top
        set(handles.EngineWaveformListbox, 'String',{d.name});   % put filenames in  listbox
    else
        % fprintf ('christmas else path\n');
        [path,name,ext] = fileparts(SelectedFilename);
        if (strcmp(handles.engine(handles.SelectedEngine).FileEntryChoice, 'Filter'))
            fprintf('extension: %s\n', ext);
            % this switch is for files with different extensions. If
            % additional file types need to be processed, they can be added
            % here. THis gives an additional pathway for entering filter
            % coefficients and templates.  As of this writing, only the
            % .fcf type file can be used for filter coeficients and only a
            % .mat file can be used for templates.
            switch ext
                case '.mat'
                    % put in code to read a .mat type file for filter
                    % coefficients 
                case '.fcf'
                    % an fcf file is created by running filterbuilder, a
                    % matlab function that allows you to design a filter
                    % THis program outputs a filter structure to the
                    % Workspace and it tells you the name (like Hlpf1). 
                    % THis can be written to a .fcf file by calling
                    % fcfwrite(<filter structure name>, <filename>) for
                    % example fcfwrite(Hlpf1, 'my_filter1'). 
                    coeff = read_fcf_file (SelectedFilename);
                    n = size(coeff,2);
                    if size(coeff) > 64
                        error ('Too many filter coefficients, truncating');
                        n = 64;
                    end    
                    handles.engine(handles.SelectedEngine).nFilterCoef = n;
                    % handles.engine(handles.SelectedEngine).Filter[1:n] = coeff[1:n];
                    plot(handles.WaveformAxis, coeff);
                    handles.engine(handles.SelectedEngine).CurrentGraphSelection = 'Filter';
                    % turn on the proper graph button
                    set(handles.GraphFilterButton, 'Value', 1);
                    % display the filename 
                    set(handles.FilterFileText, 'String',['Filter File: ' SelectedFilename]);
                    handles.engine(handles.SelectedEngine).FilterFilename = SelectedFilename ;
                    %handles.engine(handles.SelectedEngine).
                    handles.engine(handles.SelectedEngine).Filter = coeff;
                    set(handles.EngineWaveformListbox, 'Value',1);
                    set(handles.EngineWaveformListbox, 'String','');

                otherwise
                    try
                        open(filename)
                    catch ex
                        errordlg(...
                          ex.getReport('basic'),'File Type Error','modal')
                    end
            end
        % now have a seperate switch for the template
        elseif (strcmp(handles.engine(handles.SelectedEngine).FileEntryChoice, 'Template'))
            switch ext
                case '.mat'              
                    load (SelectedFilename);
                    % there should be an array called template 
                    n = size(template, 2);
                    if n > 64
                        errordlg ('Too many template values, truncating to 64');
                        n = 64;
                    end

                case '.tpl'
                    template = read_tpl_file (SelectedFilename);
                    n = size(template,2);
                    if size(template) > 64
                        errordlg ('Too many filter coefficients, truncating');
                        n = 64;
                    end    
                    
                otherwise
                    try
                        open(filename)
                    catch ex
                        errordlg(...
                          ex.getReport('basic'),'File Type Error','modal')
                    end
            end
            % common stuff for all template files
            handles.engine(handles.SelectedEngine).nTemplatePoints = n;
            % save the template in the engine structure
            handles.engine(handles.SelectedEngine).Template = template;
            % plot the template on the screen
            plot(handles.WaveformAxis, template);
            handles.engine(handles.SelectedEngine).CurrentGraphSelection = 'Template';
            % turn on the proper graph button
            set(handles.GraphTemplateButton, 'Value', 1);
            % put up the filename
            set(handles.TemplateFileText, 'String',['Template File: ' SelectedFilename]);
            % store the filename in the engine structure
            handles.engine(handles.SelectedEngine).TemplateFilename = SelectedFilename;
            % Blank the listbox by setting the String property to
            % empty, the first statment is required to fix a little
            % bug
            set(handles.EngineWaveformListbox, 'Value',1);
            set(handles.EngineWaveformListbox, 'String','');
        else
        end
    end

end
% load the listbox with contents of current directory
guidata(hObject, handles);              % update the data structure