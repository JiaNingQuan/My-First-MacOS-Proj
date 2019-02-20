% Demo-1 HyRes
load Indian
[Y_restored]=HyRes(Indian);
%% Denoised data
BN=1; % Number of band
figure(1)
subplot(1,2,1),imagesc(Indian(:,:,BN));colormap(gray);axis image;axis off;title(['Band', num2str(BN)]);
subplot(1,2,2),imagesc(Y_restored(:,:,BN));colormap(gray);axis image;axis off;title(['Denoised Band', num2str(BN)]);