
function [sure1,h_opt,t1,Min_sure] = SUREsoft_modified_LR2(x,t1,stdev)

% SUREsoft -- apply soft threshold + compute Stein's unbiased risk estimator
%                                                 (SURE)
%  Usage
%    [sure1,h_opt,t1,Min_sure] = SUREsoft(x,t1,stdev);
%    [sure1,h_opt,t1,Min_sure] = SUREsoft(x,t1);
%    [sure1,h_opt,t1,Min_sure] = SUREsoft(x);
%  Inputs
%    x      input coefficients
%    t1 : Search interval for selecting the optimum tuning parameter
%    stdev  noise standard deviation (default is 1)
%  Outputs
%    sure1    the value of the SURE, using soft thresholding
%    h_opt : The optimum tuning parameter
%    t1 : Search interval for selecting the optimum tuning parameter
%    Min_sure : Min value of SURE
%
%  Description
%    Applies soft-threshold t to all elements of x and computes SURE
%  Note
%    For making a plot of sure for a given vector of thresholds
%    use SURE1soft (for one dimension)
%
%    For minimizing SUREsoft, use minsuresoft (1D)
%  See also:
%    help minsuresoft
%    help SUREhard
%    help GCVsoft
%    help SURE1soft

% This is a fast implementation for SUREsoft: The original code is only gives
% you one SURE value at a time, this code gives you a min over an interval
% ([0,n])
% (c) 2013 modified by Behnood Rasti


N = length(x);

if nargin <3,
    stdev = 1;
end
if nargin <2,
    n=15; % search interval number
    t_max=sqrt(log(N));
    t1=linspace(0,t_max,n);
end
n=length(t1);
x=x(:);
x=repmat(x,1,n);
t=repmat(t1,N,1);

abs_x=abs(x);
s = abs_x - t; 
s = (s > 0);

% N1 = sum(s,1);
%y = sign(x).*(abs_x - t).*s;

%%sure1 = norm_dim((y-x),1).^2 - stdev^2*N + 2*stdev^2*N1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_t=x.^2-t.^2;
%x_t(x_t<0)=0;
x_t=max(x_t,0);
sure1=sum(2*s-x_t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sure1= -sum(x_t)+ 2*stdev^2*N1;
%sure1= -2*sum(y.*x)+sum(y.^2)+ 2*stdev^2*N1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% s = (s < 0);
% N1 = sum(s,1);
% min_x_t=min(abs_x,t).^2;
% sure1=-2*N1+sum(min_x_t);
[Min_sure,idx]=min(sure1);
h_opt=t1(idx);
% if h_opt==t1(end);warning(['The optimum tuning parameter has not been selected',...
%         'please consider to increase the max of search interval (max(t1)) or select t_max=sqrt(log(N)).']);end
% if h_opt==t1(1);warning(['The optimum tuning parameter has not been selected,',...
%         'please consider to decrease the step size of search interval (increase n). Perhaps you can derease max(t1)']);end



% Copyright (c) Maarten Jansen
%
% This software is part of ThreshLab and is copyrighted material.
