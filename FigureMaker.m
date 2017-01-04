hFig = figure(1);
clf;


plot(positionTrack(:,1),positionTrack(:,2),'.');
grid on;
xlabel('East \rightarrow');
ylabel(' North \rightarrow');
title('IMU coordinates');

% dim = [.72 .2 .03 .4];
% annotation('rectangle',dim,'Color','red');
% 
% dim = [.18 .63 .05 .07];
% annotation('rectangle',dim,'Color','red');
% 
% dim = [.18 .40 .05 .17];
% annotation('rectangle',dim,'Color','red');
% 
% dim = [.35 .35 .3 .23];
% str = ['The missing GPS signals need to be obtained by combining' ...
%     ' the IMU data points and correlating them with the known GPS' ...
%     'points. The correlated will be conducted on a section by section' ...
%     'basis, where each section is qualitatively determined as a' ...
%     'direction of travel.'];
% annotation('textbox',dim,'String',str,'Color','black')

set(findall(gcf,'-property','FontSize'),'FontSize',14);
set(gcf,'color','w');
legend('Coordinates');
set(hFig, 'Position', [50, 50, 1000, 700]);
print('-dpng','-r72','resultsIMUCoordinatesOnly.png')


% hFig = figure(1);
% xlabel('East \rightarrow');
% ylabel(' North \rightarrow');
% title('GPS coordinates');
% set(findall(gcf,'-property','FontSize'),'FontSize',14);
% set(gcf,'color','w');
% %set(gcf, 'Position', [50, 50, 1200, 900]);
% 
% plot(positionTrack(:,1),positionTrack(:,2),'.');
% ax1 = gca; % current axes
% ax1.XColor = 'k';
% ax1.YColor = 'k';
% ax1_pos = ax1.Position; % position of first axes
% ax2 = axes('Position',ax1_pos,...
%     'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');
% plot(gpsEast, gpsNorth,'.','Parent',ax2,'Color','k')
% grid on;
% 
% print('-dpng','-r72','gpsCoord.png')




% 
% hFig = figure(1);
% for rr=1:3
%    for cc=1:3
%         subplot(3,3,3*(rr-1)+cc)
%         plot(squeeze(dcm(rr,cc,:)))
%         grid on;
%         xlabel('TimeStamp (s)');
%         ylabel(['DCM:' num2str(rr) ',' num2str(cc)]);
%         set(findall(gcf,'-property','FontSize'),'FontSize',10);
%         set(gcf,'color','w');
%         set(hFig, 'Position', [50, 50, 1200, 900]);
%         print('-dpng','-r72','DCMall.png')
%    end
%    figtitle('Direct Cosine Matrix','fontsize',18);
% end

