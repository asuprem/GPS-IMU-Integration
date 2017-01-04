function varargout = displayFig(varargin)
% DISPLAYFIG MATLAB code for displayFig.fig
%      DISPLAYFIG, by itself, creates a new DISPLAYFIG or raises the existing
%      singleton*.
%
%      H = DISPLAYFIG returns the handle to a new DISPLAYFIG or the handle to
%      the existing singleton*.
%
%      DISPLAYFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPLAYFIG.M with the given input arguments.
%
%      DISPLAYFIG('Property','Value',...) creates a new DISPLAYFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before displayFig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to displayFig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help displayFig

% Last Modified by GUIDE v2.5 05-Jan-2016 12:07:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @displayFig_OpeningFcn, ...
                   'gui_OutputFcn',  @displayFig_OutputFcn, ...
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
function figure1_CreateFcn(~, ~, ~)
function gpsPlot_CreateFcn(~, ~, ~)

%--------------------------------------------------------------------------
%LOADING FUNCTION: EXECUTES VARIABLE LOADS, CONFIGS, ETC
%--------------------------------------------------------------------------
% --- Executes just before displayFig is made visible.
function displayFig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to displayFig (see VARARGIN)

% Choose default command line output for displayFig



handles.output = hObject;
handles.globalPlot = 0;         %0: no plot; 1: GPS; 2: IMU; 3: GPS/IMU corrected 4: GPSIMU Integrated
handles.positionTrack = cell2mat(varargin(1));
handles.gpsEast = cell2mat(varargin(2));
handles.gpsNorth = cell2mat(varargin(3));
handles.tableSelection = 1;

plot(handles.gpsPlot,handles.gpsEast,handles.gpsNorth,'.');
set(handles.gpsPlot,'YTick',[]);
set(handles.gpsPlot,'XTick',[]);
grid minor;
plot(handles.imuPlot,handles.positionTrack(:,1),handles.positionTrack(:,2),'.');
set(handles.imuPlot,'YTick',[]);
set(handles.imuPlot,'XTick',[]);
grid minor;

    n=1;    
    handles.segment(n).IMU = [[],[]];
    handles.segment(n).GPS = [[],[]];
    handles.segment(n).GPStemplate = [[],[]];
    handles.segment(n).IMUtemplate = [[],[]];
    handles.segment(n).GPSobtained = [[],[]];
    handles.segment(n).IMUobtained = [[],[]];

    handles.segment(n).gpsObtainedFirst = [];
    handles.segment(n).gpsObtainedSecond = [];
    handles.segment(n).imuObtainedFirst = [];
    handles.segment(n).imuObtainedSecond = [];

    handles.segment(n).gpsTemplateFirst = [];
    handles.segment(n).gpsTemplateSecond = [];
    handles.segment(n).imuTemplateFirst = [];
    handles.segment(n).imuTemplateSecond = [];
    handles.segment(n).GPSobtainedSecondPoint = [];
guidata(hObject, handles);

uiTableUpdate(hObject,handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes displayFig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = displayFig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%--------------------------------------------------------------------------
%CREATION FUNCTIONS FOR OBJECTS
%--------------------------------------------------------------------------

% --- Executes during object creation, after setting all properties.
function segmentTable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to segmentTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

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








%--------------------------------------------------------------------------
%BUTTON FUNCTIONS FOR PANELS AT BOTTOM
%--------------------------------------------------------------------------

%                                  ADD
% --- Executes on button press in addButton.
function addButton_Callback(hObject, eventdata, handles)
% hObject    handle to addButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.tableSelection = 1;

n=length(handles.segment)+1;
handles.segment(n).IMU = [[],[]];
handles.segment(n).GPS = [[],[]];
handles.segment(n).GPStemplate = [[],[]];
handles.segment(n).IMUtemplate = [[],[]];
handles.segment(n).GPSobtained = [[],[]];
handles.segment(n).GPSobtainedSecondPoint = [];
handles.segment(n).IMUobtained = [[],[]];

handles.segment(n).gpsObtainedFirst = [];
handles.segment(n).gpsObtainedSecond = [];
handles.segment(n).imuObtainedFirst = [];
handles.segment(n).imuObtainedSecond = [];

handles.segment(n).gpsTemplateFirst = [];
handles.segment(n).gpsTemplateSecond = [];
handles.segment(n).imuTemplateFirst = [];
handles.segment(n).imuTemplateSecond = [];

handles.segment(n).integrated = [];

guidata(hObject, handles);
uiTableUpdate(hObject,handles);

%                                EDIT
% --- Executes on button press in editButton.
% Select the initial point of the segment for connection/relation.
function editButton_Callback(hObject, eventdata, handles)
% hObject    handle to editButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 
 if(handles.globalPlot == 0 || handles.gpsPlot==3 || handles.gpsPlot==4)
    handles.globalPlot = 1;
    plotUpdate(hObject,handles);
 end
 
 if(handles.globalPlot == 1)    %GPS
     uiwait(msgbox('In the Graph presented, select the EARLIEST data point for the current segment (GPS).','Data Fill In','modal'));
     axes(handles.mainPlot);
     [x,y]=myginput(1,'crosshair');
     [~,firstPoint]=min((handles.gpsEast-x).^2+(handles.gpsNorth-y).^2);
     hold on;
     plot(handles.mainPlot,handles.gpsEast(firstPoint),handles.gpsNorth(firstPoint),'r.');
     hold off;
          grid minor;
      uiwait(msgbox('In the Graph presented, select the LATEST data point for the current segment (GPS).','Data Fill In','modal'));
      axes(handles.mainPlot);
      [x,y]=myginput(1,'crosshair');
      [~,secondPoint]=min((handles.gpsEast-x).^2+(handles.gpsNorth-y).^2);
      hold on;
      plot(handles.mainPlot,handles.gpsEast(secondPoint),handles.gpsNorth(secondPoint),'r.');
      hold off;
      grid minor;
     handles.segment(handles.tableSelection).gpsObtainedFirst = firstPoint;
      handles.segment(handles.tableSelection).gpsObtainedSecond = secondPoint;
     
      handles.segment(handles.tableSelection).GPSobtained = [handles.gpsEast(firstPoint),handles.gpsNorth(firstPoint)]; %[handles.gpsEast(firstPoint:secondPoint),handles.gpsNorth(firstPoint:secondPoint)];
      handles.segment(handles.tableSelection).GPSobtainedSecondPoint = [handles.gpsEast(secondPoint),handles.gpsNorth(secondPoint)];
     guidata(hObject,handles);
     uiTableUpdate(hObject,handles);
     plotUpdate(hObject,handles);
     guidata(hObject,handles);


 elseif (handles.globalPlot == 2)   %IMU
     uiwait(msgbox('In the Graph presented, select the EARLIEST data point for the current segment (IMU).','Data Fill In','modal'));
     axes(handles.mainPlot);
     [x,y]=myginput(1,'crosshair');
     [~,firstPoint]=min((handles.positionTrack(:,1)-x).^2+(handles.positionTrack(:,2)-y).^2);
     hold on;
     plot(handles.mainPlot,handles.positionTrack(firstPoint,1),handles.positionTrack(firstPoint,2),'r.');
     hold off;
          grid minor;
     uiwait(msgbox('In the Graph presented, select the LATEST data point for the current segment (IMU).','Data Fill In','modal'));
     axes(handles.mainPlot);
     [x,y]=myginput(1,'crosshair');
     [~,secondPoint]=min((handles.positionTrack(:,1)-x).^2+(handles.positionTrack(:,2)-y).^2);
     hold on;
     plot(handles.mainPlot,handles.positionTrack(secondPoint,1),handles.positionTrack(secondPoint,2),'r.');
     hold off;
     grid minor;
     handles.segment(handles.tableSelection).imuObtainedFirst = firstPoint;
     handles.segment(handles.tableSelection).imuObtainedSecond = secondPoint;
     
     handles.segment(handles.tableSelection).IMUobtained = [handles.positionTrack(firstPoint:secondPoint,1),handles.positionTrack(firstPoint:secondPoint,2)];
     guidata(hObject,handles);
     uiTableUpdate(hObject,handles);
     plotUpdate(hObject,handles);
     guidata(hObject,handles);
 else
     
     
 end
guidata(hObject,handles);
 
%                         TEMPLATE
% --- Executes on button press in templateButton.
function templateButton_Callback(hObject, eventdata, handles)
% hObject    handle to templateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.globalPlot == 0 || handles.globalPlot==3 || handles.gpsPlot==4)
    handles.globalPlot = 1;
    plotUpdate(hObject,handles);
 end
 
 if(handles.globalPlot == 1)    %GPS
     uiwait(msgbox('In the Graph presented, select the EARLIEST data point for the current TEMPLATE (GPS).','Data Fill In','modal'));
     axes(handles.mainPlot);
     [x,y]=myginput(1,'crosshair');
     firstPoint = [x,y];                                                            %[~,firstPoint]=min((handles.gpsEast-x).^2+(handles.gpsNorth-y).^2);
     hold on;
     plot(handles.mainPlot,firstPoint(1),firstPoint(2),'r.');                                      %handles.mainPlot,handles.gpsEast(firstPoint),handles.gpsNorth(firstPoint),'r.');
     hold off;
          grid minor;
     uiwait(msgbox('In the Graph presented, select the LATEST data point for the current TEMPLATE (GPS).','Data Fill In','modal'));
     axes(handles.mainPlot);
     [x,y]=myginput(1,'crosshair');
     secondPoint = [x,y];                                                          %[~,secondPoint]=min((handles.gpsEast-x).^2+(handles.gpsNorth-y).^2);
     hold on;
     plot(handles.mainPlot,secondPoint(1),secondPoint(2),'r.');                                      %handles.mainPlot,handles.gpsEast(secondPoint),handles.gpsNorth(secondPoint),'r.');
     hold off;
     grid minor;
     % LINEPLOT
     xL = (secondPoint(1)-firstPoint(1))*(0:0.001:1)+firstPoint(1);
     yL = (secondPoint(2)-firstPoint(2))*(0:0.001:1)+firstPoint(2);
          
     
     axes(handles.mainPlot);
     hold on;
     plot(handles.mainPlot,xL,yL,'r-.');
     hold off;
     grid minor;
     
     handles.segment(handles.tableSelection).gpsTemplateFirst = firstPoint;
     handles.segment(handles.tableSelection).gpsTemplateSecond = secondPoint;
     
     handles.segment(handles.tableSelection).GPStemplate = [xL;yL];                 %[handles.gpsEast(firstPoint:secondPoint),handles.gpsNorth(firstPoint:secondPoint)];
     guidata(hObject,handles);
     uiTableUpdate(hObject,handles);
     plotUpdate(hObject,handles);
     guidata(hObject,handles);


 elseif (handles.globalPlot == 2)   %IMU
     uiwait(msgbox('In the Graph presented, select the EARLIEST data point for the current TEMPLATE (IMU).','Data Fill In','modal'));
     axes(handles.mainPlot);
     [x,y]=myginput(1,'crosshair');
     firstPoint = [x,y];                                                                    %[~,firstPoint]=min((handles.positionTrack(:,1)-x).^2+(handles.positionTrack(:,2)-y).^2);
     hold on;
     plot(handles.mainPlot,firstPoint(1),firstPoint(2),'r.');                                       %handles.positionTrack(firstPoint,1),handles.positionTrack(firstPoint,2),'r.');
     hold off;
          grid minor;
     uiwait(msgbox('In the Graph presented, select the LATEST data point for the current TEMPLATE (IMU).','Data Fill In','modal'));
     axes(handles.mainPlot);
     [x,y]=myginput(1,'crosshair');
     secondPoint = [x,y];                                                                   %[~,secondPoint]=min((handles.positionTrack(:,1)-x).^2+(handles.positionTrack(:,2)-y).^2);
     hold on;
     plot(handles.mainPlot,secondPoint(1),secondPoint(2),'r.')                                      %handles.positionTrack(secondPoint,1),handles.positionTrack(secondPoint,2),'r.');
     hold off;
     grid minor;
     
     % LINEPLOT
     xL = (secondPoint(1)-firstPoint(1))*(0:0.001:1)+firstPoint(1);
     yL = (secondPoint(2)-firstPoint(2))*(0:0.001:1)+firstPoint(2);
     
     
     axes(handles.mainPlot);
     hold on;
     plot(handles.mainPlot,xL,yL,'r-.');
     hold off;
     grid minor;
     
     handles.segment(handles.tableSelection).imuTemplateFirst = firstPoint;
     handles.segment(handles.tableSelection).imuTemplateSecond = secondPoint;
     
     handles.segment(handles.tableSelection).IMUtemplate = [xL;yL];                 %[handles.positionTrack(firstPoint:secondPoint,1),handles.positionTrack(firstPoint:secondPoint,2)];
     guidata(hObject,handles);
     uiTableUpdate(hObject,handles);
     plotUpdate(hObject,handles);
     guidata(hObject,handles);
 else
     
     
 end
guidata(hObject,handles);



 
%                              DELETE
% --- Executes on button press in deleteButton.
function deleteButton_Callback(hObject, eventdata, handles)
% hObject    handle to deleteButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(length(handles.segment)>1 && handles.tableSelection>1)
    handles.segment(handles.tableSelection) = [];
    handles.tableSelection = 1;
end
guidata(hObject, handles);
uiTableUpdate(hObject,handles);

%                                 UPDATE
% --- Executes on button press in updateButton.
function updateButton_Callback(hObject, eventdata, handles)
% hObject    handle to updateButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.integratedPlot);
cla;

for count=1:length(handles.segment)
   if ((logical(length(handles.segment(count).GPSobtained)-0))+...
        (logical(length(handles.segment(count).IMUobtained)-0))+...
        (logical(length(handles.segment(count).GPStemplate)-0))+...
        (logical(length(handles.segment(count).IMUtemplate)-0))==4)
        
    
    cleanTemplate = [(handles.segment(count).GPStemplate(1,:)-handles.segment(count).GPStemplate(1,1))' (handles.segment(count).GPStemplate(2,:)-handles.segment(count).GPStemplate(2,1))'];
    angleSet=-1*(atan2(cleanTemplate(:,2),cleanTemplate(:,1))-(pi/2));
    handles.GPSAngleSet(count) = mean(angleSet(2:length(angleSet)));
    
    if (handles.GPSAngleSet(count)==0 || handles.GPSAngleSet(count)==180)
        handles.GPSAngleSet(count)=handles.GPSAngleSet(count)+0.001;
    end
    if (handles.GPSAngleSet(count)==360)
        handles.GPSAngleSet(count) = handles.GPSAngleSet(count)-0.001;
    end
    
    cleanTemplate = [(handles.segment(count).IMUtemplate(1,:)-handles.segment(count).IMUtemplate(1,1))' (handles.segment(count).IMUtemplate(2,:)-handles.segment(count).IMUtemplate(2,1))'];
    angleSet=-1*(atan2(cleanTemplate(:,2),cleanTemplate(:,1))-(pi/2));
    handles.IMUAngleSet(count) = mean(angleSet(2:length(angleSet)));

    
   
   rotAngle = 0;
   % find AngleRotate
    
   if(handles.IMUAngleSet(count) > handles.GPSAngleSet(count))
       rotAngle = handles.IMUAngleSet(count)-handles.GPSAngleSet(count);
   elseif(handles.IMUAngleSet(count) < handles.GPSAngleSet(count))
       rotAngle = (2*pi)-handles.GPSAngleSet(count)+handles.IMUAngleSet(count);
   elseif(handles.IMUAngleSet(count) == handles.GPSAngleSet(count))
       rotAngle = 0; 
   end
           
   % Center, rotate, and move to GPS location
   rotatedIMU  = handles.segment(count).IMUobtained;
   rotatedIMUxCenter = rotatedIMU(1,1);
   rotatedIMUyCenter = rotatedIMU(1,2);
   
   center = [rotatedIMUxCenter*ones(length(rotatedIMU),1) rotatedIMUyCenter*ones(length(rotatedIMU),1)];

   RotMat = [cos(rotAngle) -sin(rotAngle); sin(rotAngle) cos(rotAngle)];
   rotatedIMU = rotatedIMU - center;
    for nCount=1:length(rotatedIMU)
   rotatedIMU(nCount,:) = (RotMat*rotatedIMU(nCount,:)')';
    end
   
    %Scale
    localLength = sqrt(abs(rotatedIMU(length(rotatedIMU),1)-rotatedIMU(1,1))^2+abs(rotatedIMU(length(rotatedIMU),2)-rotatedIMU(1,2))^2);
   globalLength = sqrt(abs(handles.segment(count).GPSobtained(1)-handles.segment(count).GPSobtainedSecondPoint(1))^2+abs(handles.segment(count).GPSobtained(2)-handles.segment(count).GPSobtainedSecondPoint(2))^2);
   handles.segment(count).globalScale = abs(globalLength/localLength);
   
   if(count>1)
       scaleMean = mean([handles.segment(1:count-1).globalScale]);
       if(handles.segment(count).globalScale/scaleMean > 1.2 || scaleMean/handles.segment(count).globalScale > 1.2)
            choice = questdlg(['Global Scale Error: ' num2str(scaleMean) ...
                ' (Mean)   ' num2str(handles.segment(count).globalScale) ...
                ' (Current) ' '\n Would you like to estimate?'], ...
                              'Global Scale Error', ...
                              'Keep Scale','Estimate Scale','Estimate Scale');
            % Handle response

            switch choice
                case 'Keep Scale'
                    continue;
                case 'Estimate Scale'
                handles.segment(count).globalScale = scaleMean;
            end
       end
   end
   
   rotatedIMU = rotatedIMU*handles.segment(count).globalScale;
    
   % Translate
   rotatedGPSxCenter = handles.segment(count).GPSobtained(1,1);
   rotatedGPSyCenter = handles.segment(count).GPSobtained(1,2);
   
	if(count>1)
        rotatedGPSxCenter = handles.segment(count-1).integrated(length(handles.segment(count-1).integrated),1);
        rotatedGPSyCenter = handles.segment(count-1).integrated(length(handles.segment(count-1).integrated),2);
	end
 
   rotatedIMU(:,1)  = rotatedIMU(:,1) + rotatedGPSxCenter;
   rotatedIMU(:,2)  = rotatedIMU(:,2) + rotatedGPSyCenter;
   
   
   handles.segment(count).integrated = rotatedIMU;
    
   end
    
   
end

handles.integratedNet = [[],[]];
    index=1;
    for count=1:length(handles.segment)
        if ((logical(length(handles.segment(count).integrated)-0)))
            handles.integratedNet(index:index+length(handles.segment(count).integrated)-1,:) = handles.segment(count).integrated;
            index = index+length(handles.segment(count).integrated);
        end
    end
    
   axes(handles.integratedPlot);

    plot(handles.integratedPlot, handles.integratedNet(:,1),handles.integratedNet(:,2),'.')

  axes(handles.gpsIMUIntegratedPlot);

    plot(handles.gpsIMUIntegratedPlot, handles.integratedNet(:,1),handles.integratedNet(:,2),'.')
    hold on;
    plot(handles.gpsIMUIntegratedPlot, handles.gpsEast, handles.gpsNorth,'.');
    hold off;
    grid minor;
%     
% axes(handles.gpsPlot);
% plot(handles.gpsPlot,handles.gpsEast,handles.gpsNorth,'.');
% set(handles.gpsPlot,'YTick',[]);
% set(handles.gpsPlot,'XTick',[]);
% 



uiTableUpdate(hObject,handles);
plotUpdate(hObject,handles);






%--------------------------------------------------------------------------
%INTERACTION FUNCTIONS 
%--------------------------------------------------------------------------


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
plotUpdate(hObject,handles);


% --- Executes on mouse press over axes background.
function gpsPlot_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to gpsPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.globalPlot = 1;
    plotUpdate(hObject,handles);
    guidata(hObject,handles);

% --- Executes on mouse press over axes background.
function imuPlot_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to imuPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.globalPlot = 2;
    plotUpdate(hObject,handles)
    guidata(hObject,handles);

    % --- Executes on mouse press over axes background.
function integratedPlot_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to integratedPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.globalPlot = 3;
    plotUpdate(hObject,handles)
    guidata(hObject,handles);
    
% --- Executes on mouse press over axes background.
function gpsIMUIntegratedPlot_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to gpsIMUIntegratedPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    handles.globalPlot = 4;
    plotUpdate(hObject,handles)
    guidata(hObject,handles);

%--------------------------------------------------------------------------
%CUSTOM FUNCTIONS FOR PANELS AT BOTTOM
%--------------------------------------------------------------------------
    
function uiTableUpdate(hObject,handles)
    for n=1:length(handles.segment)
       dataArray{1,n}=n;    
    end

    set(handles.segmentTable, 'data',dataArray');
    set(handles.segmentText,'String',num2str(handles.tableSelection));
    set(handles.gpsRangeText,'String' , num2str(logical(length(handles.segment(handles.tableSelection).GPSobtained)-0)));
    set(handles.imuRangeText,'String' , num2str(logical(length(handles.segment(handles.tableSelection).IMUobtained)-0)));
    set(handles.gpsTemplateText,'String' , num2str(logical(length(handles.segment(handles.tableSelection).GPStemplate)-0)));
    set(handles.imuTemplateText,'String' , num2str(logical(length(handles.segment(handles.tableSelection).IMUtemplate)-0)));
       
    guidata(hObject, handles);
    
    
function plotUpdate(hObject,handles)
axes(handles.mainPlot);
if(handles.globalPlot == 1) %GPS
    plot(handles.mainPlot,handles.gpsEast,handles.gpsNorth,'.')
    if(logical(length(handles.segment(handles.tableSelection).GPSobtained)))
        hold on;
        plot(handles.mainPlot,handles.segment(handles.tableSelection).GPSobtained(:,1),handles.segment(handles.tableSelection).GPSobtained(:,2),'g.');
        plot(handles.mainPlot,handles.segment(handles.tableSelection).GPSobtainedSecondPoint(:,1),handles.segment(handles.tableSelection).GPSobtainedSecondPoint(:,2),'g.');
        hold off
    end
    if(logical(length(handles.segment(handles.tableSelection).GPStemplate)))
        hold on;
        plot(handles.mainPlot,handles.segment(handles.tableSelection).GPStemplate(1,:)',handles.segment(handles.tableSelection).GPStemplate(2,:)','m-.');
        hold off
    end
    grid minor;
    
elseif (handles.globalPlot==2)  %IMU
    plot(handles.mainPlot,handles.positionTrack(:,1),handles.positionTrack(:,2),'.');
    hold on;
    if(logical(length(handles.segment(handles.tableSelection).IMUobtained)))
        hold on;
        plot(handles.mainPlot,handles.segment(handles.tableSelection).IMUobtained(:,1),handles.segment(handles.tableSelection).IMUobtained(:,2),'g.');
        hold off;
    end
    if(logical(length(handles.segment(handles.tableSelection).IMUtemplate)))
        hold on;
        plot(handles.mainPlot,handles.segment(handles.tableSelection).IMUtemplate(1,:)',handles.segment(handles.tableSelection).IMUtemplate(2,:)','m-.');
        hold off;
    end
    grid minor;
elseif (handles.globalPlot==3)  %IMU/GPS
    handles.integratedNet = [[],[]];
    index=1;
    for count=1:length(handles.segment)
        if ((logical(length(handles.segment(count).integrated)-0)))
            handles.integratedNet(index:index+length(handles.segment(count).integrated)-1,:) = handles.segment(count).integrated;
            index = index+length(handles.segment(count).integrated);
        end
    end
    
    plot(handles.mainPlot, handles.integratedNet(:,1),handles.integratedNet(:,2),'k.')
    grid minor;
elseif (handles.globalPlot==4)  %IMU/GPS
    handles.integratedNet = [[],[]];
    index=1;
    for count=1:length(handles.segment)
        if ((logical(length(handles.segment(count).integrated)-0)))
            handles.integratedNet(index:index+length(handles.segment(count).integrated)-1,:) = handles.segment(count).integrated;
            index = index+length(handles.segment(count).integrated);
        end
    end
    
    plot(handles.mainPlot, handles.integratedNet(:,1),handles.integratedNet(:,2),'k.')
    hold on;
    plot(handles.mainPlot, handles.gpsEast, handles.gpsNorth,'.');
    hold off;
    grid minor;
else
    
end

guidata(hObject,handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






handles.globalPlot = 4;
plotUpdate(hObject,handles);
    guidata(hObject,handles);

test =5;
test=6;
