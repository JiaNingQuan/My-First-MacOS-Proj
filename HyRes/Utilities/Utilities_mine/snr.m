function p = snr(x,y)
%usage p = snr(x,y)
% inputs
% x : clean signal (1D or 2D or 3D)
% y : recoverd signal (1D or 2D or 3D)
% output
% p : signal to noise ratio
%   snr - compute the Signal to Noise Ratio, defined by :
%       SNR(x,y) = 10*log10( sum(y^2) / sum(y-x)^2 ).
%
%   Copyright (c) 2012 Behnood Rasti

% [s1,s2,s3]=size(x);
% if s1>1 && s2==1 && s3==1
%     s=sum(y.^2);
%     d=sum((y-x).^2);
% end
% if s1>1 && s2>1 && s3==1
%     s=sum(sum(y.^2));
%     d=sum(sum((y-x).^2));
% end
% if s1>1 && s2>1 && s3>1
%     s=sum(sum(sum(y.^2)));
%     d=sum(sum(sum((y-x).^2)));
% end
s=sum(y(:).^2);
d=sum((y(:)-x(:)).^2);
p = 10*log10( s/d );