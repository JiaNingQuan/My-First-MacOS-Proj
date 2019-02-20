function y=ItwoDWTon3Ddata(x,s1,s2,L,qmf,IWT)

% usage y=ItwoDWTon3Ddata(x,s1,s2,L,qmf)
% Take the 2D-IDWT for each band and reshape subbands as 3D data;
% input
% s1 : the number of rows
% s2 : the number of columns
% x : 2D matrix consist of vectorized 2D wavelet coefficients
% L : level of dicomposition
% qmf : quadrature mirror filter
% IWT: Either 'midwt', or 'IWT_PO_1D_2D_3D'. mdwt is defualt which is a mex
% and faster if there is any difficulty choose IWT_PO_1D_2D_3D
% output
% y : 2D inverse wavelet transform for each band if cosfficients matrix x
% created by [x, s1, s2]=twoDWTon3Ddata(y)
%
% See also twoDWTon3Ddata
%
% (c) 2012 Behnood Rasti

if nargin<6
    IWT='IWT_PO_1D_2D_3D_fast';
end

if nargin<5
    NFC=4;qmf = daubcqf(NFC,'min');
end

if nargin<4
    L=3;
end

if nargin<3
    error('At least three input should be given as inputs. The size of the image for each band is neccessary, please look at the help and use twoDWTon3Ddata');
end

% if nargin==3
%     L=3;%level of decompositions
%     NFC=4;%number of filter coefficients
%     qmf = daubcqf(NFC,'min');%wavelet filter
% end
S=size(x);
if S(2)==1
    warning('Input is a 2D matrix')
end

y=zeros(s1,s2,S(2));
if strcmpi(IWT,'waverec2')
    for i=1:S(2)
        [y(:,:,i)] = waverec2(x(:,i),s1(:,i),['db',num2str(length(qmf)+2)]);
    end
else
    for i=1:S(2)
        yLL=reshape(x(1:(s1/2^L)*(s2/2^L),i),(s1/2^L),(s2/2^L));
        y1=yLL;
        for j=1:L
            yLH=reshape(x(1*(s1/2^(L-j+1))*(s2/2^(L-j+1))+1:2*(s1/2^(L-j+1))*(s2/2^(L-j+1)),i),(s1/2^(L-j+1)),(s2/2^(L-j+1)));
            yHL=reshape(x(2*(s1/2^(L-j+1))*(s2/2^(L-j+1))+1:3*(s1/2^(L-j+1))*(s2/2^(L-j+1)),i),(s1/2^(L-j+1)),(s2/2^(L-j+1)));
            yHH=reshape(x(3*(s1/2^(L-j+1))*(s2/2^(L-j+1))+1:4*(s1/2^(L-j+1))*(s2/2^(L-j+1)),i),(s1/2^(L-j+1)),(s2/2^(L-j+1)));
            y1=[y1 yLH;yHL yHH];
        end
        y(:,:,i)=eval([IWT '(y1,qmf,L)']);
        %y(:,:,i) = IWT2_PO_mine(y1,L,qmf);%2d forward transform
        %y(:,:,i) = midwt(y1,qmf,L);%2d forward transform
    end
end