


dataLength = length(east);



     for moo = 1:dataLength
         figure(1)
         plot(east(1:moo),north(1:moo));
         axis([min(east)-1000 max(east)+1000 min(north)-1000 max(north)+1000]);
         title([num2str(moo) '   /   ' num2str(dataLength)]);
         pause(.005)
     drawnow  
     end