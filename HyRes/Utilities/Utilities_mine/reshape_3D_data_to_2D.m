function [Y, s1, s2]=reshape_3D_data_to_2D(H)
    
% usage
% [Y, s1, s2]=reshape_3D_data_to_2D(x)
% Reshape 3D matrix in 2D as each band is a column (vector)
% input
% H : 3D data
% output
% Y : vactorized 3D data in 2D matrix
% s1 : the number of rows of 3D data
% s2 : the number of columns of of 3D data
% See also reshape_2D_data_to_3D
%
% Written by Behnood Rasti
% (c) 2012

[s1,s2,s3]=size(H);
Y=zeros(s1*s2,s3);
for i=1:s3
    Y(:,i)=reshape(H(:,:,i),s1*s2,1);
end
