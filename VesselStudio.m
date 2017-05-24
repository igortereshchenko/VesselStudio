function varargout = VesselStudio(varargin)
% VESSELSTUDIO MATLAB code for VesselStudio.fig
%      VESSELSTUDIO, by itself, creates a new VESSELSTUDIO or raises the existing
%      singleton*.
%
%      H = VESSELSTUDIO returns the handle to a new VESSELSTUDIO or the handle to
%      the existing singleton*.
%
%      VESSELSTUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VESSELSTUDIO.M with the given input arguments.
%
%      VESSELSTUDIO('Property','Value',...) creates a new VESSELSTUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VesselStudio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VesselStudio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VesselStudio

% Last Modified by GUIDE v2.5 12-Aug-2016 13:15:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VesselStudio_OpeningFcn, ...
                   'gui_OutputFcn',  @VesselStudio_OutputFcn, ...
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





% --- Executes during object creation, after setting all properties.
function frm_main_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frm_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.tgroup = uitabgroup('Parent', hObject);
set(handles.tgroup,'Position',[0,0,1,1]);

handles.contour_recognition = uitab('Parent', handles.tgroup, 'Title', 'Contour selection');
handles.contour_rotation = uitab('Parent', handles.tgroup, 'Title', 'Contour rotation');
handles.contour_trajectory = uitab('Parent', handles.tgroup, 'Title', 'Contour trajectory');


guidata(hObject,handles);
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');


% --- Executes just before VesselStudio is made visible.
function VesselStudio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VesselStudio (see VARARGIN)

% Choose default command line output for VesselStudio
handles.output = hObject;



%--------------------Interface building-----------------------------

    %----Contour Selection------
    set(handles.panel_contour_recognition,'Parent',handles.contour_recognition);
    handles.panel_contour_recognition.Position = [0 0 1 1];
    set(handles.panel_contour_recognition,'Visible','on');
    [hLeft,hRight,hDiv1]=uisplitpane(handles.panel_contour_recognition,'Orientation','horizontal','dividercolor',[105,105,105],'dividerwidth',5,'DividerLocation',0.6);     
        % Left part
        set(handles.panel_contour_recognition_left,'Parent',hLeft);
        set(handles.panel_contour_recognition_left,'Position',[0,0,1,1]);

        
        % Right part
        %tabs
        handles.contour_recognition_tgroup = uitabgroup('Parent', hRight);

        handles.contour_recognition_preview = uitab('Parent', handles.contour_recognition_tgroup, 'Title', 'Contour recognition');
        handles.contour_recognition_statistics = uitab('Parent', handles.contour_recognition_tgroup, 'Title', 'Recognition statistics');

        %First tab
        set(handles.panel_contour_recognition_preview,'Parent',handles.contour_recognition_preview);
        set(handles.panel_contour_recognition_preview,'Position',[0,0,1,1]);

        %Second tab
        set(handles.panel_contour_recognition_statistics,'Parent',handles.contour_recognition_statistics);
        set(handles.panel_contour_recognition_statistics,'Position',[0,0,1,0.9]);
        set(handles.lbl_current_contour_info,'Parent',handles.contour_recognition_statistics);       
        set(handles.lbl_current_contour_info,'Position',[0.05,0.9,1,0.1]);        
        
            %tab devided on two parts for statistics
            [hUp,hDown,hDiv2]=uisplitpane(handles.panel_contour_recognition_statistics,'Orientation','vertical','dividercolor',[105,105,105],'dividerwidth',5,'DividerLocation',0.5);     
            set(handles.panel_contour_recognition_statistics_1,'Parent',hUp);
            set(handles.panel_contour_recognition_statistics_1,'Position',[0,0,1,1]);
            set(handles.panel_contour_recognition_statistics_2,'Parent',hDown);
            set(handles.panel_contour_recognition_statistics_2,'Position',[0,0,1,1]);



        set(allchild(handles.plot_main),'visible','off'); 
        set(handles.plot_main,'visible','off'); 

        set(allchild(handles.plot_current),'visible','off'); 
        set(handles.plot_current,'visible','off'); 


        set(allchild(handles.plot_next),'visible','off'); 
        set(handles.plot_next,'visible','off'); 


        set(allchild(handles.plot_previous),'visible','off'); 
        set(handles.plot_previous,'visible','off');  

        set(handles.cmb_contour_recognition_method,'String',{'By points','By hand','Automatic'});
        set(handles.cmb_contour_recognition_method,'Value',3);            
    
    
    
    %----Contour Rotation-------    
    set(handles.panel_contour_rotation,'Parent',handles.contour_rotation);
    handles.panel_contour_rotation.Position = [0 0 1 1];
    set(handles.panel_contour_rotation,'Visible','on');   

    handles.contour_rotation_angle_tgroup = uitabgroup('Parent', handles.panel_angle_rotation_plot);
    set(handles.contour_rotation_angle_tgroup,'Position',[0,0,1,1]);
        handles.contour_rotation_angle = uitab('Parent', handles.contour_rotation_angle_tgroup, 'Title', 'Angles');
        handles.contour_rotation_similarity = uitab('Parent', handles.contour_rotation_angle_tgroup, 'Title', 'Contours similarity');
        
        
        set(handles.plot_similarity_angle,'Parent',handles.contour_rotation_similarity);
        set(handles.plot_similarity_angle,'Position',[0.06,0.06,0.92,0.9]);        
        set(handles.plot_angles_dynamics,'Parent',handles.contour_rotation_angle);        
        set(handles.plot_angles_dynamics,'Position',[0.06,0.06,0.92,0.9]);            
    
        set(allchild(handles.plot_characteristics_poins),'visible','off'); 
        set(handles.plot_characteristics_poins,'visible','off'); 


        
        
    
        set(handles.cmb_contour_rotation_similarity_method,'String',{'By distance from centroid','By contours derivatives similarity'});
        set(handles.cmb_contour_rotation_similarity_method,'Value',2);        
        
        
    %----Contour Trajectory-----        
    set(handles.panel_contour_trajectory,'Parent',handles.contour_trajectory);
    handles.panel_contour_trajectory.Position = [0 0 1 1];
    set(handles.panel_contour_trajectory,'Visible','on');

%     set(allchild(handles.plot_contour_dynamics),'visible','off'); 
%     set(handles.plot_contour_dynamics,'visible','off'); 

    set(allchild(handles.plot_point_of_interest),'visible','off'); 
    set(handles.plot_point_of_interest,'visible','off'); 
    
    linkaxes([handles.plot_main,handles.plot_previous,handles.plot_next,handles.plot_current,handles.plot_point_of_interest],'xy');

    


    


% UIWAIT makes VesselStudio wait for user response (see UIRESUME)
% uiwait(handles.frm_main);




                                                    
contour_recognition_parameters = struct(...
                                                        'count_of_polygon_points',[],...
                                                        'count_of_envelope_points',[],...
                                                        'time_step',[],...
                                                        'count_of_inner_iteration',[],...
                                                        'count_of_outer_itereation',[],...
                                                        'lambda',[],...
                                                        'alfa',[],...
                                                        'epsilon',[],...
                                                        'sigma',[],...
                                                        'scale_level',1.5,...
                                                        'initial_boudary_scale',[],...
                                                        'vessel_thickness',[],...
                                                        'block_boundary_scale',[]); 

                                                    
contour_trajectory_parameters=struct( ...
                                                        'slice_dataset',[],...
                                                        'count_of_interpolation_points_time',[]);  
                                

contour_characteristics_points_parameters=struct(  ...
                                                        'slice_dataset',[],...
                                                        'count_of_characteristics_points',[],...
                                                        'epsilon_compared_characteristics_points',[]);  
                                
                                
contour_angle_parameters=struct(  ...
                                                        'slice_dataset',[],...
                                                        'count_of_similarity_points',[],...
                                                        'angle_range',[],...
                                                        'angle_scale',[]);  



handles.VesselStudio_data = struct(...
                                                        'XLim',[],...
                                                        'YLim',[],...                                                        
                                                        'image_step',[],...                                                                                                                
                                                        'edit_mode',[],...                                                                                                                                                                        
                                                        'slices_dataset',[],...                                                                                                                                                                        
                                                        'current_dicom_file',[],...
                                                        'count_of_dicom_files',[],... 
                                                        'contour_poly_selection',[],...
                                                        'current_envelope_plot',[],...
                                                        'main_envelope_plot',[],...
                                                        'current_envelope',[],...
                                                        'contour_areas',[],...
                                                        'contour_perimeters',[],...
                                                        'contour_angles',[],...
                                                        'contour_centroids',[],...
                                                        'variable',[],...
                                                        'variable_name',[],...
                                                        'interpolation_contour_dataset',[],...
                                                        'contour_dataset_with_characteristics_points',[],...                                                        
                                                        'contour_of_interest',[],...                                                        
                                                        'ploted_point_of_interest',[],...                                                                                                                
                                                        'trajectory_interested',[],... 
                                                        'plot_calculated_point_of_interest',[],... 
                                                        'plot_user_point_of_interest',[],...                                                             
                                                        'smoothed_angles',[],...                                                                                                                                                                        
                                                        'contour_recognition_parameters',contour_recognition_parameters,... 
                                                        'contour_trajectory_parameters',contour_trajectory_parameters,...                                                         
                                                        'contour_characteristics_points_parameters',contour_characteristics_points_parameters,...                                                                                                                                                                        
                                                        'contour_angle_parameters',contour_angle_parameters);                                         
                                        
guidata(hObject, handles);
VesselStudio_Initialization(hObject, eventdata, handles);
handles = guidata(hObject);
guidata(hObject, handles);


function default_parameters(hObject, eventdata, handles)
 
contour_recognition_parameters = struct(...
                                                        'count_of_polygon_points',20,...
                                                        'count_of_envelope_points',100,...
                                                        'time_step',500,...
                                                        'count_of_inner_iteration',20,...
                                                        'count_of_outer_itereation',20,...
                                                        'lambda',10,...
                                                        'alfa',4.5,...
                                                        'epsilon',0.5,...
                                                        'sigma',0.8,...
                                                        'scale_level',1.5,...
                                                        'initial_boudary_scale',0.05,...
                                                        'vessel_thickness',0.1,...
                                                        'block_boundary_scale',0.25); 

                                                    
contour_trajectory_parameters=struct(  ...
                                                        'slice_dataset',[],...
                                                        'count_of_interpolation_points_time',37);  
                                

contour_characteristics_points_parameters=struct( ...
                                                        'slice_dataset',[],...
                                                        'count_of_characteristics_points',50,...
                                                        'epsilon_compared_characteristics_points',0.025);  
                                
                                
contour_angle_parameters=struct(  ...
                                                        'slice_dataset',[],...
                                                        'count_of_similarity_points',150,...
                                                        'angle_range',pi/30,...
                                                        'angle_scale',pi/(360+180));  


handles.VesselStudio_data.contour_recognition_parameters=contour_recognition_parameters;
handles.VesselStudio_data.contour_trajectory_parameters=contour_trajectory_parameters;
handles.VesselStudio_data.contour_characteristics_points_parameters=contour_characteristics_points_parameters;
handles.VesselStudio_data.contour_angle_parameters=contour_angle_parameters;

handles.VesselStudio_data.XLim=[0 270];
handles.VesselStudio_data.YLim=[0 270];


guidata(handles.frm_main, handles);


function VesselStudio_Initialization(hObject, eventdata, handles)


default_parameters(hObject, eventdata, handles);
handles = guidata(hObject);

%-----Initialization contour recognition---------

handles.lbl_previous_image.String='';
handles.lbl_next_image.String='';
handles.lbl_current_image.String='';

set(handles.btn_contour_recognition_next,'Enable','off');
set(handles.btn_contour_recognition_previous,'Enable','off');
set(handles.cmb_current_dicom_file,'String','no data');
set(handles.cmb_current_dicom_file,'Value',1)


handles.VesselStudio_data.image_step=1;

set(handles.cmb_contour_recognition_statistic_1, 'Enable', 'off');
set(handles.cmb_contour_recognition_statistic_2, 'Enable', 'off');


%-----Initialization contour rotation---------

set(handles.btn_contour_rotation_next,'Enable','off');
set(handles.btn_contour_rotation_previous,'Enable','off');

set(handles.cmb_current_dicom_file_contour_rotation,'String','no data');
set(handles.cmb_current_dicom_file_contour_rotation,'Value',1)


set(handles.slider_contour_rotation_angle_increment, 'Min', -handles.VesselStudio_data.contour_angle_parameters.angle_range);
set(handles.slider_contour_rotation_angle_increment, 'Max', handles.VesselStudio_data.contour_angle_parameters.angle_range);
set(handles.slider_contour_rotation_angle_increment, 'Value', 0);
set(handles.slider_contour_rotation_angle_increment, 'SliderStep', [handles.VesselStudio_data.contour_angle_parameters.angle_scale , handles.VesselStudio_data.contour_angle_parameters.angle_scale ]);


%-----Initialization contour trajectory---------

set(handles.btn_contour_trajectory_next,'Enable','off');
set(handles.btn_contour_trajectory_previous,'Enable','off');

set(handles.cmb_current_dicom_file_contour_trajectory,'String','no data');
set(handles.cmb_current_dicom_file_contour_trajectory,'Value',1)

set(handles.slider_contour_trajectory_point_coordinates,'Enable','off');    

cla(handles.plot_contour_dynamics);
%---------------------------------------------
handles.VesselStudio_data.slices_dataset=[];
handles.VesselStudio_data.current_envelope_plot=[];
handles.VesselStudio_data.main_envelope_plot=[];
handles.VesselStudio_data.current_envelope=[];


handles.VesselStudio_data.contour_areas=[];
handles.VesselStudio_data.contour_perimeters=[];
handles.VesselStudio_data.contour_angles=[];
handles.VesselStudio_data.contour_centroids=[];



handles.VesselStudio_data.variable=[];
handles.VesselStudio_data.variable_name=[];


handles.VesselStudio_data.interpolation_contour_dataset=[];
handles.VesselStudio_data.contour_dataset_with_characteristics_points=[];
handles.VesselStudio_data.contour_of_interest=[];
handles.VesselStudio_data.ploted_point_of_interest=[];
handles.VesselStudio_data.trajectory_interested=[];
handles.VesselStudio_data.smoothed_agnles=[];

handles.VesselStudio_data.edit_mode=false;


guidata(handles.frm_main, handles);



% --- Executes when user attempts to close frm_main.
function frm_main_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to frm_main (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
   answer= questdlg('Save your work before exit?', ...
        'Vessel Studio', ...
        'Yes','No','Cancel','Yes');
   if  strcmp(answer,'Yes')
    menu_file_export_slices_dataset_Callback(hObject, eventdata, handles);
   end;
   
   if  strcmp(answer,'No')
    delete(hObject);
   end;

% --- Outputs from this function are returned to the command line.
function varargout = VesselStudio_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
   
%---------------------Menu Block---------------------

%---------------------Menu File----------------------

% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_file_open_dicom_files_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_open_dicom_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    VesselStudio_Initialization(hObject, eventdata, handles);
    handles = guidata(hObject);    
    
         
    handles.VesselStudio_data.slices_dataset = dataset_load_from_folder();
    
    

    guidata(hObject,handles)   
    
    new_slices_dataset_initialization(hObject, eventdata, handles);    
    handles = guidata(hObject);
    guidata(hObject,handles)        
catch
    questdlg('Error. No data loaded', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end


% --------------------------------------------------------------------
function menu_file_open_slices_dataset_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_open_slices_dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile('*.mat','Select mat file');

if (filename==0) %cancel is pressed
    return;
end

variable_data = whos('-file',fullfile(pathname,filename));

try
    VesselStudio_Initialization(hObject, eventdata, handles);
    handles = guidata(hObject);    
    if strcmpi(variable_data(1).class,'struct')
         variable    = load(fullfile(pathname,filename),variable_data.name);
         handles.VesselStudio_data.slices_dataset = variable.(variable_data.name);
    else
        return;
    end
    
    

    guidata(hObject,handles)   
    
    new_slices_dataset_initialization(hObject, eventdata, handles);    
    handles = guidata(hObject);
    guidata(hObject,handles)        
catch
    questdlg('Error. No data loaded', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end
% --------------------------------------------------------------------
function menu_file_import_slices_dataset_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_import_slices_dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {'Enter variable name:'};
    title = 'Data importing...';

    slice_dataset_variable_name = {'slices_dataset'};
    answer = inputdlg(prompt, title, 1, slice_dataset_variable_name);
    if isempty(answer)
        return;
    end;
try
    VesselStudio_Initialization(hObject, eventdata, handles);
    handles = guidata(hObject);    
    handles.VesselStudio_data.slices_dataset=evalin('base',answer{1});
    guidata(hObject,handles)   
    
    new_slices_dataset_initialization(hObject, eventdata, handles);    
    handles = guidata(hObject);
    guidata(hObject,handles)        
catch
    questdlg('Error. No data loaded', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end


function new_slices_dataset_initialization(hObject, eventdata, handles)    
    handles.VesselStudio_data.current_dicom_file=1;
    
    handles.VesselStudio_data.count_of_dicom_files=size(handles.VesselStudio_data.slices_dataset,2);

    handles.VesselStudio_data.edit_mode=false;
    guidata(hObject,handles)

    %enable controls
    visible_contour_controls(hObject, eventdata, handles);
    handles = guidata(hObject);    
    
    clearvars string;

    for i=1: handles.VesselStudio_data.count_of_dicom_files
        string{i}=strcat('DICOM #' ,num2str(i)); 
    end;
    %Initilization contour recognition
    set(handles.cmb_current_dicom_file,'visible','on');
    set(handles.cmb_current_dicom_file,'Enable','on');
    set(handles.cmb_current_dicom_file,'String',string);
    set(handles.cmb_current_dicom_file,'Value',1);
    
    %Initilization contour rotation
    set(handles.cmb_current_dicom_file_contour_rotation,'visible','on');
    set(handles.cmb_current_dicom_file_contour_rotation,'Enable','on');
    set(handles.cmb_current_dicom_file_contour_rotation,'String',string);
    set(handles.cmb_current_dicom_file_contour_rotation,'Value',1);    
    

    
    %Initilization contour trajectory
    set(handles.cmb_current_dicom_file_contour_trajectory,'visible','on');
    set(handles.cmb_current_dicom_file_contour_trajectory,'Enable','on');
    set(handles.cmb_current_dicom_file_contour_trajectory,'String',string);
    set(handles.cmb_current_dicom_file_contour_trajectory,'Value',1);    
    
    
    cmb_current_dicom_file_Callback(hObject, eventdata, handles)    
    
    statusbar(handles.frm_main,'Ready');



% --------------------------------------------------------------------
function menu_file_separator_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_separator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_file_save_slices_dataset_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_save_slices_dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.slices_dataset)
    questdlg('Error. No data to save', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end;
slices_dataset=handles.VesselStudio_data.slices_dataset;
uisave('slices_dataset','slices_dataset') ;

% --------------------------------------------------------------------
function menu_file_export_slices_dataset_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file_export_slices_dataset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.VesselStudio_data.variable=handles.VesselStudio_data.slices_dataset;
handles.VesselStudio_data.variable_name='slices_dataset';
guidata(hObject,handles);
export_variable(hObject, eventdata, handles);

%---------------------Menu Contours-------------------

% --------------------------------------------------------------------
function menu_contours_Callback(hObject, eventdata, handles)
% hObject    handle to menu_contours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_contours_plot_current_contour_Callback(hObject, eventdata, handles)
% hObject    handle to menu_contours_plot_current_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.current_envelope)
    contour=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.coordinates;
    if isempty(contour)
    questdlg('Error. No data to plot', ...
        'Vessel Studio', ...
        'Ok','Ok');
        
        return
    end;
else
    contour=handles.VesselStudio_data.current_envelope;
end;
figure('Name','Current contour','NumberTitle','off');
plot(contour(:,1),contour(:,2),'r');
centroid=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.geometry_characteristics.centroid;
text(centroid(1,1),centroid(1,2),get(handles.lbl_current_image,'String'));


% --------------------------------------------------------------------
function menu_contours_export_current_contour_Callback(hObject, eventdata, handles)
% hObject    handle to menu_contours_export_current_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.current_envelope)
    contour=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.coordinates;
    if isempty(contour)
    questdlg('Error. No data to export', ...
        'Vessel Studio', ...
        'Ok','Ok');
        
        return
    end;
else
    contour=handles.VesselStudio_data.current_envelope;
end;
answer = questdlg('Would you like to save data in voxel?', ...
            'Vessel Studio', ...
            'Yes','No','No');

if strcmp(answer,'No')
    handles.VesselStudio_data.variable=contour;
else
    handles.VesselStudio_data.variable=contour_pixel_coordinates_to_voxel(contour,handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).dicom_info) ;
end;

handles.VesselStudio_data.variable_name='contour';
guidata(hObject,handles);
export_variable(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menu_contours_separator_Callback(hObject, eventdata, handles)
% hObject    handle to menu_contours_separator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_contours_plot_all_contours_Callback(hObject, eventdata, handles)
% hObject    handle to menu_contours_plot_all_contours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.slices_dataset)
    questdlg('Error. No data to plot', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end;

figure('Name','All builded contours','NumberTitle','off');

for i=1:size(handles.VesselStudio_data.slices_dataset,2)
    contour=handles.VesselStudio_data.slices_dataset(i).contour_data.coordinates;
    time=handles.VesselStudio_data.slices_dataset(i).contour_data.time;
    if ~isempty(contour)
        hold on;
        z(1:size(contour,1))=time;
        plot3(contour(:,1),contour(:,2),z,'r');
    end;
end

 view([45 45]);
 

% --------------------------------------------------------------------
function menu_contours_export_all_contours_Callback(hObject, eventdata, handles)
% hObject    handle to menu_contours_export_all_contours (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.slices_dataset)
    questdlg('Error. No data to plot', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end;


for i=1:size(handles.VesselStudio_data.slices_dataset,2)
    contours_dataset(i)=handles.VesselStudio_data.slices_dataset(i).contour_data;
end;

export_contours_from_contours_dataset(hObject, eventdata, handles,contours_dataset);
%----------------------------------------------------------------------------------------------------------

function export_contours_from_contours_dataset(hObject, eventdata, handles,contours_dataset)

index=1;

answer = questdlg('Would you like to save data in voxel?', ...
            'Vessel Studio', ...
            'Yes','No','No');



for i=1:size(contours_dataset,2)
    contour=contours_dataset(i).coordinates;
    time=contours_dataset(i).time;
    if ~isempty(contour)
        z(1:size(contour,1),1)=time;
        contour_data(:,1)=z;
        
        if strcmp(answer,'No')
            contour_coordinates=contour;
        else
            contour_coordinates=contour_pixel_coordinates_to_voxel(contour,handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).dicom_info) ;
        end;
        
        
        contour_data(:,2:3)=contour_coordinates;        
        
        variable(index,:,:,:)=contour_data;

        index=index+1;
    end;
end

handles.VesselStudio_data.variable=variable;
handles.VesselStudio_data.variable_name='contours_dataset';
guidata(hObject,handles);
export_variable(hObject, eventdata, handles);

%---------------------Menu Trajectories----------------

% --------------------------------------------------------------------
function menu_trajectories_Callback(hObject, eventdata, handles)
% hObject    handle to menu_trajectories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_trajectories_export_current_trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to menu_trajectories_export_current_trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.trajectory_interested)
    questdlg('Error. No data to export. Build trajectory first', ...
        'Vessel Studio', ...
        'Ok','Ok');
        
        return
else
    contour=handles.VesselStudio_data.trajectory_interested(:,2:3);
end;
answer = questdlg('Would you like to save data in voxel?', ...
            'Vessel Studio', ...
            'Yes','No','No');

if strcmp(answer,'No')
    temp=contour;
else
    temp=contour_pixel_coordinates_to_voxel(contour,handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).dicom_info) ;
end;
variable(:,1)=handles.VesselStudio_data.trajectory_interested(:,1);
variable(:,2:3)=temp(:,:);

handles.VesselStudio_data.variable=variable;

handles.VesselStudio_data.variable_name='trajectory';
guidata(hObject,handles);
export_variable(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menu_trajectories_export_current_interpolated_Callback(hObject, eventdata, handles)
% hObject    handle to menu_trajectories_export_current_interpolated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_trajectories_separator_Callback(hObject, eventdata, handles)
% hObject    handle to menu_trajectories_separator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_trajectories_export_all_trajectories_Callback(hObject, eventdata, handles)
% hObject    handle to menu_trajectories_export_all_trajectories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~check_valid_data_for_contour_trajectory(hObject, eventdata, handles)
    questdlg('Error. No data to export. Build all trajectories first', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end;

for i=1:size(handles.VesselStudio_data.slices_dataset,2)
    contours_dataset(i)=handles.VesselStudio_data.slices_dataset(i).contour_data;
    contours_dataset(i).coordinates=[];
    contours_dataset(i).coordinates=handles.VesselStudio_data.slices_dataset(i).contour_data.characteristics_points_data.coordinates;
end;

export_contours_from_contours_dataset(hObject, eventdata, handles,contours_dataset);

% --------------------------------------------------------------------
function menu_trajectories_export_all_interpolated_Callback(hObject, eventdata, handles)
% hObject    handle to menu_trajectories_export_all_interpolated (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.interpolation_contour_dataset)
    questdlg('Error. No data to export. Build all trajectories first', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end;



for i=1:size(handles.VesselStudio_data.interpolation_contour_dataset,2)
    contours_dataset(i)=handles.VesselStudio_data.interpolation_contour_dataset(i);
    contours_dataset(i).coordinates=[];
    contours_dataset(i).coordinates=handles.VesselStudio_data.interpolation_contour_dataset(i).characteristics_points_data.coordinates;
end;

export_contours_from_contours_dataset(hObject, eventdata, handles,contours_dataset);




%---------------------Menu Parameters----------------

% --------------------------------------------------------------------
function menu_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to menu_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_parameters_contour_recognition_Callback(hObject, eventdata, handles)
% hObject    handle to menu_parameters_contour_recognition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btn_contour_recognition_parameters_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function menu_parameters_contour_rotation_Callback(hObject, eventdata, handles)
% hObject    handle to menu_parameters_contour_rotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btn_contour_rotation_angle_parameters_Callback(hObject, eventdata, handles);
btn_contour_rotation_characteristics_points_parameters_Callback(hObject, eventdata, handles);
% --------------------------------------------------------------------
function menu_parameters_contour_trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to menu_parameters_contour_trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btn_contour_trajectory_parameters_Callback(hObject, eventdata, handles);
% --------------------------------------------------------------------
function menu_parameters_restore_defaults_Callback(hObject, eventdata, handles)
% hObject    handle to menu_parameters_restore_defaults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
default_parameters(hObject, eventdata, handles);
questdlg('All parameters restored to defaults','Vessel Studio','Ok','Ok');
%-----------------------End Menu block--------------------------


%==================================================================================================================================
%==================================================================================================================================
%==================================================================================================================================
%==================================================================================================================================
%==================================================================================================================================


%-----------------Contour recognition. Current file block-----------
%----------------------------------------------------------------------------------------------------------------------------------



% --- Executes during object creation, after setting all properties.
function txt_count_of_image_to_see_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_count_of_image_to_see (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_count_of_image_to_see_Callback(hObject, eventdata, handles)
% hObject    handle to txt_count_of_image_to_see (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_count_of_image_to_see as text
%        str2double(get(hObject,'String')) returns contents of txt_count_of_image_to_see as a double
handles.VesselStudio_data.image_step=1;
try
        image_step=str2num( get(handles.txt_count_of_image_to_see,'String'));
        
        if (image_step<1) || (image_step>handles.VesselStudio_data.count_of_dicom_files-1)
            questdlg(strcat('+-image to see can not be less 1 and upper ',num2str(handles.VesselStudio_data.count_of_dicom_files-1),', so by default it was taken equals 1'), ...
            'Contour manual selection', ...
            'Ok','Ok');

            image_step=1; 
            set(handles.txt_count_of_image_to_see,'String','1');
        end;
        
        handles.VesselStudio_data.image_step=image_step;
    catch
        questdlg('Problem with entered data: +-image to see by default it was taken equals 1','Vessel Studio','Ok','Ok');
        set(handles.txt_count_of_image_to_see,'String','1');
        image_step=1;
end
guidata(hObject,handles);
%----------------------------------------------------------------------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function cmb_current_dicom_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmb_current_dicom_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cmb_current_dicom_file.
function cmb_current_dicom_file_Callback(hObject, eventdata, handles)
% hObject    handle to cmb_current_dicom_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmb_current_dicom_file contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmb_current_dicom_file
    % Get value of popup

    selected_dicom_file = get(handles.cmb_current_dicom_file, 'value');
    



    %     set(handles.cmb_current_angle,'Value',selected_dicom_file);            


    % Take action based upon selection
    handles.VesselStudio_data.current_dicom_file=selected_dicom_file;
    
    if ~strcmp(get(hObject,'Tag'),'menu_file_import_slices_dataset')&&~strcmp(get(hObject,'Tag'),'menu_file_open_slices_dataset')
        handles.VesselStudio_data.XLim=handles.plot_main.XLim;
        handles.VesselStudio_data.YLim=handles.plot_main.YLim;    
    end

    
%-------------------Contour rotation------------------------
    set(handles.cmb_current_dicom_file_contour_rotation,'Value',selected_dicom_file);        
    
    handles.VesselStudio_data.smoothed_agnles=[];
    cla(handles.plot_similarity_angle);


    
    
%-------------------Contour trajectory----------------------    
    set(handles.cmb_current_dicom_file_contour_trajectory,'Value',selected_dicom_file);        
    
    if ~isempty(handles.VesselStudio_data.slices_dataset(selected_dicom_file).contour_data.characteristics_points_data)
        handles.VesselStudio_data.contour_of_interest=handles.VesselStudio_data.slices_dataset(selected_dicom_file).contour_data.coordinates;
    else
        handles.VesselStudio_data.contour_of_interest=[];
    end;
    % clear contour of interest as dicom image change

    handles.VesselStudio_data.ploted_point_of_interest=[];
    handles.VesselStudio_data.trajectory_interested=[];
    handles.VesselStudio_data.plot_calculated_point_of_interest=[];
    handles.VesselStudio_data.plot_user_point_of_interest=[];
%-----------------------------------------------------------------------


%---------------------Button Next Previous visible----------------------
    set(handles.btn_contour_recognition_next, 'Enable', 'on');
    set(handles.btn_contour_recognition_previous, 'Enable', 'on');

    set(handles.btn_contour_rotation_next, 'Enable', 'on');
    set(handles.btn_contour_rotation_previous, 'Enable', 'on');        
 
    set(handles.btn_contour_trajectory_next, 'Enable', 'on');
    set(handles.btn_contour_trajectory_previous, 'Enable', 'on'); 
    
    if selected_dicom_file==1
        set(handles.btn_contour_recognition_next, 'Enable', 'on');
        set(handles.btn_contour_recognition_previous, 'Enable', 'off');

        set(handles.btn_contour_rotation_next, 'Enable', 'on');
        set(handles.btn_contour_rotation_previous, 'Enable', 'off');     
        
        set(handles.btn_contour_trajectory_next, 'Enable', 'on');
        set(handles.btn_contour_trajectory_previous, 'Enable', 'off');        
        
    end
    
    
    if selected_dicom_file==handles.VesselStudio_data.count_of_dicom_files
        set(handles.btn_contour_recognition_next, 'Enable', 'off');
        set(handles.btn_contour_recognition_previous, 'Enable', 'on');

        set(handles.btn_contour_rotation_next, 'Enable', 'off');
        set(handles.btn_contour_rotation_previous, 'Enable', 'on');
        
        set(handles.btn_contour_trajectory_next, 'Enable', 'off');
        set(handles.btn_contour_trajectory_previous, 'Enable', 'on');        
        
    end
        
    
    guidata(hObject,handles);
    
    
    update_plots(hObject, eventdata, handles);

%----------------------------------------------------------------------------------------------------------------------------------

% --- Executes on button press in btn_contour_recognition_previous.
function btn_contour_recognition_previous_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.cmb_current_dicom_file,'Value',handles.VesselStudio_data.current_dicom_file-1);
    cmb_current_dicom_file_Callback(hObject, eventdata, handles);

% --- Executes on button press in btn_contour_recognition_next.
function btn_contour_recognition_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    set(handles.cmb_current_dicom_file,'Value',handles.VesselStudio_data.current_dicom_file+1);
    cmb_current_dicom_file_Callback(hObject, eventdata, handles)
%-----------------End Contour recognition. Current file block-------



%-----------------Contour recognition. Recognition block------------

% --- Executes during object creation, after setting all properties.
function cmb_contour_recognition_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmb_contour_recognition_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cmb_contour_recognition_method.
function cmb_contour_recognition_method_Callback(hObject, eventdata, handles)
% hObject    handle to cmb_contour_recognition_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmb_contour_recognition_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmb_contour_recognition_method



% --- Executes on button press in btn_contour_recognition_parameters.
function btn_contour_recognition_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    prompt = {
            'Enter count of points for polygon selection:',...
            'Enter count of points for vessel envelope:',...
            'Enter time step:',...
            'Enter count of step for inner iteration:',...
            'Enter count of step for outer iteration:',...
            'Enter lambda:',...
            'Enter alfa:',...
            'Enter epsilon:',....
            'Enter gausian filtration sigma:',...
            'Enter scale level:',...
            'Enter initial boudary scale:',...
            'Enter vessel thickness:',...
            'Enter block boundary scale:'};
        
    title = 'Contour recognition parameters';
    
    default = {
        num2str(handles.VesselStudio_data.contour_recognition_parameters.count_of_polygon_points),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.count_of_envelope_points),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.time_step),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.count_of_inner_iteration),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.count_of_outer_itereation),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.lambda),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.alfa),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.epsilon),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.sigma),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.scale_level),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.initial_boudary_scale),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.vessel_thickness),...
        num2str(handles.VesselStudio_data.contour_recognition_parameters.block_boundary_scale)};

    answer = inputdlg(prompt, title, 1, default);
    if isempty(answer)
        return;
    end;
try

        temp=str2num(answer{1});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput count of polygon points must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.count_of_polygon_points=temp;
        
        temp=str2num(answer{2});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput count of envelope points must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.count_of_envelope_points=temp;
        %set(handles.txt_count_of_points_of_interest_contour,'String',answer{2});!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        
        temp=str2num(answer{3});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput time step must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.time_step=temp;
        
        temp=str2num(answer{4});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput count of inner iteration must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.count_of_inner_iteration=temp;
        
        temp=str2num(answer{5});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput count of outer itereation must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.count_of_outer_itereation=temp;
        
        temp=str2num(answer{6});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput lambda must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.lambda=temp;
        
        temp=str2num(answer{7});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput alfa must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.alfa=temp;
        
        temp=str2num(answer{8});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput epsilon must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.epsilon=temp;
        
        temp=str2num(answer{9});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput sigma must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.sigma=temp;
        
        temp=str2num(answer{10});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput scale level must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.scale_level=temp;
        
        temp=str2num(answer{11});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput initial boudary scale must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.initial_boudary_scale=temp;
        
        temp=str2num(answer{12});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput vessel thickness must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.vessel_thickness=temp;
        
        temp=str2num(answer{13});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput vessel block boundary scale must be a double between 0 and 1, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_recognition_parameters.block_boundary_scale=temp;

        guidata(hObject,handles);
    
catch ME
    questdlg(ME.message, ...
        'Vessel studio', ...
        'Ok','Ok');
    btn_contour_recognition_parameters_Callback(hObject, eventdata, handles);
    return;
end
statusbar(handles.frm_main, 'Desktop status: processing...');

%----------------------------------------------------------------------------------------------------------------------------------
% --- Executes on button press in btn_contour_recognition_draw.
function btn_contour_recognition_draw_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.slices_dataset)
    questdlg('No data to work with. Load DICOM files first','Vessel Studio','Ok','Ok');
    return;
end

%hide controls
handles.VesselStudio_data.edit_mode=true;
guidata(hObject,handles);
visible_contour_controls(hObject, eventdata, handles);

%get dicom info
slices_dataset=handles.VesselStudio_data.slices_dataset;
current_dicom_file=handles.VesselStudio_data.current_dicom_file;
count_of_dicom_files=handles.VesselStudio_data.count_of_dicom_files;    
count_of_points=handles.VesselStudio_data.contour_recognition_parameters.count_of_polygon_points;    

%draw contour
axes(handles.plot_main);

% get previous contour, may be it can fit to image
current_image=slices_dataset(current_dicom_file).image;
pattern_contour=slices_dataset(current_dicom_file).contour_data.coordinates;



previous_contour=[];
if  current_dicom_file>1   
    previous_contour=slices_dataset(current_dicom_file-1).contour_data.coordinates;
end;

next_contour=[];
if current_dicom_file<count_of_dicom_files
    next_contour=slices_dataset(current_dicom_file+1).contour_data.coordinates;
end;

if isempty(pattern_contour) % no current contour
    if isempty(previous_contour)
        pattern_contour=next_contour;
    else
        pattern_contour=previous_contour;
    end;
end;


   
    poly_selection=[];
    
    switch get(handles.cmb_contour_recognition_method,'Value')   
    case 1%'By points' %----------------------------------------------
            if ~isempty(pattern_contour)
            %use parrent contour
                contour_resized_by_count_points=curve_to_equals_lines(pattern_contour,count_of_points);
                poly_selection(:,1)=contour_resized_by_count_points(1:count_of_points-1,1);
                poly_selection(:,2)=contour_resized_by_count_points(1:count_of_points-1,2);
                

                handles.VesselStudio_data.contour_poly_selection=impoly(gca,poly_selection);
            else
            %else draw by hand
                handles.VesselStudio_data.contour_poly_selection=impoly;
            end;
            guidata(hObject,handles);

    case {2,3}%'By hand' %----------------------------------------------
            if ~isempty(pattern_contour)
            %use parrent contour                
                pattern_contour_plot=plot(pattern_contour(:,1),pattern_contour(:,2),'g--');
            end;

            set(handles.btn_contour_recognition_save, 'Visible', 'off');
            set(handles.btn_contour_recognition_cancel, 'Visible', 'off');          
            handles.VesselStudio_data.contour_poly_selection=[];
            guidata(hObject,handles);
            
            hROI = imfreehand('Closed',true);

            if ~isempty(hROI )
                contour_coordinates = getPosition(hROI);
                
                % error if user one  or less points
                if size(contour_coordinates,1)<=1
                    delete(hROI);                    
                    questdlg('You have put only one point which is not enought', ...
                    'Vessel Studio', ...
                    'Ok','Ok');                    
                    btn_contour_recognition_cancel_Callback(hObject, eventdata, handles);
                    return;
                end
                
                %close contour. Add first point to contour coordinates array as last one                
                contour=points_to_closed_contour(contour_coordinates(:,1),contour_coordinates(:,2));

                %resclaling by count of points
                contour_resized_by_count_points=curve_to_equals_lines(contour,count_of_points);
                
                poly_selection(:,1)=contour_resized_by_count_points(1:count_of_points-1,1);
                poly_selection(:,2)=contour_resized_by_count_points(1:count_of_points-1,2);
                
                handles.VesselStudio_data.contour_poly_selection=impoly(gca,poly_selection);
                guidata(hObject,handles);
            end;
            delete(hROI);
            
            if ~isempty(pattern_contour)
                delete(pattern_contour_plot);
            end;
            
            set(handles.btn_contour_recognition_save, 'Visible', 'on');
            set(handles.btn_contour_recognition_cancel, 'Visible', 'on');         
     %case 3%'Automatic' %----------------------------------------------       
         
            % the same like By hand
                
     end;
     handles.VesselStudio_data.current_envelope=[];



% --- Executes on button press in btn_contour_recognition_build_envelope.
function btn_contour_recognition_build_envelope_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_build_envelope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btn_contour_recognition_build_envelope

if isempty(handles.VesselStudio_data.contour_poly_selection)
    return
end;

if ~isempty(handles.VesselStudio_data.main_envelope_plot) 
    delete(handles.VesselStudio_data.current_envelope_plot);
    delete(handles.VesselStudio_data.main_envelope_plot);    
end;



current_contour_points=getPosition(handles.VesselStudio_data.contour_poly_selection);


% if Automatic mode goto contour_recognition function

if (get(handles.cmb_contour_recognition_method,'Value')==3)
    
    
    slices_dataset=handles.VesselStudio_data.slices_dataset;
    current_dicom_file=handles.VesselStudio_data.current_dicom_file;
    dicom_image=slices_dataset(current_dicom_file).image;
    
    initial_vessel_block_boundary = initial_contour_boundary(current_contour_points, dicom_image, handles.VesselStudio_data.contour_recognition_parameters.block_boundary_scale);

    envelope  = contour_recognition( dicom_image, initial_vessel_block_boundary, current_contour_points, handles.VesselStudio_data.contour_recognition_parameters);

else
    %simple envelope building
    contour=points_to_closed_contour(current_contour_points(:,1),current_contour_points(:,2));
    envelope = interpolate_points_to_curve(handles.VesselStudio_data.contour_recognition_parameters.count_of_envelope_points, contour(:,1), contour(:,2),'csape');
end;

axes(handles.plot_main);
hold on, handles.VesselStudio_data.main_envelope_plot=plot(envelope(:,1),envelope(:,2),'r');

axes(handles.plot_current);
hold on, handles.VesselStudio_data.current_envelope_plot=plot(envelope(:,1),envelope(:,2),'r');

handles.VesselStudio_data.current_envelope=envelope;
guidata(hObject,handles);


% --- Executes on button press in btn_contour_recognition_build_all_envelopes.
function btn_contour_recognition_build_all_envelopes_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_build_all_envelopes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of btn_contour_recognition_build_all_envelopes
if isempty(handles.VesselStudio_data.current_envelope)
    questdlg('You have not build envelope to see if it fit your data.', ...
        'Vessel Studio', ...
        'Ok','Ok');
    handles.VesselStudio_data.current_envelope=[];
    guidata(hObject,handles);
    return;
end;


slices_dataset=handles.VesselStudio_data.slices_dataset;
current_dicom_file=handles.VesselStudio_data.current_dicom_file;
count_of_dicom_files=handles.VesselStudio_data.count_of_dicom_files;   



%h = waitbar(0,'Please wait...');


steps = count_of_dicom_files-1;




% save current envelope    

handles.VesselStudio_data.slices_dataset(current_dicom_file).contour_data.coordinates=handles.VesselStudio_data.current_envelope;
handles.VesselStudio_data.slices_dataset(current_dicom_file).contour_data.geometry_characteristics=contour_geometry_characteristics(handles.VesselStudio_data.current_envelope);

current_contour_points=handles.VesselStudio_data.current_envelope;
index=current_dicom_file;

forward=true;
ask_override=true;
skip_contour_recognition=false;

initial_vessel_block_boundary = initial_contour_boundary(current_contour_points, slices_dataset(1).image, handles.VesselStudio_data.contour_recognition_parameters.block_boundary_scale);              

try
    for i = 1:count_of_dicom_files-1

        if forward
            if index+1<=count_of_dicom_files
                index=index+1;
            else
                forward=false;
                index=current_dicom_file-1;
            end
        else
            index=index-1;
        end

        dicom_image=slices_dataset(index).image;
        handles.VesselStudio_data.current_dicom_file=index;
        guidata(hObject,handles);
        

        %if  has envelope user can override or skip
        if ask_override && (~isempty(handles.VesselStudio_data.slices_dataset(index).contour_data.coordinates))


            choice = questdlg('Would you like to override existing contour?', ...
            'Vessel Studio', ...
            'Yes','No','Yes to all','No');
            % Handle response
            switch choice
                case 'Yes'
                    skip_contour_recognition=false;
                case 'No'
                    skip_contour_recognition=true;                
                case 'Yes to all'
                    ask_override=false;
                    skip_contour_recognition=false;                
    %             case 'No to all'
    %                 ask_override=false;
    %                 skip_contour_recognition=true;                

            end
        end;

        %papameters
        if ~(skip_contour_recognition && (~isempty(handles.VesselStudio_data.slices_dataset(index).contour_data.coordinates)))

            envelope  = contour_recognition( dicom_image, initial_vessel_block_boundary, current_contour_points, handles.VesselStudio_data.contour_recognition_parameters);
            handles.VesselStudio_data.slices_dataset(index).contour_data.coordinates=envelope;
            handles.VesselStudio_data.slices_dataset(index).contour_data.geometry_characteristics=contour_geometry_characteristics(envelope);
        else
            envelope=handles.VesselStudio_data.slices_dataset(index).contour_data.coordinates;        
        end



        %calculate new current_contour_points for next contour
        centroid=handles.VesselStudio_data.slices_dataset(index).contour_data.geometry_characteristics.centroid;

        [theta,rho] = cart2pol(envelope(:,1)-centroid(1),envelope(:,2)-centroid(2));
        rho=rho.*(1+handles.VesselStudio_data.contour_recognition_parameters.initial_boudary_scale); % parameter

        [x,y] = pol2cart(theta,rho);

        clearvars current_contour_points;

        current_contour_points(:,1)=x+centroid(1);
        current_contour_points(:,2)=y+centroid(2);

        %waitbar(i / steps);
        
        sb=statusbar(handles.frm_main,'Processing %d of %d (%.1f%%)...',i,steps,100*i/steps); 
        set(sb.ProgressBar,'Visible',1,'Value',100*i/steps);
        
        guidata(hObject,handles);
               

    end
catch
    questdlg(strcat('Error. NAN result with envelope building. Change papameters. Problem image#:',num2str(index) ),...
        'Vessel Studio', ...
        'Ok','Ok');   

end;

%close(h);

 sb=statusbar(handles.frm_main,'Ready');
 set(sb.ProgressBar,'Visible',0);
 
delete(handles.VesselStudio_data.contour_poly_selection);
delete(handles.VesselStudio_data.current_envelope_plot);
delete(handles.VesselStudio_data.main_envelope_plot);
handles.VesselStudio_data.contour_poly_selection=[];
handles.VesselStudio_data.current_envelope=[];


handles.VesselStudio_data.XLim=handles.plot_main.XLim;
handles.VesselStudio_data.YLim=handles.plot_main.YLim;    

handles.VesselStudio_data.edit_mode=false;



set(handles.cmb_current_dicom_file,'Value',current_dicom_file);
guidata(hObject,handles);

visible_contour_controls(hObject, eventdata, handles);
cmb_current_dicom_file_Callback(hObject, eventdata, handles);

%----------------------------------------------------------------------------------------------------------------------------------
% --- Executes on button press in btn_contour_recognition_save.
function btn_contour_recognition_save_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.VesselStudio_data.contour_poly_selection)
    questdlg('No data to save', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end;


if isempty(handles.VesselStudio_data.current_envelope)
    questdlg('You have not build envelope to see if it fit your data.', ...
        'Vessel Studio', ...
        'Ok','Ok');
    return;
end;

%save data   
handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.coordinates=handles.VesselStudio_data.current_envelope;
handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.geometry_characteristics=contour_geometry_characteristics(handles.VesselStudio_data.current_envelope);

%_______________________________________________________



delete(handles.VesselStudio_data.contour_poly_selection);
delete(handles.VesselStudio_data.current_envelope_plot);
delete(handles.VesselStudio_data.main_envelope_plot);

handles.VesselStudio_data.contour_poly_selection=[];
handles.VesselStudio_data.current_envelope=[];


handles.VesselStudio_data.XLim=handles.plot_main.XLim;
handles.VesselStudio_data.YLim=handles.plot_main.YLim;    

handles.VesselStudio_data.edit_mode=false;

guidata(hObject,handles);

visible_contour_controls(hObject, eventdata, handles);
update_plots(hObject, eventdata, handles);


% --- Executes on button press in btn_contour_recognition_cancel.
function btn_contour_recognition_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


if ~isempty(handles.VesselStudio_data.contour_poly_selection)
    delete(handles.VesselStudio_data.contour_poly_selection);
end;
if ~isempty(handles.VesselStudio_data.main_envelope_plot) 
    delete(handles.VesselStudio_data.current_envelope_plot);
    delete(handles.VesselStudio_data.main_envelope_plot);
end;
handles.VesselStudio_data.contour_poly_selection=[];
handles.VesselStudio_data.current_envelope_plot=[];
handles.VesselStudio_data.main_envelope_plot=[];

handles.VesselStudio_data.XLim=handles.plot_main.XLim;
handles.VesselStudio_data.YLim=handles.plot_main.YLim;    

handles.VesselStudio_data.edit_mode=false;

guidata(hObject,handles);

visible_contour_controls(hObject, eventdata, handles);
update_plots(hObject, eventdata, handles);

%-----------------End Contour recognition. Recognition block--------


%-----------------Contour recognition. Statistics block---------

%----------------------------------------------------------------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function cmb_contour_recognition_statistic_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmb_contour_recognition_statistic_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cmb_contour_recognition_statistic_1.
function cmb_contour_recognition_statistic_1_Callback(hObject, eventdata, handles)
% hObject    handle to cmb_contour_recognition_statistic_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmb_contour_recognition_statistic_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmb_contour_recognition_statistic_1
update_statistics_plots(hObject, eventdata, handles);

% --- Executes on button press in btn_contour_recognition_export_statistic_1.
function btn_contour_recognition_export_statistic_1_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_export_statistic_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
export_statistic(hObject, eventdata, handles);

%----------------------------------------------------------------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function cmb_contour_recognition_statistic_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmb_contour_recognition_statistic_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cmb_contour_recognition_statistic_2.
function cmb_contour_recognition_statistic_2_Callback(hObject, eventdata, handles)
% hObject    handle to cmb_contour_recognition_statistic_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmb_contour_recognition_statistic_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmb_contour_recognition_statistic_2
update_statistics_plots(hObject, eventdata, handles);


% --- Executes on button press in btn_contour_recognition_export_statistic_2.
function btn_contour_recognition_export_statistic_2_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_recognition_export_statistic_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
export_statistic(hObject, eventdata, handles)

%----------------------------------------------------------------------------------------------------------------------------------
%-----------------End Contour recognition. Statistics block---------

%==================================================================================================================================
%==================================================================================================================================
%==============UPDATE PLOTS TOOL===================================================================================================
%==================================================================================================================================
%==================================================================================================================================
function update_plots(hObject, eventdata, handles)


if isempty(handles.VesselStudio_data.slices_dataset)
    %clear all axes
    cla(handles.plot_main);    
    cla(handles.plot_previous);    
    cla(handles.plot_current);        
    cla(handles.plot_next);            
    return;
end;

slices_dataset=handles.VesselStudio_data.slices_dataset;

current_dicom_file=handles.VesselStudio_data.current_dicom_file;
count_of_dicom_files=handles.VesselStudio_data.count_of_dicom_files;


%plot current


[image,series_number_str,instance_number_str,slice_location_str,time_str]=slices_dataset_dicom_data_extraction_labels(slices_dataset,current_dicom_file);
axes(handles.plot_main);
imshow(image,[]);

cellstrg(1)={series_number_str};
cellstrg(2)={instance_number_str};
cellstrg(3)={slice_location_str};
cellstrg(4)={time_str};    
cellstrg(5)={'Current'};    
set(handles.lbl_current_image,'String',cellstrg);

axes(handles.plot_current);
imshow(image,[]);


set(handles.lbl_current_contour_info,'String','');

%check is exists contour data
if ~isempty(slices_dataset(current_dicom_file).contour_data.coordinates)
    
    [contour,area_str,perimeter_str,angle_str,centroid_str]=slices_dataset_contour_data_extraction_labels(slices_dataset,current_dicom_file);
    cellstrg(1)={'Current contour info:'};        
    cellstrg(2)={area_str};
    cellstrg(3)={perimeter_str};
    cellstrg(4)={angle_str};
    cellstrg(5)={centroid_str}; 
    
    set(handles.lbl_current_contour_info,'String',cellstrg);

    axes(handles.plot_main);
    hold on,handles.contour_plot=plot(contour(:,1),contour(:,2),'g--');
end;


%plot previous - handles.image_step               
if current_dicom_file>handles.VesselStudio_data.image_step
    [image,series_number_str,instance_number_str,slice_location_str,time_str]=slices_dataset_dicom_data_extraction_labels(slices_dataset,current_dicom_file-handles.VesselStudio_data.image_step) ;   
    axes(handles.plot_previous);
    imshow(image,[]);

    cellstrg(1)={series_number_str};
    cellstrg(2)={instance_number_str};
    cellstrg(3)={slice_location_str};
    cellstrg(4)={time_str};   
    
    cellstrg(5)={strcat('Current - ',num2str(handles.VesselStudio_data.image_step))};        
    set(handles.lbl_previous_image,'String',cellstrg);

else
    cla(handles.plot_previous);
    handles.lbl_previous_image.String='Previous';
end;

%plot next + handles.image_step                
if current_dicom_file<=count_of_dicom_files-handles.VesselStudio_data.image_step
    [image,series_number_str,instance_number_str,slice_location_str,time_str]=slices_dataset_dicom_data_extraction_labels(slices_dataset,current_dicom_file+handles.VesselStudio_data.image_step);
    axes(handles.plot_next);
    imshow(image,[]);
    
    cellstrg(1)={series_number_str};
    cellstrg(2)={instance_number_str};
    cellstrg(3)={slice_location_str};
    cellstrg(4)={time_str}; 

    cellstrg(5)={strcat('Current + ',num2str(handles.VesselStudio_data.image_step))};        
    set(handles.lbl_next_image,'String',cellstrg);
                
else
    cla(handles.plot_next);
    handles.lbl_next_image.String='Next';
end;


    
update_statistics_plots(hObject, eventdata, handles);   
 
update_contour_rotation_plot(hObject, eventdata,handles);

update_contour_trajectory_plot(hObject, eventdata,handles);

handles = guidata(hObject);
set(handles.plot_main, 'XLim', handles.VesselStudio_data.XLim, 'YLim', handles.VesselStudio_data.YLim);    
guidata(hObject,handles);
    
    
    
function update_statistics_plots(hObject, eventdata, handles)

count_of_dicom_files=handles.VesselStudio_data.count_of_dicom_files;
angles=[];
areas=[];
perimeters=[];
centroids=[];

index=1;

current_angle=[];
current_area=[]; 
current_perimeter=[];
current_centroid=[];
     
for i=1:count_of_dicom_files
    
    if ~isempty(handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics)
       
        time=handles.VesselStudio_data.slices_dataset(i).contour_data.time;
        angle=handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics.angle;
        area=handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics.area;
        perimeter=handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics.perimeter;    
        
        angles(index,:)=[time,angle];
        areas(index,:)=[time,area];
        perimeters(index,:)=[time,perimeter];       
        
        centroids(index,:)=[time,handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics.centroid];
        
       
        %current dot
        if (i==handles.VesselStudio_data.current_dicom_file)
             current_angle=angles(index,:);
             current_area=areas(index,:); 
             current_perimeter=perimeters(index,:);
             current_centroid=centroids(index,:);            
        end;
        
        index=index+1;
    end;
    
end;


if size(angles,1)<1
    return
end;

% plot data according to combobox

axes(handles.plot_statistic_1);
cla(handles.plot_statistic_1);


switch get(handles.cmb_contour_recognition_statistic_1,'Value')
    case 1 % Area in time  
        plot(areas(:,1),areas(:,2),'b');
        legend_text='area';
        if ~isempty(current_area)
            hold on
            plot(current_area(:,1),current_area(:,2),'r*');
            legend_text=char(legend_text,strcat('current point:',num2str(handles.VesselStudio_data.current_dicom_file)));
        end;
        view([0 90]);                
    case 2 % Perimeter in time
        plot(perimeters(:,1),perimeters(:,2),'b');
        legend_text='perimeter';            
        if ~isempty(current_perimeter)
            hold on
            plot(current_perimeter(:,1),current_perimeter(:,2),'r*');
            legend_text=char(legend_text,strcat('current point:',num2str(handles.VesselStudio_data.current_dicom_file)));
        end;        
        view([0 90]);                
    case 3 % Angle in time
        plot(angles(:,1),angles(:,2),'b');
        legend_text='angle';                        
        if ~isempty(current_angle)
            hold on
            plot(current_angle(:,1),current_angle(:,2),'r*');
            legend_text=char(legend_text,strcat('current point:',num2str(handles.VesselStudio_data.current_dicom_file)));
        end;        
        view([0 90]);                
    case 4 % Centroid in time 
        plot3(centroids(:,2),centroids(:,3),centroids(:,1),'b');
        legend_text='centroid';                                    
        if ~isempty(current_centroid)
            hold on
            plot3(current_centroid(:,2),current_centroid(:,3),current_centroid(:,1),'r*');
            legend_text=char(legend_text,strcat('current point:',num2str(handles.VesselStudio_data.current_dicom_file)));
        end;
        view([45 45]);
end
legend(legend_text);


axes(handles.plot_statistic_2);
cla(handles.plot_statistic_2);

switch get(handles.cmb_contour_recognition_statistic_2,'Value')
    case 1 % Area in time  
        plot(areas(:,1),areas(:,2),'b');
        legend_text='area';                                                            
        if ~isempty(current_area)
            hold on
            plot(current_area(:,1),current_area(:,2),'r*');
            legend_text=char(legend_text,strcat('current point:',num2str(handles.VesselStudio_data.current_dicom_file)));
        end;
        view([0 90]);                
    case 2 % Perimeter in time
        plot(perimeters(:,1),perimeters(:,2),'b');
        legend_text='perimeter';                                                
        if ~isempty(current_perimeter)
            hold on
            plot(current_perimeter(:,1),current_perimeter(:,2),'r*');
            legend_text=char(legend_text,strcat('current point:',num2str(handles.VesselStudio_data.current_dicom_file)));
        end;        
        view([0 90]);                
    case 3 % Angle in time
        plot(angles(:,1),angles(:,2),'b');
        legend_text='angle';                                                
        if ~isempty(current_angle)
            hold on
            plot(current_angle(:,1),current_angle(:,2),'r*');
            legend_text=char(legend_text,strcat('current point:',num2str(handles.VesselStudio_data.current_dicom_file)));
        end;        
        view([0 90]);                
    case 4 % Centroid in time 
        plot3(centroids(:,2),centroids(:,3),centroids(:,1),'b');
        legend_text='centroid';                                                
        if ~isempty(current_centroid)
            hold on
            plot3(current_centroid(:,2),current_centroid(:,3),current_centroid(:,1),'r*');
            legend_text=char(legend_text,strcat('current point:',num2str(handles.VesselStudio_data.current_dicom_file)));
        end;
        view([45 45]);
end
legend(legend_text);

handles.VesselStudio_data.contour_areas=areas;
handles.VesselStudio_data.contour_perimeters=perimeters;
handles.VesselStudio_data.contour_angles=angles;
handles.VesselStudio_data.contour_centroids=centroids;
guidata(hObject,handles);  


function update_contour_rotation_plot(hObject, eventdata, handles)
if isempty(handles.VesselStudio_data.slices_dataset)
    return;
end;


slices_dataset=handles.VesselStudio_data.slices_dataset;

current_dicom_file=handles.VesselStudio_data.current_dicom_file;
count_of_dicom_files=handles.VesselStudio_data.count_of_dicom_files;

update_angles_dynamics_plot(hObject, eventdata,handles);




contour=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.coordinates;

if isempty(contour)
    cla(handles.plot_characteristics_poins);        
    cla(handles.plot_similarity_angle);        
    cla(handles.plot_angles_dynamics);            
    return;
end;
        


if handles.VesselStudio_data.current_dicom_file>1
    
    contour_data=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data;
    contour_data_to_compare=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data;
    
    if isempty(contour_data.coordinates)||isempty(contour_data_to_compare.coordinates)
        angle=0;
    else
        angle=contour_data_to_compare.geometry_characteristics.angle-contour_data.geometry_characteristics.angle;
    end
    
    cla(handles.plot_characteristics_poins);        
    axes(handles.plot_characteristics_poins);
    plot_relative_contour_rotation(contour_data, contour_data_to_compare,angle,handles.plot_characteristics_poins);
    
else
    contour_data=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data;    
    contour=contour_data.coordinates;
    
    if ~isempty(contour_data.characteristics_points_data)
        contour_characteristics_points=contour_data.characteristics_points_data.coordinates;
    else
        contour_characteristics_points=[];
    end;
    
    axes(handles.plot_characteristics_poins);
    cla(handles.plot_characteristics_poins);            
    plot(contour(:,1),contour(:,2),'r');
    hold on;
    if ~isempty(contour_characteristics_points)
        plot(contour_characteristics_points(:,1),contour_characteristics_points(:,2),'r*');    
        legend('current contour','characteristics points');        
    else
        legend('current contour');                
    end;
end


function update_angles_dynamics_plot(hObject, eventdata, handles)
if isempty(handles.VesselStudio_data.slices_dataset)
    return;
end;

slices_dataset=handles.VesselStudio_data.slices_dataset;

current_dicom_file=handles.VesselStudio_data.current_dicom_file;
count_of_dicom_files=handles.VesselStudio_data.count_of_dicom_files;

axes(handles.plot_angles_dynamics);
cla(handles.plot_angles_dynamics);

for i=1:count_of_dicom_files
    if ~isempty(slices_dataset(i).contour_data.geometry_characteristics)
        angles(i)=slices_dataset(i).contour_data.geometry_characteristics.angle;
    else
        angles(i)=0;
    end;
    if i==current_dicom_file
        point=[i,angles(i)];
    end
end
plot(angles,'b');
hold on;
plot(point(:,1),point(:,2),'r*');
if current_dicom_file>1
    set(handles.txt_contour_rotation_angle,'String',num2str(angles(current_dicom_file)-angles(current_dicom_file-1)));
else
    set(handles.txt_contour_rotation_angle,'String',num2str(angles(current_dicom_file)));    
end;
legend('angle',strcat('current position:',num2str(current_dicom_file)));%,'Location','northoutside','Orientation','horizontal');


function update_contour_trajectory_plot(hObject, eventdata,handles)

[image,series_number_str,instance_number_str,slice_location_str,time_str]=slices_dataset_dicom_data_extraction_labels(handles.VesselStudio_data.slices_dataset,handles.VesselStudio_data.current_dicom_file);

cellstrg(1)={strcat(series_number_str,'; ',instance_number_str)};
cellstrg(2)={strcat(slice_location_str,'; ',time_str)};
set(handles.lbl_contour_trajectory_current_dicom_info,'String',cellstrg);

cla(handles.plot_point_of_interest);
axes(handles.plot_point_of_interest);
imshow(image,[]);

if ~isempty(handles.VesselStudio_data.contour_of_interest)

    hold on;
    plot(handles.VesselStudio_data.contour_of_interest(:,1),handles.VesselStudio_data.contour_of_interest(:,2),'r.');
    count_of_points=size(handles.VesselStudio_data.contour_of_interest,1)-1;
    set(handles.slider_contour_trajectory_point_coordinates,'Enable','on');    
    set(handles.slider_contour_trajectory_point_coordinates, 'Min', 1);
    set(handles.slider_contour_trajectory_point_coordinates, 'Max', count_of_points);
    set(handles.slider_contour_trajectory_point_coordinates, 'Value', 1);
    set(handles.slider_contour_trajectory_point_coordinates, 'SliderStep', [1/(count_of_points-1) , 1/(count_of_points-1) ]);

    set(handles.txt_contour_trajectory_count_of_contour_points,'String',num2str(count_of_points));

    set(handles.txt_contour_trajectory_point_coordinates,'String',num2str(handles.VesselStudio_data.contour_of_interest(1,:)));
else
    set(handles.slider_contour_trajectory_point_coordinates,'Enable','off');    
    set(handles.txt_contour_trajectory_count_of_contour_points,'String','');
    set(handles.txt_contour_trajectory_point_coordinates,'String','');
end;




function visible_contour_controls(hObject, eventdata, handles)

if handles.VesselStudio_data.edit_mode
    edit_mode='on';
    hide_controls='off';
else
    edit_mode='off';
    hide_controls='on';
    
end;

set(handles.btn_contour_recognition_draw, 'Enable', hide_controls);
set(handles.btn_contour_recognition_build_envelope, 'Visible', edit_mode);
set(handles.btn_contour_recognition_build_all_envelopes, 'Visible', edit_mode);
set(handles.btn_contour_recognition_save, 'Visible', edit_mode);
set(handles.btn_contour_recognition_cancel, 'Visible', edit_mode);


set(handles.cmb_contour_recognition_method, 'Enable', hide_controls);
set(handles.cmb_contour_recognition_statistic_1, 'Enable', hide_controls);
set(handles.cmb_contour_recognition_statistic_2, 'Enable', hide_controls);

set(handles.cmb_current_dicom_file, 'Enable', hide_controls);
set(handles.btn_contour_recognition_next, 'Enable', hide_controls);
set(handles.btn_contour_recognition_previous, 'Enable', hide_controls);


set(handles.cmb_current_dicom_file_contour_rotation, 'Enable', hide_controls);
set(handles.btn_contour_rotation_next, 'Enable', hide_controls);
set(handles.btn_contour_rotation_previous, 'Enable', hide_controls);

% 
% set(handles.cmb_contour_of_interest, 'Enable', hide_controls);
% set(handles.btn_next_contour, 'Enable', hide_controls);
% set(handles.btn_previous_contour, 'Enable', hide_controls);

guidata(hObject,handles);

%==================================================================================================================================
%==================================================================================================================================
%=============EXPORT TOOLS=========================================================================================================
%==================================================================================================================================
%==================================================================================================================================

function export_variable(hObject, eventdata, handles)
if ~isempty(handles.VesselStudio_data.variable)
    
    prompt = {'Enter variable name:'};
    title = 'Data exporting...';

    variable_name = {handles.VesselStudio_data.variable_name};
    answer = inputdlg(prompt, title, 1, variable_name);
    if isempty(answer)
        return;
    end;
    assignin('base', answer{1},handles.VesselStudio_data.variable);

    questdlg('Data exported successfully', ...
        'Vessel Studio', ...
        'Ok','Ok');
else
    questdlg('No data to export.', ...
        'Vessel Studio', ...
        'Ok','Ok');
end;



function export_statistic(hObject, eventdata, handles)

variable_type=0;

if strcmp(get(hObject,'Tag'),'btn_contour_recognition_export_statistic_1')
    variable_type=get(handles.cmb_contour_recognition_statistic_1,'Value');
end
if strcmp(get(hObject,'Tag'),'btn_contour_recognition_export_statistic_2')
    variable_type=get(handles.cmb_contour_recognition_statistic_2,'Value');
end;

switch variable_type
    case 0 %no data
        questdlg('Error. No data to export','Vessel Studio','Ok','Ok');
        return;

    case 1 % Area in time  
        handles.VesselStudio_data.variable=handles.VesselStudio_data.contour_areas;
        handles.VesselStudio_data.variable_name='areas_evolution';

    case 2 % Perimeter in time
        handles.VesselStudio_data.variable=handles.VesselStudio_data.contour_perimeters;
        handles.VesselStudio_data.variable_name='perimeters_evolution';

    case 3 % Angle in time
        handles.VesselStudio_data.variable=handles.VesselStudio_data.contour_angles;
        handles.VesselStudio_data.variable_name='angles_evolution';

    case 4 % Centroid in time 
        handles.VesselStudio_data.variable=handles.VesselStudio_data.contour_centroids;
        handles.VesselStudio_data.variable_name='centroids_evolution';

end
guidata(hObject,handles);

if isempty(handles.VesselStudio_data.variable)
    questdlg('Error. No data to export', ...
        'Vessel Studio', ...
        'Ok','Ok');
    
    return;
end;
export_variable(hObject, eventdata, handles);


%==================================================================================================================================
%==================================================================================================================================
%=============Contour rotation=====================================================================================================
%==================================================================================================================================
%==================================================================================================================================

%Choose current dicom file
%----------------------------------------------------------------------------------------------------------------------------------
% --- Executes during object creation, after setting all properties.
function cmb_current_dicom_file_contour_rotation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmb_current_dicom_file_contour_rotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in cmb_current_dicom_file_contour_rotation.
function cmb_current_dicom_file_contour_rotation_Callback(hObject, eventdata, handles)
% hObject    handle to cmb_current_dicom_file_contour_rotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmb_current_dicom_file_contour_rotation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmb_current_dicom_file_contour_rotation
set(handles.cmb_current_dicom_file,'Value',get(hObject,'Value'));
cmb_current_dicom_file_Callback(hObject, eventdata, handles);


% --- Executes on button press in btn_contour_rotation_previous.
function btn_contour_rotation_previous_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btn_contour_recognition_previous_Callback(hObject, eventdata, handles);

% --- Executes on button press in btn_contour_rotation_next.
function btn_contour_rotation_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btn_contour_recognition_next_Callback(hObject, eventdata, handles);

%Get user data about angle
%----------------------------------------------------------------------------------------------------------------------------------



% --- Executes during object creation, after setting all properties.
function cmb_contour_rotation_similarity_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmb_contour_rotation_similarity_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in cmb_contour_rotation_similarity_method.
function cmb_contour_rotation_similarity_method_Callback(hObject, eventdata, handles)
% hObject    handle to cmb_contour_rotation_similarity_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmb_contour_rotation_similarity_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmb_contour_rotation_similarity_method



% --- Executes during object creation, after setting all properties.
function txt_contour_rotation_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_contour_rotation_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txt_contour_rotation_angle_Callback(hObject, eventdata, handles)
% hObject    handle to txt_contour_rotation_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_contour_rotation_angle as text
%        str2double(get(hObject,'String')) returns contents of txt_contour_rotation_angle as a double
value=str2num(get(hObject,'String'));
if isempty(value)
    questdlg('Angle should be double but not a string', ...
        'Vessel Builder', ...
        'Ok','Ok');    
    set(hObject,'String',num2str(get(handles.slider_contour_rotation_angle_increment,'Value')))
    return;
end;

if (value>=get(handles.slider_contour_rotation_angle_increment,'Min')) && (value<=get(handles.slider_contour_rotation_angle_increment,'Max'))
    set(handles.slider_contour_rotation_angle_increment,'Value',value);
else
    questdlg(strcat('Angle should be double in range: [',num2str(-handles.VesselStudio_data.contour_angle_parameters.angle_range),',',num2str(-handles.VesselStudio_data.contour_angle_parameters.angle_range),']. Change parameters first'), ...
        'Vessel Studio', ...
        'Ok','Ok');    
    set(hObject,'String',num2str(get(handles.slider_contour_rotation_angle_increment,'Value')))    
end;

% --- Executes during object creation, after setting all properties.
function slider_contour_rotation_angle_increment_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_contour_rotation_angle_increment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider_contour_rotation_angle_increment_Callback(hObject, eventdata, handles)
% hObject    handle to slider_contour_rotation_angle_increment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.txt_contour_rotation_angle,'String',num2str(get(hObject,'Value')));


%Calculate angle
%----------------------------------------------------------------------------------------------------------------------------------

% --- Executes on button press in btn_contour_rotation_angle_parameters.
function btn_contour_rotation_angle_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_angle_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    prompt = {
            'Enter count of points for similarity search:',...
            'Enter rotation angle range:',...
            'Enter rotation angle scale:'};
        
    title = 'Contour angle parameters';
    
    default = {
        num2str(handles.VesselStudio_data.contour_angle_parameters.count_of_similarity_points),...
        num2str(handles.VesselStudio_data.contour_angle_parameters.angle_range),...        
        num2str(handles.VesselStudio_data.contour_angle_parameters.angle_scale)};

    answer = inputdlg(prompt, title, 1, default);
    if isempty(answer)
        return;
    end;
try

       
        temp=str2num(answer{1});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput count of points for similarity search must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_angle_parameters.count_of_similarity_points=temp;
        
        temp=str2num(answer{2});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput rotation angle range must be a integer, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_angle_parameters.angle_range=temp;
        
        temp=str2num(answer{3});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput rotation angle scale must be a double, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_angle_parameters.angle_scale=temp;
        
        
        set(handles.slider_contour_rotation_angle_increment, 'Min', -handles.VesselStudio_data.contour_angle_parameters.angle_range);
        set(handles.slider_contour_rotation_angle_increment, 'Max', handles.VesselStudio_data.contour_angle_parameters.angle_range);
        set(handles.slider_contour_rotation_angle_increment, 'Value', 0);
        set(handles.slider_contour_rotation_angle_increment, 'SliderStep', [handles.VesselStudio_data.contour_angle_parameters.angle_scale , handles.VesselStudio_data.contour_angle_parameters.angle_scale ]);
        
        
        guidata(hObject,handles);
    
catch ME
    questdlg(ME.message, ...
        'Vessel Studio', ...
        'Ok','Ok');
    btn_contour_rotation_angle_parameters_Callback(hObject, eventdata, handles);
    return;
end

% --- Executes on button press in btn_contour_rotation_calculate_angle.
function btn_contour_rotation_calculate_angle_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_calculate_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if handles.VesselStudio_data.current_dicom_file==1
        questdlg('This is base contour and its default value you can set by "Set angle"', ...
            'Vessel Studio', ...
            'Ok','Ok');
        cla(handles.plot_similarity_angle);
        return;
    end
    

    pattern_contour_data=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data;
    contour_data=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data;

    
    
    if isempty(contour_data.coordinates)||isempty(pattern_contour_data.coordinates)
        questdlg('Not all contours builded. Build it first at "Contour selection"', ...
            'Vessel Studio', ...
            'Ok','Ok');
        cla(handles.plot_similarity_angle);
        return;
    end;
    
    
    switch get(handles.cmb_contour_rotation_similarity_method,'Value')
                case 1
                    method='distance';
                    legend_text='distance from centroid';                    
                case 2
                    method='derivative';                
                    legend_text='derivative of contour';                    
    end;  
    %h = waitbar(1,'Please wait...');
    sb=statusbar(handles.frm_main,'Busy...');
    set(sb.ProgressBar,'Visible',1,'Value',100);
    
    [angle,max_similarity,distance_1,distance_2] = angle_of_relative_contour_rotation(pattern_contour_data,...
                                                                                      contour_data,...
                                                                                      handles.VesselStudio_data.contour_angle_parameters.count_of_similarity_points,...
                                                                                      handles.VesselStudio_data.contour_angle_parameters.angle_range,...
                                                                                      handles.VesselStudio_data.contour_angle_parameters.angle_scale,...
                                                                                      method,handles.plot_characteristics_poins);
    %close(h);
    
    statusbar(handles.frm_main,'Ready');
    set(sb.ProgressBar,'Visible',0);

    handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.geometry_characteristics.angle=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data.geometry_characteristics.angle+angle;        
    
    set(handles.txt_contour_rotation_angle,'String',num2str(angle));
    set(handles.slider_contour_rotation_angle_increment,'Value',angle);    
    
    set(handles.lbl_contour_rotation_current_similarity,'String',strcat('Current similarity:',num2str(max_similarity)));
    
    axes(handles.plot_similarity_angle);
    cla(handles.plot_similarity_angle);
    plot(distance_1,'r');
    hold on
    plot(distance_2,'b');
    
    legend(strcat(legend_text,' for base contour'),strcat(legend_text,' for compared contour'));%,'Location','northoutside','Orientation','horizontal');
    
    update_contour_rotation_plot(hObject, eventdata, handles);   
    
    for i=handles.VesselStudio_data.current_dicom_file:handles.VesselStudio_data.count_of_dicom_files
        handles.VesselStudio_data.slices_dataset(i).contour_data.characteristics_points_data=[];        
    end

    guidata(hObject,handles);  
    %update_contour_rotation_plot(hObject, eventdata, handles);


% --- Executes on button press in btn_contour_rotation_set_angle.
function btn_contour_rotation_set_angle_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_set_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    

    angle=str2num(get(handles.txt_contour_rotation_angle,'String'));
    
    count_of_points=handles.VesselStudio_data.contour_angle_parameters.count_of_similarity_points;

    
    if isempty(handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.coordinates)
        questdlg('Not all contours builded. Build it first at "Contour selection"', ...
            'Vessel Studio', ...
            'Ok','Ok');
        cla(handles.plot_similarity_angle);
        return;
    end;


    sb=statusbar(handles.frm_main,'Busy...');
    set(sb.ProgressBar,'Visible',1,'Value',100);
    
   
    contour_data_to_compare=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data;
    characteristics_points_data_to_compare = contour_characteristics_points_data(contour_data_to_compare, count_of_points,angle);    
    contour_data_to_compare.characteristics_points_data=characteristics_points_data_to_compare;
    centroid_to_compare=contour_data_to_compare.geometry_characteristics.centroid;
    
    if handles.VesselStudio_data.current_dicom_file>1
        
        
        if isempty(handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data.coordinates)
            questdlg('Not all contours builded. Build it first at "Contour selection"', ...
                'Vessel Studio', ...
                'Ok','Ok');
            cla(handles.plot_similarity_angle);
            statusbar(handles.frm_main,'Ready');
            set(sb.ProgressBar,'Visible',0);            
            return;
        end;
        
        
        
        contour_data=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data;
        characteristics_points = contour_characteristics_points_data(contour_data,count_of_points,0);
        contour_data.characteristics_points_data=characteristics_points;
        centroid=contour_data.geometry_characteristics.centroid;    
    else
        characteristics_points=characteristics_points_data_to_compare;
        centroid=centroid_to_compare;
       
    end;
    
    

    [contour_similarity,similarity_dr,current_r1,current_r2,current_dr1,current_dr2]= contour_similarity_by_characteristics_points(characteristics_points.coordinates, centroid,characteristics_points_data_to_compare.coordinates,centroid_to_compare);   

    statusbar(handles.frm_main,'Ready');
    set(sb.ProgressBar,'Visible',0);

   switch get(handles.cmb_contour_rotation_similarity_method,'Value')
                case 1
                    distance_1=current_r1;
                    distance_2=current_r2;
                    max_similarity=contour_similarity;
                    legend_text='distance';
                case 2
                    distance_1=current_dr1;
                    distance_2=current_dr2;
                    max_similarity=similarity_dr;
                    legend_text='derivative';                    
                    
    end;  
    
    set(handles.lbl_contour_rotation_current_similarity,'String',strcat('Current similarity:',num2str(max_similarity)));
    
    axes(handles.plot_similarity_angle);
    cla(handles.plot_similarity_angle);
    plot(distance_1,'r');
    hold on
    plot(distance_2,'b');
    legend(strcat(legend_text,' for base contour'),strcat(legend_text,' for compared contour'));%,'Location','northoutside','Orientation','horizontal');
    

    if handles.VesselStudio_data.current_dicom_file>1
        handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.geometry_characteristics.angle=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data.geometry_characteristics.angle+angle;        
    else
        handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.geometry_characteristics.angle=angle;                
        questdlg('This is base contour and its default value have been set', ...
            'Vessel Studio', ...
            'Ok','Ok');
        
    end
    


    
    
    for i=handles.VesselStudio_data.current_dicom_file:handles.VesselStudio_data.count_of_dicom_files
        handles.VesselStudio_data.slices_dataset(i).contour_data.characteristics_points_data=[];        
    end
    guidata(hObject,handles); 
    update_contour_rotation_plot(hObject, eventdata, handles);    

% --- Executes on button press in btn_contour_rotation_calculate_all_angles.
function btn_contour_rotation_calculate_all_angles_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_calculate_all_angles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    if ~check_valid_data_for_contour_rotation(hObject, eventdata, handles)
        return;
    end;

    statusbar(handles.frm_main,'Busy...');
    handles.VesselStudio_data.contour_angle_parameters.slice_dataset=handles.VesselStudio_data.slices_dataset;
    switch get(handles.cmb_contour_rotation_similarity_method,'Value')
                case 1
                    method='distance';
                case 2
                    method='derivative';                
    end;     
    angles=contour_rotation_angels(handles.VesselStudio_data.contour_angle_parameters,method);

    for i=1:handles.VesselStudio_data.count_of_dicom_files
        handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics.angle=angles(i);
        handles.VesselStudio_data.slices_dataset(i).contour_data.characteristics_points_data=[];                
    end
    

    guidata(hObject,handles);  
    update_contour_rotation_plot(hObject, eventdata, handles);
    

    set(handles.cmb_current_dicom_file, 'value',1);
    guidata(hObject,handles);    
    cmb_current_dicom_file_Callback(hObject, eventdata, handles);
    statusbar(handles.frm_main,'Ready');
    

% --- Executes on button press in btn_contour_rotation_smooth_noisy_angle.
function btn_contour_rotation_smooth_noisy_angle_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_smooth_noisy_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    prompt = {
            'Enter number of splice_pieces:',...
            'Enter spline order:'};
        
    title = 'Angle spline parameters';
    
    default = {
        num2str(round(handles.VesselStudio_data.count_of_dicom_files/3)),...
        num2str(3)};

    answer = inputdlg(prompt, title, 1, default);
    if isempty(answer)
        return;
    end;
try

       
        temp=str2num(answer{1});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput number of splice_pieces must be a integer, not a string.');
            throw(ME);
        end;
        number_of_splice_pieces=temp;
        
        temp=str2num(answer{2});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput spline order must be a integer, not a string.');
            throw(ME);
        end;
        spline_order=temp;
        
      
    
catch ME
    questdlg(ME.message, ...
        'Vessel Studio', ...
        'Ok','Ok');
    btn_contour_rotation_smooth_noisy_angle_Callback(hObject, eventdata, handles);
    return;
end
    for i=1:handles.VesselStudio_data.count_of_dicom_files
        data(i)=handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics.angle;
    end
    
    handles.VesselStudio_data.smoothed_agnles=spline_noisy_data(data,number_of_splice_pieces,spline_order);
    update_angles_dynamics_plot(hObject, eventdata, handles);
    
    
    axes(handles.plot_angles_dynamics)
    hold on;
    plot(handles.VesselStudio_data.smoothed_agnles,'r');
    legend('angle',strcat('current position:',num2str(handles.VesselStudio_data.current_dicom_file)));%,'smoothed angle','Location','northoutside','Orientation','horizontal');
    guidata(hObject,handles);      



% --- Executes on button press in btn_contour_rotation_save_smoothed_angles.
function btn_contour_rotation_save_smoothed_angles_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_save_smoothed_angles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if isempty(handles.VesselStudio_data.smoothed_agnles)
            questdlg('No data to save. Build smoothed interpolation first', ...
                'Vessel Studio', ...
                'Ok','Ok');

        return;
    end;
    for i=1:handles.VesselStudio_data.count_of_dicom_files
        handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics.angle=handles.VesselStudio_data.smoothed_agnles(i);
        handles.VesselStudio_data.slices_dataset(i).contour_data.characteristics_points_data=[];        
    end
    

    guidata(hObject,handles);  
    update_contour_rotation_plot(hObject, eventdata, handles);
    
    questdlg('New data saved to all contours ', ...
                'Vessel Studio', ...
                'Ok','Ok');

%Calculate characteristics points
%----------------------------------------------------------------------------------------------------------------------------------

% --- Executes on button press in btn_contour_rotation_characteristics_points_parameters.
function btn_contour_rotation_characteristics_points_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_characteristics_points_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    prompt = {
            'Enter count of characteristics_points:',...
            'Enter epsilon for compared characteristics points:'};
        
    title = 'Characteristics points parameters';
    
    default = {
        num2str(handles.VesselStudio_data.contour_characteristics_points_parameters.count_of_characteristics_points),...
        num2str(handles.VesselStudio_data.contour_characteristics_points_parameters.epsilon_compared_characteristics_points)};

    answer = inputdlg(prompt, title, 1, default);
    if isempty(answer)
        return;
    end;
try

       
        temp=str2num(answer{1});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput number of splice_pieces must be a integer, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_characteristics_points_parameters.count_of_characteristics_points=temp;
        
        temp=str2num(answer{2});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput spline order must be a integer, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_characteristics_points_parameters.epsilon_compared_characteristics_points=temp;
        
        handles.VesselStudio_data.contour_characteristics_points_parameters.slice_dataset=handles.VesselStudio_data.slices_dataset;
        guidata(hObject,handles);         
        
        
catch ME
    questdlg(ME.message, ...
        'Vessel Studio', ...
        'Ok','Ok');
    btn_contour_rotation_characteristics_points_parameters_Callback(hObject, eventdata, handles);
    return;
end  

% --- Executes on button press in btn_contour_rotation_build_characteristics_points.
function btn_contour_rotation_build_characteristics_points_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_build_characteristics_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    if (handles.VesselStudio_data.current_dicom_file==1)
        handles.VesselStudio_data.slices_dataset(1).contour_data.characteristics_points_data=contour_characteristics_points_data(   handles.VesselStudio_data.slices_dataset(1).contour_data,...
                                                                                                                                    handles.VesselStudio_data.contour_characteristics_points_parameters.count_of_characteristics_points,...
                                                                                                                                    handles.VesselStudio_data.slices_dataset(1).contour_data.geometry_characteristics.angle);        
        guidata(hObject,handles);          
        update_contour_rotation_plot(hObject, eventdata, handles);        
        return;
    end
    
    if isempty(handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data.characteristics_points_data)
        questdlg(strcat('Not have been builded points correpondence for previous dicom file:',num2str(handles.VesselStudio_data.current_dicom_file-1)), ...
        'Vessel Studio', ...
        'Ok','Ok');
        
        return;
    end;
    
    
    angle=handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.geometry_characteristics.angle-handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data.geometry_characteristics.angle;        
    
    handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data.characteristics_points_data=build_compared_characteristics_points(  handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file).contour_data,...
                                                                                                                                                                            handles.VesselStudio_data.slices_dataset(handles.VesselStudio_data.current_dicom_file-1).contour_data,...
                                                                                                                                                                            handles.VesselStudio_data.contour_characteristics_points_parameters.count_of_characteristics_points,...
                                                                                                                                                                            handles.VesselStudio_data.contour_characteristics_points_parameters.epsilon_compared_characteristics_points,...
                                                                                                                                                                            angle,...
                                                                                                                                                                            handles.plot_characteristics_poins);
    guidata(hObject,handles);   
    
    update_contour_trajectory_plot(hObject, eventdata, handles);


% --- Executes on button press in btn_contour_rotation_build_all_characteristics_points.
function btn_contour_rotation_build_all_characteristics_points_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_rotation_build_all_characteristics_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~check_valid_data_for_contour_rotation(hObject, eventdata, handles)
    return;
end


handles.VesselStudio_data.slices_dataset(1).contour_data.characteristics_points_data=contour_characteristics_points_data(   handles.VesselStudio_data.slices_dataset(1).contour_data,...
                                                                                                                            handles.VesselStudio_data.contour_characteristics_points_parameters.count_of_characteristics_points,...
                                                                                                                            handles.VesselStudio_data.slices_dataset(1).contour_data.geometry_characteristics.angle);


%h = waitbar(0,'Ñompared characteristics points is calculating now. Please wait...');
steps=handles.VesselStudio_data.count_of_dicom_files-1;
for i=2:handles.VesselStudio_data.count_of_dicom_files
    
    angle=handles.VesselStudio_data.slices_dataset(i).contour_data.geometry_characteristics.angle-handles.VesselStudio_data.slices_dataset(i-1).contour_data.geometry_characteristics.angle;            
    
    handles.VesselStudio_data.slices_dataset(i).contour_data.characteristics_points_data=build_compared_characteristics_points(         handles.VesselStudio_data.slices_dataset(i).contour_data,...
                                                                                                                                        handles.VesselStudio_data.slices_dataset(i-1).contour_data,...
                                                                                                                                        handles.VesselStudio_data.contour_characteristics_points_parameters.count_of_characteristics_points,...
                                                                                                                                        handles.VesselStudio_data.contour_characteristics_points_parameters.epsilon_compared_characteristics_points,...
                                                                                                                                        angle);
    
                                                                                                                                    
                                                                                                                                    
    sb=statusbar(handles.frm_main,'Processing %d of %d (%.1f%%)...',i,steps,100*i/steps); 
    set(sb.ProgressBar,'Visible',1,'Value',100*i/steps);
        
    guidata(hObject,handles);                                                                                                        
    
    %waitbar(i / (handles.count_of_dicom_files-1));
end
%close(h);
    set(sb.ProgressBar,'Visible',0);
    statusbar(handles.frm_main,'Ready');
    
update_contour_rotation_plot(hObject, eventdata, handles);
update_contour_trajectory_plot(hObject, eventdata, handles);



function result=check_valid_data_for_contour_rotation(hObject, eventdata, handles)
if isempty(handles.VesselStudio_data.slices_dataset)
    questdlg('No data to work with. Load DICOM files first', ...
        'Vessel Studio', ...
        'Ok','Ok');
    result=0;
    return;
end

% check that for all images exists contour

count_of_dicom_files=size(handles.VesselStudio_data.slices_dataset,2);

number_of_images_without_contour=[];
for i=1:count_of_dicom_files
    if isempty(handles.VesselStudio_data.slices_dataset(i).contour_data.coordinates)
        number_of_images_without_contour=strcat(number_of_images_without_contour,',',num2str(i));
    end;
end;
if ~isempty(number_of_images_without_contour)
        questdlg(strcat('You need to build countours for images: ',number_of_images_without_contour(2:size(number_of_images_without_contour,2))), ...
        'Vessel Studio', ...
        'Ok','Ok');
    result=0;
    return;
end
result=1;
%==================================================================================================================================
%==================================================================================================================================
%=============Contour trajectory===================================================================================================
%==================================================================================================================================
%==================================================================================================================================

%Choose dicom file
% --- Executes during object creation, after setting all properties.
function cmb_current_dicom_file_contour_trajectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmb_current_dicom_file_contour_trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in cmb_current_dicom_file_contour_trajectory.
function cmb_current_dicom_file_contour_trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to cmb_current_dicom_file_contour_trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmb_current_dicom_file_contour_trajectory contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmb_current_dicom_file_contour_trajectory
set(handles.cmb_current_dicom_file,'Value',get(hObject,'Value'));
cmb_current_dicom_file_Callback(hObject, eventdata, handles);


% --- Executes on button press in btn_contour_trajectory_previous.
function btn_contour_trajectory_previous_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_trajectory_previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btn_contour_recognition_previous_Callback(hObject, eventdata, handles);

% --- Executes on button press in btn_contour_trajectory_next.
function btn_contour_trajectory_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_trajectory_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
btn_contour_recognition_next_Callback(hObject, eventdata, handles);

%----------------------------------------------------------------------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function txt_contour_trajectory_count_of_contour_points_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_contour_trajectory_count_of_contour_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function txt_contour_trajectory_count_of_contour_points_Callback(hObject, eventdata, handles)
% hObject    handle to txt_contour_trajectory_count_of_contour_points (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_contour_trajectory_count_of_contour_points as text
%        str2double(get(hObject,'String')) returns contents of txt_contour_trajectory_count_of_contour_points as a double
count_of_points=str2num( get(hObject,'String'));
if isempty(count_of_points)
    questdlg('Problem with entered data: Count of points of contour','Vessel Studio','Ok','Ok');
    set(handles.txt_contour_trajectory_count_of_contour_points,'String',num2str(handles.VesselStudio_data.contour_recognition_parameters.count_of_envelope_points-1));
    return;
end

if (count_of_points<3)
    questdlg('Count of points of contour can not be less 3', ...
    'Contour Builder', ...
    'Ok','Ok');
    set(handles.txt_contour_trajectory_count_of_contour_points,'String',num2str(handles.VesselStudio_data.contour_recognition_parameters.count_of_envelope_points-1));
end;



% --- Executes on button press in btn_contour_trajectory_build_contour.
function btn_contour_trajectory_build_contour_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_trajectory_build_contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count_of_points=str2num( get(handles.txt_contour_trajectory_count_of_contour_points,'String'));


if isempty(handles.VesselStudio_data.slices_dataset)
    return;
end;

slices_dataset=handles.VesselStudio_data.slices_dataset;

current_dicom_file=handles.VesselStudio_data.current_dicom_file;


if isempty(slices_dataset(current_dicom_file).contour_data.coordinates)
    questdlg('No base contour for building for current dicom file. Use contour selection tool to build it at first','Vessel Studio','Ok','Ok');    
    return;
end;

[contour,area_str,perimeter_str,angle_str,centroid_str]=slices_dataset_contour_data_extraction_labels(slices_dataset,current_dicom_file);
handles.VesselStudio_data.contour_of_interest=curve_to_equals_lines(contour,count_of_points+1);


update_plots(hObject, eventdata, handles);
guidata(hObject, handles);

%Set point coordinates
%----------------------------------------------------------------------------------------------------------------------------------


% --- Executes during object creation, after setting all properties.
function txt_contour_trajectory_point_coordinates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_contour_trajectory_point_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function txt_contour_trajectory_point_coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to txt_contour_trajectory_point_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of txt_contour_trajectory_point_coordinates as text
%        str2double(get(hObject,'String')) returns contents of txt_contour_trajectory_point_coordinates as a double


% --- Executes during object creation, after setting all properties.
function slider_contour_trajectory_point_coordinates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_contour_trajectory_point_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider_contour_trajectory_point_coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to slider_contour_trajectory_point_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
current_point = round(get(hObject, 'Value')); % correct, 1 at start
axes(handles.plot_point_of_interest);
if ~isempty(handles.VesselStudio_data.ploted_point_of_interest)
    delete(handles.VesselStudio_data.ploted_point_of_interest);

end

if ~isempty(handles.VesselStudio_data.plot_user_point_of_interest)
    delete(handles.VesselStudio_data.plot_user_point_of_interest);

end

if ~isempty(handles.VesselStudio_data.plot_calculated_point_of_interest)
    delete(handles.VesselStudio_data.plot_calculated_point_of_interest);

end


hold on;
handles.VesselStudio_data.ploted_point_of_interest=plot(handles.VesselStudio_data.contour_of_interest(current_point,1),handles.VesselStudio_data.contour_of_interest(current_point,2),'b*');
set(handles.txt_contour_trajectory_point_coordinates,'String',num2str(handles.VesselStudio_data.contour_of_interest(current_point,:)));
legend('contour points','current point');
guidata(hObject,handles);



function txt_contour_trajectory_point_coordinates_error_Callback(hObject, eventdata, handles)
% hObject    handle to txt_contour_trajectory_point_coordinates_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_contour_trajectory_point_coordinates_error as text
%        str2double(get(hObject,'String')) returns contents of txt_contour_trajectory_point_coordinates_error as a double


% --- Executes during object creation, after setting all properties.
function txt_contour_trajectory_point_coordinates_error_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_contour_trajectory_point_coordinates_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%Build point trajectory
%----------------------------------------------------------------------------------------------------------------------------------


% --- Executes on button press in chb_contour_trajectory_interpolate_point_trajectory.
function chb_contour_trajectory_interpolate_point_trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to chb_contour_trajectory_interpolate_point_trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chb_contour_trajectory_interpolate_point_trajectory


% --- Executes on button press in chb_contour_trajectory_holdon_point_trajectory.
function chb_contour_trajectory_holdon_point_trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to chb_contour_trajectory_holdon_point_trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chb_contour_trajectory_holdon_point_trajectory



% --- Executes on button press in btn_contour_trajectory_parameters.
function btn_contour_trajectory_parameters_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_trajectory_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    prompt = {'Enter count of interpolation points in time:'};
        
    title = 'Contour motion parameters';
    
    default = {

        num2str(handles.VesselStudio_data.contour_trajectory_parameters.count_of_interpolation_points_time)};

    answer = inputdlg(prompt, title, 1, default);
    if isempty(answer)
        return;
    end;
try

        temp=str2num(answer{1});
        if isempty(temp)
            ME = MException('VesselStudio:inputError','Error. \nInput count of interpolation points in time must be a integer, not a string.');
            throw(ME);
        end;
        handles.VesselStudio_data.contour_trajectory_parameters.count_of_interpolation_points_time=temp;
        

        guidata(hObject,handles);
    
catch ME
    questdlg(ME.message, ...
        'Vessel Studio', ...
        'Ok','Ok');
    btn_contour_trajectory_parameters_Callback(hObject, eventdata, handles);
    return;
end


% --- Executes on button press in btn_contour_trajectory_build_point_trajectory.
function btn_contour_trajectory_build_point_trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_trajectory_build_point_trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~check_valid_data_for_contour_trajectory(hObject, eventdata, handles)
    return;
end

    slices_dataset=handles.VesselStudio_data.slices_dataset;

    current_dicom_file=handles.VesselStudio_data.current_dicom_file;


    if isempty(slices_dataset(current_dicom_file).contour_data.coordinates)
        questdlg('No base contour for building for current dicom file. Use contour selection tool to build it at first','Vessel Studio','Ok','Ok');    
        return;
    end;

    contour_of_interest=slices_dataset(current_dicom_file).contour_data.characteristics_points_data.coordinates;


    point = str2num(get(handles.txt_contour_trajectory_point_coordinates,'String'));
    error =str2num(get(handles.txt_contour_trajectory_point_coordinates_error,'String'));

    
    if isempty(point) || isempty(error)
            questdlg('Data error with point of interest. Check error value and point coordinates','Vessel Studio','Ok','Ok');    
        return;
    end
    if ~isequal(size(point),[1 2])
            questdlg('Data error with point of interest. Coordinates shuld be vector of two values','Vessel Studio','Ok','Ok');    
        return;
    end



        axes(handles.plot_point_of_interest);
        
        if ~isempty(handles.VesselStudio_data.ploted_point_of_interest)
            delete(handles.VesselStudio_data.ploted_point_of_interest);

        end
        
        hold on; 
        if ~isempty(handles.VesselStudio_data.plot_user_point_of_interest)
            delete(handles.VesselStudio_data.plot_user_point_of_interest);
        end;    
        handles.VesselStudio_data.plot_user_point_of_interest=plot(point(1),point(2),'g*');


    handles.VesselStudio_data.trajectory_interested=[];
    current_iteration_error=1000;

    count_of_points=size(contour_of_interest,1);    
    
    for i=1:count_of_points-1
        
        current_error=distance_between_points(contour_of_interest(i,:),point);
        if current_error<current_iteration_error
            current_iteration_error=current_error;
            index=i;
        end;
    end;
   
    
    %error is OK point have been  found
    if current_iteration_error<error
       
        for i=1:handles.VesselStudio_data.count_of_dicom_files
            trajectory_interested(i,1)=slices_dataset(i).contour_data.time;
            trajectory_interested(i,2:3)=slices_dataset(i).contour_data.characteristics_points_data.coordinates(index,:);
        end
        
        
%         axes(handles.plot_contour_dynamics);
%         hold on;
%         plot3(trajectory_interested(:,2),trajectory_interested(:,3),trajectory_interested(:,1),'b');
        

        handles.VesselStudio_data.trajectory_interested=trajectory_interested;
        guidata(hObject, handles);
        return;
    end;
    
    
    if index==1
        if distance_between_points(contour_of_interest(index+1,:),point)<distance_between_points(contour_of_interest(count_of_points-1,:),point)
            first_index=index;
            second_index=index+1;
        else
            first_index=count_of_points-1;
            second_index=count_of_points;
        end
    else
        if distance_between_points(contour_of_interest(index+1,:),point)<distance_between_points(contour_of_interest(index-1,:),point)
            first_index=index;
            second_index=index+1;
        else
            first_index=index-1;
            second_index=index;
        end
    end;

   
    if first_index==1
        begin_index=count_of_points-1;
    else
        begin_index=first_index-1;        
    end

    if second_index==count_of_points
        end_index=2;
    else
        end_index=second_index+1;            
    end;

    aprove_max_count_of_iteration=false;
    
    while(true)
        max_count_of_iteration=1+round(distance_between_points(contour_of_interest(first_index,:),contour_of_interest(second_index,:))/error);
        count_of_point_for_interpolated_points=2*max_count_of_iteration-1;

        if (count_of_point_for_interpolated_points>1500)
        choice = questdlg(strcat('Would you like to continue with: ',num2str(count_of_point_for_interpolated_points),' - points with accuracy:',num2str(error)), ...
                'Vessel Studio', ...
                'Yes','No','New accuracy','Yes');
                % Handle response
                switch choice
                    case 'Yes'
                        aprove_max_count_of_iteration=true;
                    case 'No'
                        return;                
                    case 'New accuracy'
                            prompt = {'Enter new accuracy arror:'};

                            title = 'Point''s trajectory parameter';

                            default = {num2str(error)};

                            answer = inputdlg(prompt, title, 1, default);
                            if ~isempty(answer)
                             try

                                temp=str2num(answer{1});
                                if isempty(temp)
                                    ME = MException('Vessel Studio:inputError','Error. \nInput error must be a double, not a string.');
                                    throw(ME);
                                end;
                                error=temp;

                                catch ME
                                    questdlg(ME.message, ...
                                        'Vessel Studio', ...
                                        'Ok','Ok');

                                end                        
                            end
                end;

        else
           aprove_max_count_of_iteration=true; 
        end;        
        
        if aprove_max_count_of_iteration
            break;
        end;
    end;
    
    
    %max_count_of_iteration==1 error is OK choose only point between first_index or second_index
    
    if max_count_of_iteration==1
        
        if distance_between_points(contour_of_interest(first_index,:),point)<distance_between_points(contour_of_interest(second_index,:),point)
            index=first_index;
        else
            index=second_index;
        end
        
        
        for i=1: handles.VesselStudio_data.count_of_dicom_files
            trajectory_interested(i,1)=slices_dataset(i).contour_data.time;
            trajectory_interested(i,2:3)=slices_dataset(i).contour_data.characteristics_points_data.coordinates(index,:);
        end
        
        axes(handles.plot_contour_dynamics);
        hold on;
        plot3(trajectory_interested(:,2),trajectory_interested(:,3),trajectory_interested(:,1),'b');

         handles.VesselStudio_data.trajectory_interested=trajectory_interested;
        guidata(hObject, handles);
        return;

    end;
    
    interval=vertcat (contour_of_interest(first_index:second_index,:)); 
    
    count_of_point_for_interpolated_points=2*max_count_of_iteration-1;

    interval_interpolated=curve_to_equals_lines(interval,count_of_point_for_interpolated_points);
    
%     spline=splinefit(interval(:,1),interval(:,2),3,2);
%     interval_interpolated(:,1)=linspace(interval(2,1),interval(3,1),count_of_point_for_interpolated_points);
%     interval_interpolated(:,2)=ppval(spline,interval_interpolated(:,1));
    
    current_r=1000;
%     h = waitbar(0,'Calculating the nearest point on contour. Please wait...');
    
    
        
    for i=1:count_of_point_for_interpolated_points
        r=distance_between_points(interval_interpolated(i,:),point);
        if r<current_r
            current_r=r;
            index=i;
        end
%         waitbar(i / (count_of_point_for_interpolated_points-1));
        sb=statusbar(handles.frm_main,'Calculating the nearest point on contour.Processing %d of %d (%.1f%%)...',i,count_of_point_for_interpolated_points,100*i/count_of_point_for_interpolated_points); 
        set(sb.ProgressBar,'Visible',1,'Value',100*i/count_of_point_for_interpolated_points);
    end
%     close(h);
    set(sb.ProgressBar,'Visible',0);
    statusbar(handles.frm_main,'Ready');

    set(handles.txt_contour_trajectory_point_coordinates_error,'String',num2str(current_r));
    
    point=interval_interpolated(index,:);
    set(handles.txt_contour_trajectory_point_coordinates,'String',num2str(point));    
    
    axes(handles.plot_point_of_interest);
    hold on;    
    
        if ~isempty(handles.VesselStudio_data.plot_calculated_point_of_interest)
            delete(handles.VesselStudio_data.plot_calculated_point_of_interest);
        end;
    handles.VesselStudio_data.plot_calculated_point_of_interest=plot(point(1),point(2),'co');
    legend('contour points','user point','calculated point');

    % search point of interest within all contours
    for i=1:handles.VesselStudio_data.count_of_dicom_files
        trajectory_interested(i,1)=slices_dataset(i).contour_data.time;
        
        
        contour_of_interest=slices_dataset(i).contour_data.characteristics_points_data.coordinates;        
        interval=vertcat (contour_of_interest(first_index:second_index,:));                
%        interval=vertcat (contour_of_interest(begin_index,:),contour_of_interest(first_index:second_index,:),contour_of_interest(end_index,:));        
    
%         spline=splinefit(interval(:,1),interval(:,2),3,2);
%         interval_interpolated(:,1)=linspace(interval(2,1),interval(3,1),count_of_point_for_interpolated_points);
%         interval_interpolated(:,2)=ppval(spline,interval_interpolated(:,1));
        
        interval_interpolated=curve_to_equals_lines(interval,count_of_point_for_interpolated_points);        
        
        trajectory_interested(i,2:3)=interval_interpolated(index,:);
        
        
    end
    
    color='b';
    axes(handles.plot_contour_dynamics);
    if get(handles.chb_contour_trajectory_holdon_point_trajectory,'Value')
        hold on;
    else
        cla(handles.plot_contour_dynamics);
    end;
    
    if get(handles.chb_contour_trajectory_interpolate_point_trajectory,'Value')
        trajectory_interested = spline_interpolation3D(trajectory_interested, handles.VesselStudio_data.contour_trajectory_parameters.count_of_interpolation_points_time);
        color='r';
    end;
    
    plot3(trajectory_interested(:,2),trajectory_interested(:,3),trajectory_interested(:,1),color);
    handles.VesselStudio_data.trajectory_interested=trajectory_interested;
    guidata(hObject, handles);

% --- Executes on button press in btn_contour_trajectory_build_all_trajectories.
function btn_contour_trajectory_build_all_trajectories_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_trajectory_build_all_trajectories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~check_valid_data_for_contour_trajectory(hObject, eventdata, handles)
    return;
end

if ~isempty(handles.VesselStudio_data.plot_user_point_of_interest)
    delete(handles.VesselStudio_data.plot_user_point_of_interest);

end

if ~isempty(handles.VesselStudio_data.plot_calculated_point_of_interest)
    delete(handles.VesselStudio_data.plot_calculated_point_of_interest);

end


handles.VesselStudio_data.contour_trajectory_parameters.slice_dataset=handles.VesselStudio_data.slices_dataset;

                                
statusbar(handles.frm_main,'Busy...');
handles.VesselStudio_data.interpolation_contour_dataset=trajectories_interpolation(handles.VesselStudio_data.contour_trajectory_parameters);
guidata(hObject,handles);
statusbar(handles.frm_main,'Ready');


% --- Executes on button press in btn_contour_trajectory_plot_trajectories.
function btn_contour_trajectory_plot_trajectories_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_trajectory_plot_trajectories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.plot_contour_dynamics);

if ~check_valid_data_for_contour_trajectory(hObject, eventdata, handles)
    return;
end;

if ~isempty(handles.VesselStudio_data.plot_user_point_of_interest)
    delete(handles.VesselStudio_data.plot_user_point_of_interest);

end

if ~isempty(handles.VesselStudio_data.plot_calculated_point_of_interest)
    delete(handles.VesselStudio_data.plot_calculated_point_of_interest);

end

if isempty(handles.VesselStudio_data.contour_dataset_with_characteristics_points)
    for i=1:size(handles.VesselStudio_data.slices_dataset,2)
        contour_dataset_with_characteristics_points(i)=handles.VesselStudio_data.slices_dataset(i).contour_data;
    end
    handles.VesselStudio_data.contour_dataset_with_characteristics_points=contour_dataset_with_characteristics_points;    
    guidata(hObject,handles);
end;


plot_trajectories_of_contours (handles.VesselStudio_data.contour_dataset_with_characteristics_points,'Original',handles.plot_contour_dynamics);


% --- Executes on button press in btn_contour_trajectory_plot_interpolated_trajectories.
function btn_contour_trajectory_plot_interpolated_trajectories_Callback(hObject, eventdata, handles)
% hObject    handle to btn_contour_trajectory_plot_interpolated_trajectories (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(handles.VesselStudio_data.plot_user_point_of_interest)
    delete(handles.VesselStudio_data.plot_user_point_of_interest);

end

if ~isempty(handles.VesselStudio_data.plot_calculated_point_of_interest)
    delete(handles.VesselStudio_data.plot_calculated_point_of_interest);

end

cla(handles.plot_contour_dynamics);
x=handles.VesselStudio_data.interpolation_contour_dataset;

plot_trajectories_of_contours (handles.VesselStudio_data.interpolation_contour_dataset,'Interpolated in time',handles.plot_contour_dynamics);



function result=check_valid_data_for_contour_trajectory(hObject, eventdata, handles)


if ~check_valid_data_for_contour_rotation(hObject, eventdata, handles)
    result=0;
    return;
end;

count_of_dicom_files=size(handles.VesselStudio_data.slices_dataset,2);


number_of_images_without_characteristics_points=[];
for i=1:count_of_dicom_files
    if isempty(handles.VesselStudio_data.slices_dataset(i).contour_data.characteristics_points_data)
        number_of_images_without_characteristics_points=strcat(number_of_images_without_characteristics_points,',',num2str(i));
    end;
end;
if ~isempty(number_of_images_without_characteristics_points)
        questdlg(strcat('You need to build similar characteristics points for images: ',number_of_images_without_characteristics_points(2:size(number_of_images_without_characteristics_points,2))), ...
        'Vessel Studio', ...
        'Ok','Ok');
    result=0;
    return;
end
result=1;
