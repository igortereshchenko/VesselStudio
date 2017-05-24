function varargout = DICOMViewer(varargin)
% DICOMViewer M-file for DICOMViewer.fig
%      DICOMViewer, by itself, creates a new DICOMViewer or raises the existing
%      singleton*.
%
%      H = DICOMViewer returns the handle to a new DICOMViewer or the handle to
%      the existing singleton*.
%
%      DICOMViewer('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DICOMViewer.M with the given input arguments.
%
%      DICOMViewer('Property','Value',...) creates a new DICOMViewer or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DICOMViewer_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DICOMViewer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DICOMFILES

% Last Modified by GUIDE v2.5 04-Aug-2016 10:30:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DICOMViewer_OpeningFcn, ...
                   'gui_OutputFcn',  @DICOMViewer_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

% End initialization code - DO NOT EDIT


% --- Executes just before DICOMFiles is made visible.
function DICOMViewer_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for DICOMFiles
handles.output = hObject;
handles.hidden = [];
colormap gray(256)

% use push-button callback
if length(varargin) & ischar (varargin{1})
   [stat dfolder]=fileattrib(varargin{1}); %get full path.
    if stat==0
        handles.dfolder = pwd;
        warning('No such directory, use current directory instead.');
    else
        handles.dfolder = dfolder.Name;
    end
   load_listbox(handles.dfolder,handles);
   handles = guidata(hObject);
   listbox1_Callback(hObject, eventdata, handles);
else
   handles.dfolder = pwd;
   load_listbox(handles.dfolder,handles)
   handles = guidata(hObject);
   lst_files_Callback(hObject, eventdata, handles);
end
guidata(hObject, handles);


% UIWAIT makes DICOMFiles wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = DICOMViewer_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in newFolder.
function newFolder_Callback(hObject, eventdata, handles)

P = fileparts(mfilename('fullpath'));
nfolder=uigetdir(P,'Select DICOM Directory');
if ~ischar(nfolder)
    disp('no valid Directory selected.')
    return;
end
handles.dfolder=nfolder;
guidata(hObject, handles);
% SetFolder(handles);
load_listbox(nfolder,handles);
% ListBox_Callback(hObject, eventdata, handles)
listbox1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function lst_all_tags_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end

% --- Executes on button press in cmdHide.
function cmdHide_Callback(hObject, eventdata, handles)
st = get (handles.lst_all_tags, 'string');
hide = get(handles.lst_all_tags, 'value');
if length(hide)==length(st)
   disp ('WARNING: at least one field must be shown');
   return
end
hidev=[];
for id=hide
   hidev = [hidev str2num(st{id}(1:3))];
end
handles.hidden = union (handles.hidden, hidev);
set(handles.lst_all_tags,'Value',1);
guidata (hObject, handles);
 listbox1_Callback(hObject, eventdata, handles);

% --- Executes on button press in cmdShowAll.
function cmdShowAll_Callback(hObject, eventdata, handles)

handles.hidden = [];
guidata (hObject, handles);
 listbox1_Callback(hObject, eventdata, handles);


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g;
switch get(gcf,'selectiontype')
    case 'normal'
    set(gcf, 'WindowButtonMotionFcn',@AdjWL);
    g.initpnt=get(gca,'currentpoint');
    g.initClim = get(gca,'Clim'); 
end


function AdjWL(varargin)
 handles = guidata(varargin{1});
global g;
cp=get(gca,'currentpoint');
x=cp(1,1);
y=cp(1,2);
xinit = g.initpnt(1,1);
yinit = g.initpnt(1,2);
dx = x-xinit;
dy = y-yinit;
clim = g.initClim+g.initClim(2).*[dx dy]./128;
set(handles.axes1,'Clim',clim);

% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonUpFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'WindowButtonMotionFcn',[])


% --------------------------------------------------------------------
function clHSV_Callback(hObject, eventdata, handles)
% hObject    handle to clHSV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
colormap(hsv)

% --------------------------------------------------------------------
function clGray_Callback(hObject, eventdata, handles)
% hObject    handle to clGray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
colormap(gray)


% --------------------------------------------------------------------
function clHot_Callback(hObject, eventdata, handles)
% hObject    handle to clHot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
colormap(hot)


% --------------------------------------------------------------------
function clJet_Callback(hObject, eventdata, handles)
% hObject    handle to clJet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
colormap(jet)


% --------------------------------------------------------------------
function clmap_Callback(hObject, eventdata, handles)
% hObject    handle to clmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ------------------------------------------------------------
% Callback for list box - open .fig with guide, otherwise use open
% ------------------------------------------------------------
function lst_files_Callback(hObject, eventdata, handles)
% hObject    handle to lst_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lst_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lst_files
global g;
get(handles.figure1,'SelectionType');
if strcmp(get(handles.figure1,'SelectionType'),'normal')
    index_selected = get(handles.lst_files,'Value');
    file_list = get(handles.lst_files,'String');
    filename = file_list{index_selected};
    if  handles.is_dir(handles.sorted_index(index_selected))
        
        if strcmp(filename,'..')
            handles.dfolder = fileparts(handles.dfolder);
%         cd (filename)
            load_listbox(handles.dfolder,handles)
        elseif strcmp(filename,'.')
        else
            handles.dfolder = fullfile(handles.dfolder,filename);
%         cd (filename)
            load_listbox(handles.dfolder,handles)
        end
    else

        fname = strtrim(filename);
        fullname = fullfile(handles.dfolder , fname);
        try
           metadata = dicominfo(fullname);
        catch
           disp ('apparently not a DICOM file');
           return
        end
        img      = dicomread(fullname);
       g.img=img;
        clim =get(gca,'Clim');
        clbarstat = get(handles.uitoggletool3,'State');
        
        himg=imagesc(img);
        set(himg,'ButtonDownFcn',@axes1_ButtonDownFcn);
        set(himg,'UIContextMenu',handles.clmap);
        if clim~=[0 1]
            set(gca,'Clim', clim); 
        end
        axis off
        if strcmp(clbarstat,'on')
            colorbar
        end

        ch = get(handles.lst_all_tags, 'value');
        fields=char(fieldnames(metadata));
        len = setdiff (1:size(fields,1), handles.hidden);
        id=0;
        for k=len,
            estr=eval(['metadata.' fields(k,:)]);
            if ischar(estr)
                str=[fields(k,:) ' : ' estr];
            elseif isnumeric(estr)
                str=[fields(k,:) ' : ' num2str(estr(1:min(3,end))')];
            else
                str=[fields(k,:) ' : ...'];
            end
            id = id+1;
            cstr{id}=sprintf('%3d %s',k,str);
        end
        set(handles.lst_all_tags,'Value',ch);
        set(handles.lst_all_tags,'String',cstr);
        guidata(hObject, handles);
        return;

     end
end
% ------------------------------------------------------------
% Read the current directory and sort the names
% ------------------------------------------------------------
function load_listbox(dir_path,handles)
% cd (dir_path)
dir_struct = dir(dir_path);
[sorted_names,sorted_index] = sortrows({dir_struct.name}');
handles.file_names = sorted_names;
handles.is_dir = [dir_struct.isdir];
handles.sorted_index = sorted_index;
guidata(handles.figure1,handles)
set(handles.lst_files,'String',handles.file_names,...
	'Value',1)
set(handles.NofFiles,'String',handles.dfolder)


% --- Executes during object creation, after setting all properties.
function lst_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lst_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: lst_files controls usually have a white background, change
%       'usewhitebg' to 0 to use default.  See ISPC and COMPUTER.
usewhitebg = 1;
if usewhitebg
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in lst_all_tags.
function lst_all_tags_Callback(hObject, eventdata, handles)
% hObject    handle to lst_all_tags (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lst_all_tags contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lst_all_tags



function txt_search_tag_Callback(hObject, eventdata, handles)
% hObject    handle to txt_search_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_search_tag as text
%        str2double(get(hObject,'String')) returns contents of txt_search_tag as a double


st = get (handles.lst_all_tags, 'string');
st =lower(st);

keyword = get(hObject,'String');
keyword = lower(keyword);

val =[];
for k=1:length(st)
    if strfind(st{k},keyword)
        val = [val,k];
    end
    
end
set(handles.lst_all_tags,'Value',val);
set(handles.textSearchResult,'String',[num2str(length(val)) ' match(es) found.' ]);


% --- Executes during object creation, after setting all properties.
function txt_search_tag_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_search_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function roi_line_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to roi_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global g
if ~isfield(g,'NumOfRoi')
    g.NumOfRoi =1;
else
    g.NumOfRoi = g.NumOfRoi+1;
end
h=imline;

g.roi(g.NumOfRoi) = h;
chld = get(h,'Children');
hcm=get(chld(1),'UIContextmenu');
item = uimenu(hcm, 'Label', 'X-Y Plot', 'Callback',@(varargin) roi_line_x_y_plot(h) );
item = uimenu(hcm, 'Label', 'Delete', 'Callback',@(varargin) roi_delete(h) );


function roi_line_x_y_plot (varargin)
global g
h=varargin{1};

mask=createMask(h);
figure;
plot(g.img(mask));


% --------------------------------------------------------------------
function roi_ellipse_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to roi_ellipse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=imellipse;
roi_init(h);




% --------------------------------------------------------------------
function roi_rect_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to roi_rect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=imrect;
roi_init(h);



% --------------------------------------------------------------------
function roi_poly_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to roi_poly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)doc

h=impoly;
roi_init(h)





% --------------------------------------------------------------------
function roi_freehand_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to roi_freehand (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=imfreehand;
roi_init(h);




function roi_init(h)
chld = get(h,'Children');
hcm=get(chld,'UIContextmenu');
hcm= unique(cell2mat(hcm));
for k=1:length(hcm)
   uimenu(hcm(k), 'Label', 'Histogram', 'Callback',@(varargin) roi_hist(h) );
   uimenu(hcm(k), 'Label', 'Delete', 'Callback',@(varargin) roi_delete(h) );
end
pos=getPosition(h);
ud.htext = text(pos(1),pos(2),'','Tag','roi_text');
draggable(ud.htext);

set(h,'Userdata',ud);

hpatch = findobj(h,'Tag','patch');
btnfcn = get(hpatch,'ButtonDownFcn');
set(hpatch, 'ButtonDownFcn',@(varargin) roi_btn_down_fcn(h,btnfcn));
roi_stat(h)
addNewPositionCallback(h,@(varargin) roi_new_pos(h));

function roi_new_pos(h)
roi_stat(h)


function roi_btn_down_fcn(h,fn)
ud=get(h,'UserData');
obj=findobj('Tag','roi_text');
set(obj,'EdgeColor','none');
set(ud.htext,'EdgeColor',[1,0,0],'LineWidth',3);
feval(fn)

function roi_hist(varargin)
global g;
h=varargin{1};
mask=createMask(h);
figure;
hist(double(g.img(mask)));


function roi_stat(h)
global g
mask = createMask(h);
v=g.img(mask);
v=double(v);
v_mean = mean(v);
v_std =std(v);
v_max = max(v);
v_min = min(v);


ud=get(h,'UserData');
set(ud.htext,...
             'String',sprintf('mean: %g, std: %g\nmin: %g, max:%g',v_mean,v_std,v_min,v_max),...
             'BackgroundColor',[.8 .8 .8] );


function roi_delete(h)
ud=get(h,'UserData');
delete(ud.htext);
delete(h)
