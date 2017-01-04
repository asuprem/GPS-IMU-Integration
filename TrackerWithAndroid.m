%% GPSIMU Integration

set(0,'DefaultFigureWindowStyle','docked')
clc;clear;close all;clc;


%% Environment Setp

% Set the load path for files and find datasets in .m format
path = 'C:\Users\Abhijit\OneDrive - Columbia University\Work+Projects\Paper\Accepted\Journal\IEEE Open Access\MATLAB Code Set (version 16)\';
cd(path);
dataPath = 'data\MATLABSet\';
cd(dataPath);

% Display all data sets and select a set
fprintf('Current datasets:\n');
dir *.mat;

pathSelectPrompt = 'Which dataset to use?:   ';
pathSelect = input(pathSelectPrompt,'s');
if isempty(pathSelect)
    pathSelect = 'SmallSquare';
end



%% Data Import

% Get device calibration files and path file
load([path dataPath 'androidCalibrationProfile.mat']);
load([path dataPath pathSelect '.mat']);
load([path dataPath 'gpsData.mat']);

% Set up frequency of data collection and sampling length
feq = 1/delta;
dataLength = length(delta);
loggingSample = 1:dataLength;
loggingSample=loggingSample';

% degree to radians
oX = oX*(pi/180);
oY = oY*(pi/180);
oZ = oZ*(pi/180);

% normalise values to start at zero
oX = oX-mean(oX(1:50));
oY = oY-mean(oY(1:50));
oZ = oZ-mean(oZ(1:50));


% Acc normalize
accX = accX/9.82;
accY = accY/9.82;
accZ = (accZ/9.82);

%% Orientation Detection

% Set up the yaw, roll, and pitch relations
% x -> roll y-> pitch z-> yaw
motionPitch = oY - mean(oY(1:20));
motionRoll = oX - mean(oX(1:20));
motionYaw = oZ - mean(oZ(1:20));

% Virtual device for orientation tracking
P = zeros(16,3,dataLength+1);
A = [0 0 0];
B = [1 0 0];
C = [0 1 0];
D = [0 0 1];
E = [0 1 1];
F = [1 0 1];
G = [1 1 0];
H = [1 1 1];
P(:,:,1) = [A;B;F;H;G;C;A;D;E;H;F;D;E;C;G;B];


L = zeros(2,3,dataLength+1);
A = [0 0 0];
B = [0 1 0];
L(:,:,1) = [A;B];

theta=zeros(1,dataLength+1);
theta(1)=0;

roll = motionRoll; 
pitch = motionPitch; 
yaw = motionYaw;
dcm = zeros(3,3,dataLength);

for count = 1:dataLength
    dcm(1,1,count) = cos(yaw(count))*cos(pitch(count));
    dcm(2,1,count) = sin(yaw(count))*cos(pitch(count));
    dcm(3,1,count) = -sin(pitch(count));

    dcm(1,2,count) = cos(yaw(count))*sin(pitch(count))*sin(roll(count)) - sin(yaw(count))*cos(roll(count));
    dcm(2,2,count) = sin(yaw(count))*sin(pitch(count))*sin(roll(count)) + cos(yaw(count))*cos(roll(count));
    dcm(3,2,count) = cos(pitch(count))*sin(roll(count));

    dcm(1,3,count) = cos(yaw(count))*sin(pitch(count))*cos(roll(count)) + sin(yaw(count))*sin(roll(count));
    dcm(2,3,count) = sin(yaw(count))*sin(pitch(count))*cos(roll(count)) - cos(yaw(count))*sin(roll(count));
    dcm(3,3,count) = cos(pitch(count))*cos(roll(count));
    P(:,:,count+1) =    P(:,:,1) *dcm(:,:,count);
    L(:,:,count+1) =    L(:,:,1) *dcm(:,:,count);
    
    point1 = L(:,:,1);
    point2=L(:,:,count+1);
    theta(count+1) = acos(((point1(2,1)*point2(2,1)) + (point1(2,2)*point2(2,2)))/sqrt((point2(2,1)^2) + (point2(2,2)^2)));
end

%L(2,1,:) = -1*L(2,1,:);

set(0,'DefaultFigureWindowStyle','normal')

dataNumber = 0;%input('Show orientation tracking? (1/0):  ');
if(dataNumber == 1)

    fig = figure(1);
    set(fig,'DoubleBuffer','on');
    set(gca,'xlim',[-2 2],'ylim',[-2 2],'zlim',[-2 2],...
    'NextPlot','replace','Visible','off')

%     for moo = 1:dataLength
%         figure(1)
%         plot3(L(:,1,moo),L(:,2,moo),L(:,3,moo));
%         axis([-3 3 -3 3 -3 3]) 
%         grid on;
%         title(['time   '  num2str(moo/100)]);
%         %figure(2)
%         %plot(horzcat(accZ(1:moo)',zeros(1,dataLength-moo)));
%         %axis([0 dataLength min(accZ) max(accZ)]);
%         pause(.005)
%     drawnow  
%     end
   

    for moo = 1:dataLength
        figure(1)
        plot(L(:,1,moo),L(:,2,moo));hold on;
        plot(L(:,1,1),L(:,2,1));
        hold off;
        axis([-3 3 -3 3]) 
        grid on;
        title(['time   '  num2str(moo/100) '       theta   ' num2str(theta(moo)*(180/pi))]);
        %figure(2)
        %plot(horzcat(accZ(1:moo)',zeros(1,dataLength-moo)));
        %axis([0 dataLength min(accZ) max(accZ)]);
        pause(.005)
    drawnow  
    end

end
   
   set(0,'DefaultFigureWindowStyle','docked')


%% Footstep tracker

% Quantitative stride length (meters)
meanDist = (5*12 + 8.135)/3;
meanDist = meanDist*0.0254;

% Find strides
[pks,locs] = findpeaks(accZ,'MinPeakHeight',1.1);
%figure(1);
%plot(loggingSample,accZ,loggingSample(locs),pks,'rv','MarkerFaceColor','r'); grid on;
%xlabel('loggingSample'); ylabel('Accz')
%title('Find All Peaks'); legend('Sunspot Data','Peaks')

% Sum all strides
distTrack = zeros(1,dataLength);
source = 1;
distTrack(1:locs(1)) = 1;
for count=2:length(locs)
        distTrack(locs(count-1)+1:locs(count)) = count;    
end
distTrack(locs(count):dataLength) = count;

% Magnitudes for heading
magL = zeros(1,length(L));
for count=1:length(L)
    magL(count) = sqrt(L(2,1,count)^2 + L(2,2,count)^2);
end

positionTrack = zeros(dataLength,2);
for count = 2:dataLength
    positionTrack(count,1) = positionTrack(count-1,1) + ((meanDist*(distTrack(count)-distTrack(count-1)))/magL(count))*L(2,1,count);
    positionTrack(count,2) = positionTrack(count-1,2) + ((meanDist*(distTrack(count)-distTrack(count-1)))/magL(count))*L(2,2,count); 
end


%%

set(0,'DefaultFigureWindowStyle','normal')


dataNumber = 0;%input('Show orientation tracking with mapping? (1/0):  ');
if(dataNumber == 1)

    fig = figure(2);
    set(fig,'DoubleBuffer','on');
    set(gca,'xlim',[-2 2],'ylim',[-2 2],'zlim',[-2 2],...
    'NextPlot','replace','Visible','off')

    for moo = 1:dataLength
        figure(2)
        plot(L(:,1,moo),L(:,2,moo));hold on;
        plot(L(:,1,1),L(:,2,1));
        hold off;
        axis([-3 3 -3 3]) 
        grid on;
        title(['time   '  num2str(moo/100) '       theta   ' num2str(theta(moo)*(180/pi))]);
        figure(3)
        plot(positionTrack(1:moo,1),positionTrack(1:moo,2));
        axis([min(positionTrack(:,1)) max(positionTrack(:,1)) min(positionTrack(:,2)) max(positionTrack(:,2))]);
        pause(.005)
    drawnow  
    end
    
else
    dataNumber = 1;%input('Show final tracking map? (1/0):  ');
    if (dataNumber == 1)
        trackingMap = figure(3);
        plot(positionTrack(:,1),positionTrack(:,2),'.');
        axis([min(positionTrack(:,1))-10 max(positionTrack(:,1))+10 min(positionTrack(:,2))-10 max(positionTrack(:,2))+10]);
    end
end




%% GPS tracking

dataNumber = 0;%input('Show GPS tracking with mapping? (1/0):  ');
if(dataNumber == 1)
gpsDataLength = length(gpsEast);



     for moo = 1:gpsDataLength
         figure(4)
         plot(gpsEast(1:moo),gpsNorth(1:moo),'.');
         axis([min(gpsEast)-1000 max(gpsEast)+1000 min(gpsNorth)-1000 max(gpsNorth)+1000]);
         title([num2str(moo) '   /   ' num2str(gpsDataLength)]);
         pause(.005)
     drawnow  
     end
else
    dataNumber = 1;%input('Show final GPS tracking map? (1/0):  ');
    if (dataNumber == 1)
        gpsTrackingMap = figure(4);
        plot(gpsEast,gpsNorth,'.');
    end
end


%%
displayFig(positionTrack,gpsEast,gpsNorth);


%%



% 
% uiwait(msgbox('In the Graph presented, select the earliest data point for the current segment.','Data Fill In','modal'));
% figure(trackingMap);
% [pindA,xs,ys] = selectdata('selectionmode','closest', 'verify','on','label','on');    
% hold on;
% plot(positionTrack(numcell2mat(pindA),1),positionTrack(numcell2mat(pindA),2),'o','MarkerSize',10);
% hold off;
% uiwait(msgbox('In the Graph presented, select the latest data point for the current segment.','Data Fill In','modal'));
% figure(trackingMap);
% [pindB,xs,ys] = selectdata('selectionmode','closest', 'verify','on','label','on');    
% hold on;
% plot(positionTrack(numcell2mat(pindB),1),positionTrack(numcell2mat(pindB),2),'o','MarkerSize',10);
% hold off;
% 
% 
% 
% 
% uiwait(msgbox('In the Graph presented, select the earliest GPS point for the current segment.','Data Fill In','modal'));
% figure(gpsTrackingMap);
% [pindC,xs,ys] = selectdata('selectionmode','closest', 'verify','on','label','on');    
% hold on;
% plot(gpsEast(numcell2mat(pindC)),gpsNorth(numcell2mat(pindC)),'o','MarkerSize',10);
% hold off;
% uiwait(msgbox('In the Graph presented, select the latest GPS point for the current segment.','Data Fill In','modal'));
% figure(gpsTrackingMap);
% [pindD,xs,ys] = selectdata('selectionmode','closest', 'verify','on','label','on');    
% hold on;
% plot(gpsEast(numcell2mat(pindD)),gpsNorth(numcell2mat(pindD)),'o','MarkerSize',10);
% hold off;




%%

% %% Plotting
% 
% plotterNum = 3;
% xPlotT = [efxAcc efxVel efxDisp];
% yPlotT = [efyAcc efyVel efyDisp];
% zPlotT = [efzAcc efzVel efzDisp];
% 
% hFig = figure(2);
% stem(loggingSample,xPlotT(:,plotterNum),'b');
% grid on;
% xlabel('TimeStamp (s)');
% ylabel('Displacement - Towards East');
% title('Earth Frame X Axis Acceleration (East)');
% set(findall(gcf,'-property','FontSize'),'FontSize',14);
% set(gcf,'color','w');
% set(hFig, 'Position', [50, 50, 1500, 900]);
% print('-dpng','-r72','efcNetXCircle.png')
% 
% hFig = figure(3);
% stem(loggingSample,yPlotT(:,plotterNum),'b');
% grid on;
% xlabel('TimeStamp (s)');
% ylabel('Displacement - Towards North');
% title('Earth Frame Y Axis Acceleration (North)');
% set(findall(gcf,'-property','FontSize'),'FontSize',14);
% set(gcf,'color','w');
% set(hFig, 'Position', [50, 50, 1500, 900]);
% xlim([min(loggingSample) max(loggingSample)]);
% print('-dpng','-r72','efcNetYCircle.png')
% 
% hFig = figure(4);
% stem(loggingSample,zPlotT(:,plotterNum),'b');
% grid on;
% xlabel('TimeStamp (s)');
% ylabel('Displacement - Towards Sky');
% title('Earth Frame Z Axis Acceleration (Up)');
% set(findall(gcf,'-property','FontSize'),'FontSize',14);
% set(gcf,'color','w');
% set(hFig, 'Position', [50, 50, 1500, 900]);
% xlim([min(loggingSample) max(loggingSample)]);
% print('-dpng','-r72','efcNetZCircle.png')
% 
% 
% 
% 
% 
% %%
% 
% 
% fig = figure(6);
% 
% 
%  
%  set(fig,'DoubleBuffer','on');
% set(gca,'xlim',[-2 2],'ylim',[-2 2],'zlim',[-2 2],...
% 'NextPlot','replace','Visible','off')
%  
% for moo = 2:loggingSample+1
%     figure(6)
%     plot3(P(:,1,moo) + efxDisp(moo),P(:,2,moo) + efyDisp(moo),P(:,3,moo) + efzDisp(moo));
%     axis([-2 2 -2 2 -2 2]) 
%     grid on;
%     title(['time   '  num2str(moo/100)]);
%     pause(0.01)
% %viewable axis depends on amplitude of action potential and length of
% %membrane
% %     F = getframe(fig);
% %     mov = addframe(mov,F);
% drawnow  
% end