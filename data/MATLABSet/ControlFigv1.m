function varargout = ControlFigv1(varargin)
% CONTROLFIGV1 MATLAB code for ControlFigv1.fig
%      CONTROLFIGV1, by itself, creates a new CONTROLFIGV1 or raises the existing
%      singleton*.
%
%      H = CONTROLFIGV1 returns the handle to a new CONTROLFIGV1 or the handle to
%      the existing singleton*.
%
%      CONTROLFIGV1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROLFIGV1.M with the given input arguments.
%
%      CONTROLFIGV1('Property','Value',...) creates a new CONTROLFIGV1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ControlFigv1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ControlFigv1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ControlFigv1

% Last Modified by GUIDE v2.5 03-Dec-2015 14:48:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ControlFigv1_OpeningFcn, ...
                   'gui_OutputFcn',  @ControlFigv1_OutputFcn, ...
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


% --- Executes just before ControlFigv1 is made visible.
function ControlFigv1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ControlFigv1 (see VARARGIN)

% Choose default command line output for ControlFigv1



handles.output = hObject;

handles.positionTrack = cell2mat(varargin(1));
handles.gpsEast = cell2mat(varargin(2));
handles.gpsNorth = cell2mat(varargin(3));


plot(handles.gpsPlot,handles.gpsEast,handles.gpsNorth,'.');
set(handles.gpsPlot,'YTick',[]);
set(handles.gpsPlot,'XTick',[]);

plot(handles.imuPlot,handles.positionTrack(:,1),handles.positionTrack(:,2),'.');
set(handles.imuPlot,'YTick',[]);
set(handles.imuPlot,'XTick',[]);


n=1;
handles.segment(n).IMU = [0,0];
handles.segment(n).GPS = [0,0];
handles.segment(n).GPStemplate = [0,0];
handles.segment(n).IMUtemplate = [0,0];
handles.segment(n).GPSobtained = [0,0];
handles.segment(n).IMUobtained = [0,0];
guidata(hObject, handles);

uiTableUpdate(hObject,handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ControlFigv1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ControlFigv1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in addButton.
function addButton_Callback(hObject, eventdata, handles)
% hObject    handle to addButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.tableSelection = 1;

n=length(handles.segment)+1;
handles.segment(n).IMU = [0,0];
handles.segment(n).GPS = [0,0];
handles.segment(n).GPStemplate = [0,0];
handles.segment(n).IMUtemplate = [0,0];
handles.segment(n).GPSobtained = [0,0];
handles.segment(n).IMUobtained = [0,0];

guidata(hObject, handles);
uiTableUpdate(hObject,handles);

% --- Executes on button press in editButton.
function editButton_Callback(hObject, eventdata, handles)
% hObject    handle to editButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in deleteButton.
function deleteButton_Callback(hObject, eventdata, handles)
% hObject    handle to deleteButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(length(handles.segment)>1)
    handles.segment(handles.tableSelection) = [];    
end
guidata(hObject, handles);
uiTableUpdate(hObject,handles);


% --- Executes on button press in updateButton.
function updateButton_Callback(hObject, eventdata, handles)
% hObject    handle to updateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiTableUpdate(hObject,handles);


% --- Executes during object creation, after setting all properties.
function segmentTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to segmentTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function uiTableUpdate(hObject,handles)

for n=1:length(handles.segment)
   dataArray{1,n}=n;    
end

set(handles.segmentTable, 'data',dataArray');
guidata(hObject, handles);


% --- Executes when selected cell(s) is changed in segmentTable.
function segmentTable_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to segmentTable (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
if(length(eventdata.Indices~=0))
handles.tableSelection = eventdata.Indices(1);
else
handles.tableSelection = 1;    
end
uiTableUpdate(hObject,handles);


% --- Executes during object creation, after setting all properties.
function displayFig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function integratedPlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to integratedPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate integratedPlot


% --- Executes on mouse press over axes background.
function gpsPlot_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to gpsPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    plot(handles.mainPlot,handles.gpsEast,handles.gpsNorth,'.');


% --- Executes on mouse press over axes background.
function imuPlot_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to imuPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     plot(handles.mainPlot,handles.positionTrack(:,1),handles.positionTrack(:,2),'.');
