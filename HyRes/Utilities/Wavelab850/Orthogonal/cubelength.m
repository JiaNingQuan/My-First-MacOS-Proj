function [n,J] = cubelength(x)
% quadlength -- Find length and dyadic length of square matrix
%  Usage
%    [n,J] = cubelength(x)
%  Inputs
%    x   3-d object; size(n,n,n), n = 2^J (hopefully)
%  Outputs
%    n   length(x)
%    J   least power of two greater than n
%
%  Side Effects
%    A warning message is issue if n is not a power of 2,
%    or if x is not a qube array.
%
	s = size(x);
	n = s(1);
	if (s(2) ~= s(1) || s(2) ~= s(3))
		  disp('Warning in cubelength: nr != nc or nr != np')
	end
	k = 1 ; J = 0; while k < n , k=2*k; J = 1+J ; end ;
	if k ~= n ,
		  disp('Warning in cubelength: n != 2^J')
	end

%
% Copyright (c) 1993. David L. Donoho%   
% 3-D Modification Vicki Yang and Brani Vidakovic
%                  ISyE, GaTech 2002.
