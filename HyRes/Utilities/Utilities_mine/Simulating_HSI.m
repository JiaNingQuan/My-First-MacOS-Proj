%% Simulating HSI
function [Y,y,X,x,M,s,Noise,noise,b]=Simulating_HSI(p,SNR,eta,option,verbose)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load USGS_1995_Library % names,datalib
load AM
%load M_100
%M=M_100(:,1:p,jj);
% load M
% M=M(:,1:p);

rng('default')
rand_num=randi(size(names,1),[p 1]);
if verbose
for i=1:size(names,1)
labels{i}=sprintf('%s',names((i),:));
%fprintf(1,'\t');fprintf(1,'%c',names((i),:));
end
str=[];
for i=1:p
    str=cat(1,str,labels{rand_num(i)});
end
disp(str)
end

M=datalib(:,rand_num);

% for i=1:p, AM1(:,:,i)=mat2gray(AM(:,:,i));end;
[N1,N2,~]=size(AM);
N=N1*N2;
s=reshape(cat(3,AM(:,:,1:p-1),AM(:,:,end)),N,p);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if option.sum2one
    s=s./repmat(sum(s,2),[1,p]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = M * s' ;
L=size(M,1);
X=reshape(x',sqrt(N),sqrt(N),L);

x=reshape(X,N,L)';

varianc = sum(x(:).^2)/10^(SNR/10) /L/N ;

quad_term = exp(-((1:L)-L/2).^2*eta^2/2);

varianc_v = vec((varianc)*L*quad_term/sum(quad_term));

Y=X;

b=varianc_v;
rng('shuffle') 
for i=1:L,
    Y(:,:,i)=X(:,:,i)+sqrt(b(i,1))*randn(sqrt(N),sqrt(N));
end
y=reshape(Y,N,L)';
noise=y-x;
Noise=Y-X;
