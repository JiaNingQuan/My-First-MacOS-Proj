function [Y_restored]=HyRes(Y)
%
% HyRes -- Automatic Hyperspectral Restoration Using Low-Rank and Sparse Modeling
% The model used is: Y=D_2XV'+N, and penalized least squares with \ell_1 penalty 
% argmin_X .5*||Y-D_2XV'||_F^2+\lambda||X||_1 
% is used to restore the signal.
%
%
% Citation:
% B. Rasti, M. O. Ulfarsson and P. Ghamisi, "Automatic Hyperspectral Image Restoration Using Sparse and Low-Rank Modeling," 
% in IEEE Geoscience and Remote Sensing Letters.
% doi: 10.1109/LGRS.2017.2764059
%
%  Inputs
%    Y :   Observed (Noisy) (3D) signal
%  Outputs
%    Y_restored : Restored Signal
%
%
% (c) 2017 Behnood Rasti
% behnood.rasti@gmail.com
%
%
%
[nr1,nc1,p1]=size(Y);
L=5;%level of decompositions
NFC=10;%number of filter coefficients
qmf = daubcqf(NFC,'min');%wavelet filter
[w Rw]=estNoise(reshape(Y,nr1*nc1,p1)');
sigma=sqrt(var(w')');
if mod(nr1,2^L)~=0
    Y=extension('2d','sym',Y,[2^L-mod(nr1,2^L),0],'r',0,'r');
end
if mod(nc1,2^L)~=0
    Y=extension('2d','sym',Y,[0,2^L-mod(nc1,2^L)],'r',0,'r');
end
[nx1,ny1,nz1]=size(Y);
tic;
Omega_1=permute((sigma(:)+eps).^2,[3,2,1]);
Omega1=repmat(Omega_1,[nx1,ny1,1]);
Y_W=Omega1.^-.5.*Y;
[V_PCA_Y1,PC]=PCA_image(Y_W);
r_max=p1;
jj=1;
[V,s1,s2]=twoDWTon3Ddata(PC(:,:,1:r_max),L,qmf);
norm_Y=norm(reshape(Y_W,nx1*ny1,nz1),'fro').^2;
n_xyz=nx1*ny1*nz1;
for r=1:r_max
    V_PCA_Y=V_PCA_Y1(:,1:r);
    i=r;
    [sure(i,:),thresh(i),t1,Min_sure(i)] = SUREsoft_modified_LR2(V(:,i));
    if thresh(i)==0 % debuging for happening NAN
        V1(:,i)=V(:,i);
    else
        V1(:,i)= soft(V(:,i),thresh(i));
    end
    sure1(:,jj)= sum(sure,1)+norm_Y-n_xyz;
    [Min_sure1(jj),idx]=min(sure1(:,jj));
    h_opt=t1(1,idx);
    if nargin <3
        if r>1 && Min_sure1(jj)>Min_sure1(jj-1)
            break;
        end
    end
    jj=jj+1;
end
[~,Rank_Sel_sure]=min(Min_sure1);
if Rank_Sel_sure==r_max;warning('The optimum rank has not been selected, please consider to increase r_max.');end
for i = 1:Rank_Sel_sure%nz1
    [sure(i,:),thresh(i),t1,Min_sure(i)] = SUREsoft_modified_LR2(V(:,i));
    if thresh(i)==0 % debuging for happening NAN
        V3(:,i)=V(:,i);
    else
        V3(:,i)= soft(V(:,i),thresh(i));
    end
end
y_est_SURE_Model_7 = ItwoDWTon3Ddata(V3(:,1:Rank_Sel_sure),s1,s2,L,qmf);
Y_restored =Omega1.^.5.*Inv_PCA_image(V_PCA_Y(:,1:Rank_Sel_sure),y_est_SURE_Model_7);
Y_restored=Y_restored(1:nr1,1:nc1,1:p1);