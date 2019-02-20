function MultiChannelImshow(map,X,X2)
% Usage
% MultiChannelImshow(X,X2)
% You will be asked for the bands number in the prompt
% input
% X: A multichannel image (3D Matrix)
% X2: A multichannel image (3D Matrix), to compare 2 multichannel images
% band by band
% map: the type of color map, See the help in Matlab for color map
% Band Number: Can be a vector of the bands number otherwise press a key to
% see the bands in order
% output
% Show the image band by band after pressing a key
%
% (c) 2013, Behnood Rasti
% behnood.rasti@gmail.com


prompt = 'What are the Bands Number? Press Enter if you want to see all. ';
BN = input(prompt);
if nargin<3
    if isempty(BN)
        for i=1:size(X,3)
            figure(1);imagesc(X(:,:,i));
            colormap(map);
            axis image;axis off;
            title(['Band Number=',num2str(i)]);colorbar;
            pause;
        end
    else
        for i=1:length(BN)
            figure(1);imagesc(X(:,:,BN(i)));colormap(map);axis image;axis off;
            title(['Band Number=',num2str(BN(i))]);colorbar;
            pause;
        end
    end
elseif nargin==3
    if isempty(BN)
        for i=1:size(X,3)
            figure(1);subplot(1,2,1);imagesc(X(:,:,i));colorbar;axis image;axis off;colormap(map);
            subplot(1,2,2);imagesc(X2(:,:,i));
            colormap(map);
            axis image;axis off;
            title(['Band Number=',num2str(i)]);colorbar;
            pause;close;
        end
    else
        for i=1:length(BN)
            figure(1);subplot(1,2,1);imagesc(X(:,:,BN(i)));title(['Band Number=',num2str(BN(i))]);colorbar;axis image;axis off;colormap(map);
            subplot(1,2,2);imagesc(X2(:,:,BN(i)));title(['Band Number=',num2str(BN(i))]);colorbar;axis image;axis off;colormap(map);
            pause;close;
        end
    end
end




