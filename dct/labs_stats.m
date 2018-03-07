function a = labs_stats( labs )
%LABS_STATS Summary of this function goes here
%   Detailed explanation goes here
a = [unique(labs), histc(labs, unique(labs))]; 

end

