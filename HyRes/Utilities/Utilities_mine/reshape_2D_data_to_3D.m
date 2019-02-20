function [H]=reshape_2D_data_to_3D(Y,s1,s2)
    
% usage
% [Y]=reshape_2D_data_to_3D(Y,s1,s2)
% Reshape 2D matrix in 3D as each column is a band 
% input
% Y : vactorized 3D data in 2D matrix
% s1 : the number of rows of 3D data
% s2 : the number of columns of of 3D data
% output
% H : 3D data
% See also reshape_3D_data_to_2D
%
% Written by Behnood Rasti
% (c) 2012

S=size(Y);
H=zeros(s1,s2,S(2));
for i=1:S(2)
    H(:,:,i)=reshape(Y(:,i),s1,s2);
end