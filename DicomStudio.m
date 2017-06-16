%
function varargout = DicomStudio(varargin)
% DICOMSTUDIO MATLAB code for DicomStudio.fig
%      DICOMSTUDIO, by itself, creates a new DICOMSTUDIO or raises the existing
%      singleton*.
%
%      H = DICOMSTUDIO returns the handle to a new DICOMSTUDIO or the handle to
%      the existing singleton*.
%
%      DICOMSTUDIO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DICOMSTUDIO.M with the given input arguments.
%
%      DICOMSTUDIO('Property','Value',...) creates a new DICOMSTUDIO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DicomStudio_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DicomStudio_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DicomStudio

% Last Modified by GUIDE v2.5 16-Jun-2017 20:12:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DicomStudio_OpeningFcn, ...
                   'gui_OutputFcn',  @DicomStudio_OutputFcn, ...
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

%
% --- Executes just before DicomStudio is made visible.
function DicomStudio_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DicomStudio (see VARARGIN)

% Choose default command line output for DicomStudio
warning('off','all')

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DicomStudio wait for user response (see UIRESUME)
% uiwait(handles.frm_DicomStudio);
[hLeft,hMidle_,hDiv1]=uisplitpane(handles.panel_dicom_file_handling,'Orientation','horizontal','dividercolor',[105,105,105],'dividerwidth',3,'DividerLocation',0.2);     
% Left part
    set(handles.panel_files_browser,'Parent',hLeft);
    set(handles.panel_files_browser,'Position',[0,0,1,1]);
    [hUp,hDown,hDiv1]=uisplitpane(handles.panel_dicom_tree_split,'Orientation','vertical','dividercolor',[105,105,105],'dividerwidth',3,'DividerLocation',0.75);     
    
    set(handles.list_tags_filter,'Parent',hDown);    
    set(handles.list_tags_filter,'Position',[0,0,1,1]);

    
    set(handles.panel_files_tree,'Parent',hUp);    
    set(handles.panel_files_tree,'Position',[0,0,1,1]);

    
[hMidle,hRight,hDiv1]=uisplitpane(hMidle_,'Orientation','horizontal','dividercolor',[105,105,105],'dividerwidth',3,'DividerLocation',0.6);     
%Midle part
    set(handles.panle_plot_dicom_image,'Parent',hMidle);
    set(handles.panle_plot_dicom_image,'Position',[0,0,1,1]);
    handles.XLim=[0 270];
    handles.YLim=[0 270];
%Right part
    set(handles.panel_dicom_tags,'Parent',hRight);
    set(handles.panel_dicom_tags,'Position',[0,0,1,1]);
    set(allchild(handles.plot_dicom_image),'visible','off'); 
    set(handles.plot_dicom_image,'visible','off'); 


handles.current_folder = pwd;
handles.current_filename=[];
handles.main_tag='SeriesNumber'; %by default

handles.tags_custom = cellstr('');

import uiextras.jTree.*
handles.dicom_series_tree = Tree('Parent',handles.panel_files_tree);


handles.icon_pages = fullfile(matlabroot,'toolbox','matlab','icons','pagesicon.gif');
handles.icon_page = fullfile(matlabroot,'toolbox','matlab','icons','pageicon.gif');

handles.dicom_series_tree.Enable = true;
handles.dicom_series_tree.DndEnabled = false;
handles.dicom_series_tree.Editable = false;
handles.dicom_series_tree.RootVisible = false;
handles.dicom_series_tree_main_node = TreeNode('Name',handles.main_tag,'Parent',handles.dicom_series_tree.Root);
handles.current_dicom_file_index=[];
handles.dicom_files_list=[]; 
handles.main_tag_list=[];
handles.main_tag_list_filtered=[];

handles.dicom_series_tree.SelectionChangeFcn= @(src,evt)dicom_tree_node_selected_Callback(src,evt);


guidata(handles.frm_DicomStudio, handles);

%
% --- Outputs from this function are returned to the command line.
function varargout = DicomStudio_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%========================================================================================
%=Files list=============================================================================
%========================================================================================
%========================================================================================
%========================================================================================

function dicom_tree_node_selected_Callback(src,evt)

for idx = 1:numel(evt)
    if isfield(evt,'Nodes')
        % Get the source and destination
        current_dicom_file_index=evt.Nodes.UserData;   
        if isempty(current_dicom_file_index)
            %evt.Nodes.expand();
            return
        end;
        handles=guidata(src.Parent.Parent.Parent.Parent.Parent);
        handles.current_dicom_file_index=current_dicom_file_index;
        hObject=handles.frm_DicomStudio;
        guidata(hObject, handles);
        load_dicom_file_info(handles)
    end
end

%========================================================================================
function load_dicom_files( handles)
if isempty(handles.current_folder)
    return;
end;

hObject=handles.frm_DicomStudio;


handles.dicom_files_list=[];
handles.main_tag_list=[];
handles.current_dicom_file_index=[];
set(handles.cmb_tags_group_by,'String','no data');
set(handles.cmb_tags_group_by,'Value',1);
load_dicom_file_info( handles);
handles = guidata(handles.frm_DicomStudio);
guidata(hObject, handles);

file_list = dir(handles.current_folder);
count_of_files=length(file_list)-2; % skip . and .. folder

handles.dicom_files_list=[];
index=0;

tags=[];cmb_string =[];

for i=1:count_of_files 
    
    fullname=fullfile(handles.current_folder , file_list(i+2).name);
    
    sb=statusbar(gcf,'Files processing %d of %d (%.1f%%)...',i,count_of_files,100*i/count_of_files); 
    set(sb.ProgressBar,'Visible',1,'Value',100*i/count_of_files);
    
    try
       metadata = dicominfo(fullname);
    catch
       continue%apparently not a DICOM file;
    end
    index=index+1;
    image = dicomread(fullname);
    dicom_files_list(index)=struct('main_tag',[],'skipped',false,'node',[],'image',image,'dicom_info',metadata,'fullname',fullname,'filename',file_list(i+2).name);
        
    fields=char(fieldnames(metadata));
    cmb_string=union(cmb_string,cellstr(fields));
    
end

%filtering fileds
cmb_string_filtered=[]
for i=1:size(cmb_string,1)
    fields = char(cmb_string(i));
    
    for k=1:size(fields,1)
        [group, element]=dicomlookup(strtrim(fields(k,:)));    
        if ~isempty(group)&&~isempty(element)
            tags=char(tags,strtrim(fields(k,:)));
        end;
    end;

   cmb_string_filtered=union(cmb_string_filtered,cellstr(tags(2:size(tags,1),:)));
end;

    
cmb_string=char(sort(cmb_string_filtered));
        
set(handles.cmb_tags_group_by,'String',cmb_string);
value=find(strcmp(cellstr(cmb_string),strtrim(char(handles.main_tag))));
if isempty(value)
    value=1;
end;
set(handles.cmb_tags_group_by,'Value',value);

set(sb.ProgressBar,'Visible',0);
statusbar(gcf,'Ready')
if index
    handles.dicom_files_list=dicom_files_list;
end;



set(handles.btn_dicom_file_previous,'Enable','off')
set(handles.btn_dicom_file_next,'Enable','off')

if index
    
    set(handles.btn_dicom_file_previous,'Enable','on')
    set(handles.btn_dicom_file_next,'Enable','on')
    %handles.main_tag=get(handles.cmb_tags_group_by,'Value');
end;

handles.main_tag_list_filtered=[];
handles.image_height=[];
handles.image_width=[]; 
    
[width,height]=size(dicom_files_list(1).image);

handles.XLim=[0 width];
handles.YLim=[0 height];

dicom_files_grouping( handles);

handles = guidata(handles.frm_DicomStudio);

handles.main_tag_list_filtered=handles.main_tag_list;
set(handles.list_tags_filter,'String',handles.main_tag_list);
set(handles.list_tags_filter,'Value',1);
guidata(hObject, handles);

   
    

function create_tag_list(handles)

if isempty(handles.dicom_files_list)
    return
end;

main_tag_list=[];


%get all tags for grouping
is_empty_tag=false;

for dicom_file_index=1:size(handles.dicom_files_list,2)

    metadata=handles.dicom_files_list(dicom_file_index).dicom_info;
    
    if isFieldExists(metadata, handles.main_tag)
        
        tag_value=getfield(metadata, handles.main_tag);

        if ischar(tag_value)
            tag_value_str=tag_value;
        elseif isnumeric(tag_value)
            tag_value_str=num2str(tag_value);
        end
        
        
        main_tag_list=union(main_tag_list,cellstr(tag_value_str));
        
    else
        tag_value_str='tag_not_exists';
        is_empty_tag=true;
    end;

    handles.dicom_files_list(dicom_file_index).main_tag=tag_value_str;

end;

if isnumeric(tag_value)
    array=str2num(char(main_tag_list));
    [values,indexes]=sort(array);
    main_tag_list=main_tag_list(indexes);
else
    main_tag_list=sort(main_tag_list);   
end;

if is_empty_tag
    main_tag_list=union(main_tag_list,cellstr('tag_not_exists'));
end;

handles.main_tag_list=main_tag_list;
guidata(handles.frm_DicomStudio, handles);



function dicom_files_grouping( handles)

hObject=handles.frm_DicomStudio;
import uiextras.jTree.*
delete(handles.dicom_series_tree_main_node); %clear all previous nodes

if isempty(handles.dicom_files_list)
    questdlg('No one dicom file found.', ...
        'Dicom Studio', ...
        'Ok','Ok'); 
    return
end;

create_tag_list(handles);
handles = guidata(handles.frm_DicomStudio);


if isempty(handles.main_tag_list_filtered) %first load
    handles.main_tag_list_filtered=handles.main_tag_list;
end
main_tag_list_filtered=handles.main_tag_list_filtered;


handles.dicom_series_tree_main_node = TreeNode('Name',strcat(handles.main_tag,'. Total files:',num2str(size(handles.dicom_files_list,2))),'Parent',handles.dicom_series_tree.Root);
for j=1:size(main_tag_list_filtered,2)
    dicom_series_tree_nodes_group(j)=TreeNode('Name',strcat(handles.main_tag,'=',char(main_tag_list_filtered(j))),'Parent',handles.dicom_series_tree_main_node,'UserData',[]);
    setIcon(dicom_series_tree_nodes_group(j),handles.icon_pages);
end;
count_of_group=size(handles.dicom_files_list,2);

for dicom_file_index=1:size(handles.dicom_files_list,2)

    sb=statusbar(gcf,'Dicom files grouping %d of %d (%.1f%%)...',dicom_file_index,count_of_group,100*dicom_file_index/count_of_group); 
    set(sb.ProgressBar,'Visible',1,'Value',100*dicom_file_index/count_of_group);
    
    dicom_file=handles.dicom_files_list(dicom_file_index);
    main_tag=dicom_file.main_tag;

    index=find(strcmp(main_tag_list_filtered,main_tag));
    
    if ~(dicom_file.skipped)
        name=dicom_file.filename;
    else           
        name=strcat(dicom_file.filename,'-skipped');
    end;
    
    current_node=TreeNode('Name',name,'Parent',dicom_series_tree_nodes_group(index),'UserData',dicom_file_index);
    handles.dicom_files_list(dicom_file_index).node=current_node;
    setIcon(current_node,handles.icon_page);
end;
handles.dicom_series_tree_main_node.expand();
set(handles.btn_dicom_file_previous,'Enable','on')
set(handles.btn_dicom_file_next,'Enable','on')
guidata(hObject, handles);
set(sb.ProgressBar,'Visible',0);
statusbar(gcf,'Ready');

%========================================================================================
function load_dicom_file_info( handles)

if isempty(handles.current_dicom_file_index)
    set(handles.list_tags,'String','');
    set(handles.list_tags_custom,'String',''); 

    cla(handles.plot_dicom_image);
    handles.plot_dicom_image.XLim=[0 1];
    handles.plot_dicom_image.YLim=[0 1];     
    guidata(handles.frm_DicomStudio, handles);
    return
end;

if handles.plot_dicom_image.XLim(2)~=1
    handles.XLim=handles.plot_dicom_image.XLim;
    handles.YLim=handles.plot_dicom_image.YLim;    
end;

current_dicom_file=handles.dicom_files_list(handles.current_dicom_file_index);

metadata=current_dicom_file.dicom_info;
image=current_dicom_file.image;

axes(handles.plot_dicom_image);
imshow(image,[]);

handles.plot_dicom_image.XLim=handles.XLim;
handles.plot_dicom_image.YLim=handles.YLim; 

%correction of view if size of image change
plot_fit(handles);
handles = guidata(handles.frm_DicomStudio);


set(handles.chk_skip_dicom_file,'Value',current_dicom_file.skipped);

if (get(handles.chk_skip_dicom_info,'Value'))
    guidata(handles.frm_DicomStudio, handles);
    return;
end;

ch = get(handles.list_tags, 'value');
fields=char(fieldnames(metadata));
id=0;
id_custom=0;
cstr_custom=[];
cstr=[];

count=size(fields,1);
for k=1:count

    [group, element]=dicomlookup(strtrim(fields(k,:)));
    estr=eval(['metadata.' fields(k,:)]);
    if ischar(estr)
        str=[fields(k,:) ' : ' estr];
        estr_string=estr;
    elseif isnumeric(estr)
        str=[fields(k,:) ' : ' num2str(estr(1:min(3,end))')];
        estr_string=num2str(estr(1:min(3,end))');
    else
        str=[fields(k,:) ' : ...'];
        estr_string='...';
    end

    group_element=sprintf('(%5d,%5d) %s',group,element);

    if ~ismember(cellstr(group_element),handles.tags_custom)
        id = id+1;
        cstr{id}=sprintf('(%5d,%5d) %s',group,element,str);
    else
        id_custom = id_custom+1;
        cstr_custom{id_custom}=sprintf('(%5d,%5d) %s',group,element,str);
    end;

    sb=statusbar(gcf,'Dicom info reading %d of %d (%.1f%%)...',k,count,100*k/count); 
    set(sb.ProgressBar,'Visible',1,'Value',100*k/count);
    
end

set(handles.list_tags,'Value',ch);
set(handles.list_tags,'String',cstr);


set(sb.ProgressBar,'Visible',0);
statusbar(gcf,'Ready');

if ~isempty(cstr_custom)
    set(handles.list_tags_custom,'Value',1);
end;
set(handles.list_tags_custom,'String',cstr_custom);        

guidata(handles.frm_DicomStudio, handles);
%

%========================================================================================
%=Current dicom file=====================================================================
%========================================================================================
%========================================================================================
%========================================================================================
%
% --- Executes on button press in btn_dicom_file_next.
function btn_dicom_file_next_Callback(hObject, eventdata, handles)
% hObject    handle to btn_dicom_file_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current_node=handles.dicom_series_tree.SelectedNodes;
if(isempty(current_node))
    return;
end;

if current_node==handles.dicom_series_tree_main_node
    current_node.expand();
    return;
end;

set(handles.btn_dicom_file_previous,'Enable','on')
current_node_childrens=current_node.Children;
current_node_parent=current_node.Parent;
current_node_brothers=current_node_parent.Children;

if isempty(current_node_childrens) % this node is dicom_file

    current_node_index=find(current_node_brothers==current_node);
    
    if current_node_index==size(current_node_brothers,2)
        %go to dicom group
        current_node_parent.collapse();
        handles.dicom_series_tree.SelectedNodes=current_node_parent;
        %go to previous group
        btn_dicom_file_next_Callback(hObject, eventdata, handles);
        return;
        
    else
        %select next brother
        handles.dicom_series_tree.SelectedNodes=current_node_brothers(current_node_index+1);
    end;

else
    %this node is dicom_file_group

    current_dicom_file_group_index=find(handles.dicom_series_tree_main_node.Children==current_node);
    if current_dicom_file_group_index==size(handles.dicom_series_tree_main_node.Children,2) % last group
        set(handles.btn_dicom_file_next,'Enable','off');
        current_node.expand();
        
        handles.dicom_series_tree.SelectedNodes=current_node.Children(size(current_node.Children,2));        
    else
        next_dicom_files_group=handles.dicom_series_tree_main_node.Children(current_dicom_file_group_index+1);
        next_dicom_files_group.expand();
        handles.dicom_series_tree.SelectedNodes=next_dicom_files_group.Children(1);
    end    
end;

evt.Nodes=handles.dicom_series_tree.SelectedNodes;
dicom_tree_node_selected_Callback(handles.dicom_series_tree,evt);

%
% --- Executes on button press in btn_dicom_file_previous.
function btn_dicom_file_previous_Callback(hObject, eventdata, handles)
% hObject    handle to btn_dicom_file_previous (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current_node=handles.dicom_series_tree.SelectedNodes;
if(isempty(current_node))
    return;
end;

if current_node==handles.dicom_series_tree_main_node
    current_node.expand();
    return;
end;
set(handles.btn_dicom_file_next,'Enable','on')
current_node_childrens=current_node.Children;
current_node_parent=current_node.Parent;
current_node_brothers=current_node_parent.Children;

if isempty(current_node_childrens) % this node is dicom_file

    current_node_index=find(current_node_brothers==current_node);
    
    if current_node_index==1
        %go to dicom group
        current_node_parent.collapse();
        handles.dicom_series_tree.SelectedNodes=current_node_parent;
        %go to previous group
        btn_dicom_file_previous_Callback(hObject, eventdata, handles);
        return;
        
    else
        %select next brother
        handles.dicom_series_tree.SelectedNodes=current_node_brothers(current_node_index-1);
    end;

else
    %this node is dicom_file_group

    current_dicom_file_group_index=find(handles.dicom_series_tree_main_node.Children==current_node);
    if current_dicom_file_group_index==1 % first group
        set(handles.btn_dicom_file_previous,'Enable','off');
        current_node.expand();
        handles.dicom_series_tree.SelectedNodes=current_node.Children(1);        
    else
        previous_dicom_files_group=handles.dicom_series_tree_main_node.Children(current_dicom_file_group_index-1);
        previous_dicom_files_group.expand();
        handles.dicom_series_tree.SelectedNodes=previous_dicom_files_group.Children(1);
    end    
end;

evt.Nodes=handles.dicom_series_tree.SelectedNodes;
dicom_tree_node_selected_Callback(handles.dicom_series_tree,evt);

%========================================================================================
%=Tags===================================================================================
%========================================================================================
%========================================================================================
%========================================================================================
%
% --- Executes during object creation, after setting all properties.
function txt_tags_search_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_tags_search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%========================================================================================
function txt_tags_search_Callback(hObject, eventdata, handles)
% hObject    handle to txt_tags_search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_tags_search as text
%        str2double(get(hObject,'String')) returns contents of txt_tags_search as a double
st = get (handles.list_tags, 'string');
st =lower(st);

keyword = get(hObject,'String');
keyword = lower(keyword);

val =[];
for k=1:length(st)
    tag=char(st{k});
    if strfind(tag,char(keyword))
        val = [val,k];
    end
    
end
set(handles.list_tags,'Value',val);

if isempty(val)
        questdlg('No data found.', ...
        'Dicom Studio', ...
        'Ok','Ok');
end


%========================================================================================
% --- Executes during object creation, after setting all properties.
function txt_tags_search_group_element_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_tags_search_group_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%========================================================================================
function txt_tags_search_group_element_Callback(hObject, eventdata, handles)
% hObject    handle to txt_tags_search_group_element (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_tags_search_group_element as text
%        str2double(get(hObject,'String')) returns contents of txt_tags_search_group_element as a double

try
    st = get (handles.list_tags, 'string');
    st =lower(st);

    keyword = lower(get(hObject,'String'));
    separator_postion=strfind(keyword,',');
    if ~isempty(separator_postion)
        if size(separator_postion,2)>1
            ME = MException('DicomStudio:inputError','Error. \nToo many , in text. Input group end element like integer,integer.');
            throw(ME);            
        end
    else
        ME = MException('DicomStudio:inputError','Error. \nInput group end element like integer,integer.');
        throw(ME);
    end;

    group=str2num(keyword(1:separator_postion));
    element=str2num(keyword(separator_postion+1:length(keyword)));
    keyword=sprintf('(%5d,%5d)',group,element);

    val =[];
    for k=1:length(st)
        tag=char(st{k});
        if strfind(tag,char(keyword))
            val = [val,k];
        end

    end
    set(handles.list_tags,'Value',val);

    if isempty(val)
            questdlg('No data found.', ...
            'Dicom Studio', ...
            'Ok','Ok');
    end

catch ME
    questdlg(ME.message, ...
        'Dicom studio', ...
        'Ok','Ok');

    return;
end

%========================================================================================
% --- Executes during object creation, after setting all properties.
function list_tags_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_tags (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%
% --- Executes on selection change in list_tags.
function list_tags_Callback(hObject, eventdata, handles)
% hObject    handle to list_tags (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_tags contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_tags

%
% --- Executes on button press in btn_tags_add_to_custom.
function btn_tags_add_to_custom_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tags_add_to_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st = get (handles.list_tags, 'string');
custom = get(handles.list_tags, 'value');

if length(custom)==length(st)
   questdlg ('WARNING: at least one field must be shown', ...
        'Dicom Studio', ...
        'Ok','Ok');
   return
end
tags_custom=[];
was_emty_id=false;
for id=custom
    tag=char(st{id});
    separator_postion=strfind(tag,') '); 
    if separator_postion(1)<10
        was_emty_id=true;
        continue;
    end;
    tags_custom = [tags_custom;tag(1:separator_postion+1)];
end
if isempty(tags_custom)
    tags_custom='';
end;

handles.tags_custom = union (handles.tags_custom, cellstr(tags_custom));

if was_emty_id
    questdlg ('WARNING: Tags with empty group and element not added', ...
        'Dicom Studio', ...
        'Ok','Ok');
end;

set(handles.list_tags,'Value',1);
guidata (hObject, handles);
load_dicom_file_info( handles);

%
% --- Executes on button press in btn_tags_remove_from_custom.
function btn_tags_remove_from_custom_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tags_remove_from_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st = get (handles.list_tags_custom, 'string');
if isempty(st)
    return;
end
custom = get(handles.list_tags_custom, 'value');


tags_custom=[];
for id=custom
    tag=char(st{id});
    separator_postion=strfind(tag,') '); 

    tags_custom = [tags_custom;tag(1:separator_postion+1)];
end
handles.tags_custom = setdiff (handles.tags_custom, cellstr(tags_custom));
set(handles.list_tags_custom,'Value',1);
guidata (hObject, handles);
load_dicom_file_info( handles);

%
% --- Executes on button press in btn_tags_clear_custom.
function btn_tags_clear_custom_Callback(hObject, eventdata, handles)
% hObject    handle to btn_tags_clear_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.tags_custom =cellstr('');
guidata (hObject, handles);
load_dicom_file_info( handles);

%
% --- Executes on selection change in list_tags_custom.
function list_tags_custom_Callback(hObject, eventdata, handles)
% hObject    handle to list_tags_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_tags_custom contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_tags_custom

%
% --- Executes during object creation, after setting all properties.
function list_tags_custom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_tags_custom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menu_open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menu_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
application_folder = fileparts(mfilename('fullpath'));
current_folder=uigetdir(application_folder,'Select DICOM Directory');
if ~ischar(current_folder)
    questdlg('No valid Directory selected.', ...
        'Dicom Studio', ...
        'Ok','Ok');
    return;
end
handles.current_folder=current_folder;
guidata(hObject, handles);
load_dicom_files( handles);


% --- Executes on selection change in cmb_tags_group_by.
function cmb_tags_group_by_Callback(hObject, eventdata, handles)
% hObject    handle to cmb_tags_group_by (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cmb_tags_group_by contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cmb_tags_group_by


% --- Executes during object creation, after setting all properties.
function cmb_tags_group_by_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmb_tags_group_by (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_group_by_tag.
function btn_group_by_tag_Callback(hObject, eventdata, handles)
% hObject    handle to btn_group_by_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index=get(handles.cmb_tags_group_by,'Value');
tags=get(handles.cmb_tags_group_by,'String');

if size(tags,1)==1
    handles.main_tag_list_filtered=tags;  
    guidata(hObject, handles);
    return
end;

handles.main_tag=tags(index,:);
handles.main_tag_list_filtered=[];
handles.XLim=[0 1];
handles.YLim=[0 1];
guidata(hObject, handles);

dicom_files_grouping( handles);

handles = guidata(handles.frm_DicomStudio);
handles.main_tag_list_filtered=handles.main_tag_list;

set(handles.list_tags_filter,'String',handles.main_tag_list);
set(handles.list_tags_filter,'Value',1);
guidata(hObject, handles);


% --- Executes on selection change in list_tags_filter.
function list_tags_filter_Callback(hObject, eventdata, handles)
% hObject    handle to list_tags_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_tags_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_tags_filter


% --- Executes during object creation, after setting all properties.
function list_tags_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_tags_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_filter.
function btn_filter_Callback(hObject, eventdata, handles)
% hObject    handle to btn_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
st = get (handles.list_tags_filter, 'string');
custom = get(handles.list_tags_filter, 'value');

if (length(custom)==0)
   questdlg ('WARNING: at least one field must be checked', ...
        'Dicom Studio', ...
        'Ok','Ok');
   return
end

tags_custom=[];

for id=custom
    tag=char(st{id});
    tags_custom = union(tags_custom,cellstr(tag));
end


handles.main_tag_list_filtered=tags_custom;
set(handles.list_tags_filter,'String',handles.main_tag_list_filtered);
set(handles.list_tags_filter,'Value',1);

guidata(hObject, handles);
dicom_files_grouping( handles);
handles = guidata(handles.frm_DicomStudio);
guidata(hObject, handles);


% --- Executes on button press in btn_filter_delete.
function btn_filter_delete_Callback(hObject, eventdata, handles)
% hObject    handle to btn_filter_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.main_tag_list_filtered=handles.main_tag_list;
set(handles.list_tags_filter,'String',handles.main_tag_list);
set(handles.list_tags_filter,'Value',1);


dicom_files_grouping( handles);
handles = guidata(handles.frm_DicomStudio);
guidata(hObject, handles);

function plot_fit( handles)

hObject=handles.frm_DicomStudio;

if isempty(handles.current_dicom_file_index)
    return
end;

[height,width]=size(handles.dicom_files_list(handles.current_dicom_file_index).image);

if isempty(handles.image_height)
    handles.image_height=height;
    handles.image_width=width;    
    handles.plot_dicom_image.XLim=[0 width];
    handles.plot_dicom_image.YLim=[0 height];
    guidata(hObject, handles);
    return;
end;

if (handles.image_height~=height)||(handles.image_width~=width)
    handles.image_height=height;
    handles.image_width=width;
    handles.plot_dicom_image.XLim=[0 width];
    handles.plot_dicom_image.YLim=[0 height];    
end;

guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_plot_fit_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menu_plot_fit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.current_dicom_file_index)
    return
end;



[height,width]=size(handles.dicom_files_list(handles.current_dicom_file_index).image);

handles.plot_dicom_image.XLim=[0 width];
handles.plot_dicom_image.YLim=[0 height];    

guidata(hObject, handles);


% --- Executes on button press in chk_skip_dicom_file.
function chk_skip_dicom_file_Callback(hObject, eventdata, handles)
% hObject    handle to chk_skip_dicom_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_skip_dicom_file
if isempty(handles.current_dicom_file_index)
    return
end;
node=handles.dicom_files_list(handles.current_dicom_file_index).node;
filename=handles.dicom_files_list(handles.current_dicom_file_index).filename;
if ~get(hObject,'Value')
    set(node,'Name',filename);
else           
    set(node,'Name',strcat(filename,'-skipped'));
end;
handles.dicom_files_list(handles.current_dicom_file_index).skipped=get(hObject,'Value');
guidata(hObject, handles);


% --- Executes on button press in chk_skip_dicom_info.
function chk_skip_dicom_info_Callback(hObject, eventdata, handles)
% hObject    handle to chk_skip_dicom_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chk_skip_dicom_info
if isempty(handles.current_dicom_file_index)
    return
end;

if ~(get(handles.chk_skip_dicom_info,'Value'))
    
    set(handles.btn_tags_add_to_custom,'Enable','on');
    set(handles.btn_tags_remove_from_custom,'Enable','on');
    set(handles.btn_tags_clear_custom,'Enable','on');    
    
    set(handles.txt_tags_search,'Enable','on');        
    set(handles.txt_tags_search_group_element,'Enable','on');            

    load_dicom_file_info( handles);
else

    set(handles.list_tags,'Value',1);
    set(handles.list_tags,'String','data skipped');
    set(handles.list_tags_custom,'Value',1);
    set(handles.list_tags_custom,'String','data skipped');

    set(handles.btn_tags_add_to_custom,'Enable','off');
    set(handles.btn_tags_remove_from_custom,'Enable','off');
    set(handles.btn_tags_clear_custom,'Enable','off');    
    
    set(handles.txt_tags_search,'Enable','off');        
    set(handles.txt_tags_search_group_element,'Enable','off');            
end;


% --------------------------------------------------------------------
function menu_save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to menu_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%dicom_files_list(index)=struct('main_tag',[],'skipped',false,'node',[],'image',image,'dicom_info',metadata,'fullname',fullname,'filename',file_list(i+2).name);

hObject=handles.frm_DicomStudio;
import uiextras.jTree.*

if isempty(handles.dicom_files_list)
    questdlg('No one dicom file found.', ...
        'Dicom Studio', ...
        'Ok','Ok'); 
    return
end;

handles = guidata(handles.frm_DicomStudio);

result_pathfiles = uigetdir;% Result folder, must not equal to the "target_pathfiles"



for i=1:size(handles.dicom_series_tree_main_node.Children,2)

    sb=statusbar(gcf,'Dicom files saving %d of %d (%.1f%%)...',i,size(handles.dicom_series_tree_main_node.Children,2),100*i/size(handles.dicom_series_tree_main_node.Children,2)); 
    set(sb.ProgressBar,'Visible',1,'Value',100*i/size(handles.dicom_series_tree_main_node.Children,2));
    
    current_node=handles.dicom_series_tree_main_node.Children(i);
    
    data_folder_name=current_node.Name;

    node_result_pathfiles=strcat(result_pathfiles,'\',data_folder_name);
    mkdir(node_result_pathfiles);
    
    for j=1:size(current_node.Children,2)
    
        dicom_struct=handles.dicom_files_list(current_node.Children(j).UserData);
        
        if ~dicom_struct.skipped
            dicomwrite(dicom_struct.image, strcat(node_result_pathfiles,'\',dicom_struct.filename),dicom_struct.dicom_info,'CreateMode','Copy'); 
        end;
        
    end
    
end


set(sb.ProgressBar,'Visible',0);
statusbar(gcf,'Ready');