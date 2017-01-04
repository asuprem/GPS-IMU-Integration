function [ num ] = numcell2mat( variable )
%numcell2mat Finds if a number or cell and returns cell2mat
%   Detailed explanation goes here
    if (iscell(variable)==1)
       num = cell2mat(variable);    
    else
        num=variable;
    end

end

