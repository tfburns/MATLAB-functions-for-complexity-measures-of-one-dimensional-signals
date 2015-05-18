% Differential Method: sample is given a 1 if the difference between two
%       consecutive samples is +ve and a 0 if -ve
%
% AUTHOR: Stephen Faul
% DATE: 9th Feb 2005
function output=binary_differential(input)
copy=input([end 1:end-1]);
slopes_sign=copy-input;
output=slopes_sign>0;
