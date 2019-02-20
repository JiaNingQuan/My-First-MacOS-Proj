function [V,PC]=PCA_image(im)

% Usage [V,PC]=PCA_image(im)
% Input 
% im: 3D matrix
% output
% PC: Principal Components
%
% See also Inv_PCA_image
%
% (c) 2012 written by Behnood Rasti
% Behnood.Rasti@gmail.com

[nr,nc,p]=size(im);
im1=reshape(im,nr*nc,p);
[U,S,V] = svd(im1,'econ');
PC1=U*S;
PC=reshape(PC1,nr,nc,p);