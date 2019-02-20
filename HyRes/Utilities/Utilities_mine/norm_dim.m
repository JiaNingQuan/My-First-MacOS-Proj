function y=norm_dim(x,dim)
%
% usage y=norm_dim(x,dim)
%
% input
% x : matrix
% dim ; direction of the norm calculation
% output
% y : a vector as long as the length of the matrix in the second dimention
%
% (c) 2012, written by Behnood Rasti



y = sqrt(sum(x.*x,dim));