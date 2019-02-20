function [Y]=extension(TYPE,MODE,X,L,LOC,s3,LOCz)
%
% s3 : The size of the extention in third direction
% s3=0 : no extenstion in the z direction
% The type of the extension is symetric-
% The code is not written for general case yet
% LOC :  'r' or 'd' for down and right extension
%        'l' or 'u' for left and up extension
% LOCz : 'lr' or 'rl' for left and right extension symmetrically
%        'l'  for left extension symmetrically
%        'r'  for right extension symmetrically
% This is a modified version of the wextend for the full help
%
% See also wextend
%
% Written by Behnood Rasti, Johannes R. Sveinsson and Magnus Orn Ulfarsson
% (c) 2012


% Note : In the third axis the code extends symetrically to left or
% right or both


[n1,n2,n3]=size(X);

for i=1:n3
    Y(:,:,i) = wextend(TYPE,MODE,X(:,:,i),L,LOC);
end

if s3>n3
    error('Symetric extension in the z-direction is impossible, the extension size is larger than data size')
end
if s3~=0 && n3~=0
    switch LOCz
        case {'lr', 'rl'}
            y1=flipdim(Y(:,:,1:floor(s3/2)),3);
            y2=flipdim(Y(:,:,end-ceil(s3/2)+1:end),3);
            y3 = cat(3,y1,Y);
            Y = cat(3,y3,y2);
            if mod(s3,3)~=0
               warning(' The extension is not symetric, one component more in the right ')
            end
        case {'l'}
            y1=flipdim(Y(:,:,1:s3),3);
            Y = cat(3,y1,Y);
        case {'r'}
            y2=flipdim(Y(:,:,end-s3+1:end),3);
            Y = cat(3,Y,y2);
        otherwise
            warning('The data is not expended in the z diretion')
    end
end