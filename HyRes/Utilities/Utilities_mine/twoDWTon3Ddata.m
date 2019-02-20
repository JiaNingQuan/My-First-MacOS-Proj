function [y, s1, s2]=twoDWTon3Ddata(x,L,qmf,FWT)

% usage
% [y, s1, s2]=twoDWTon3Ddata(x,L,qmf,FWT)
% Take the 2D-DWT for each band and reshape subbands as [wLL(:);wLH(:);wHL(:);wHH(:)];
% input
% x: 3D data
% L: level of dicomposition
% qmf: quadrature mirror filter
% FWT: either 'mdwt', or 'FWT_PO_1D_2D_3D'. mdwt is defualt which is a mex
% and faster if there is any difficulty choose FWT_PO_1D_2D_3D
%
% output
% y: vactorized 2D ortho-wavelet coefficient for each band as [wLL(:);wLH(:);wHL(:);wHH(:)];
% s1: the number of rows
% s2: the number of columns
% See also ItwoDWTon3Ddata
%
% (c) 2012 Behnood Rasti

[s1,s2,s3]=size(x);

if nargin<4
    FWT='FWT_PO_1D_2D_3D_fast';
end

if nargin<3
    NFC=4;qmf = daubcqf(NFC,'min');
end

if nargin<2
    L=3;
end

if nargin<1
    error('No input is given');
end

if s3==1
    warning('Input is a 2D matrix')
end


% if nargin==1
%     L=3;%level of decompositions
%     NFC=4;%number of filter coefficients
%     qmf = daubcqf(NFC,'min');%wavelet filter
% end

y=zeros(s1*s2,s3);

if strcmpi(FWT,'wavedec2')
    s1=[];
    for i=1:s3
        [y1,S_S] = wavedec2(x(:,:,i),L,['db',num2str(length(qmf)+2)]);
        y(:,i)=vec(y1);
        s1(:,:,i)=S_S;
    end
else
    for i=1:s3
        ydum2=[];
        nx=s1;ny=s2;
        %y1 = FWT2_PO_mine(x(:,:,i),L,qmf);%2d forward transform
        %y1 = mdwt(x(:,:,i),qmf,L);%2d forward transform
        y1=eval([FWT '(x(:,:,i),qmf,L)']);
        ydum=y1;
        for j=1:L
            y2 = mat2cell(ydum,[nx/2,nx/2],[ny/2,ny/2]);
            wLH=cell2mat(y2(1,2));
            wHL=cell2mat(y2(2,1));
            wHH=cell2mat(y2(2,2));
            ydum2= [wLH(:);wHL(:);wHH(:);ydum2];
            nx=nx/2;ny=ny/2;
            ydum=cell2mat(y2(1,1));
        end
        y(:,i)=[ydum(:);ydum2];
    end
end
%s1=S(1);s2=S(2);