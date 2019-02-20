function [im]=Inv_PCA_image(V,PC)
% Usage [im]=Inv_PCA_image(V,PC)
% Input 
% PC: Principal Components, 3D matrix calculated by PCA_image
% V: 2D matrix calculated by PCA_image
% output
% im: Origninal image (3D matrix)
%
% See also PCA_image
%
% (c) 2012 written by Behnood Rasti 
% Behnood.Rasti@gmail.com
[PC1,nr,nc]=reshape_3D_data_to_2D(PC);
im1 = PC1*V';
im = reshape_2D_data_to_3D(im1,nr,nc);