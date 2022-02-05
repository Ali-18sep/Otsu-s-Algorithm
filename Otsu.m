close all
clear
clc
path = "horse.jpg";
img = rgb2gray(imread(path));

arr = [intmax];
minTSS = 9223372036854775;
req_val = 0;
mat = zeros(1,256);
for i=0:255

    img1 = img<i;
    img2 = img>i;
    
    mask1 = img(img1);  % masking the image
    mask2 = img(img2);
    
    tss1 = 0;
    tss2 = 0;
    mean1 = mean(mask1(:));  % mean of the masks
    mean2 = mean(mask2(:));
    
    mask1 = double(mask1);
    mask2 = double(mask2);
    for j=1:size(mask1,1)
        for k=1:size(mask1,2)
            tss1 = tss1 + (mask1(j,k)-mean1).^2;  % calculating TSS value
        end
    end
    %     disp(j)
    for z=1:size(mask2,1)
        for p=1:size(mask2,2)
            tss2 = tss2 + (mask2(z,p)-mean2).^2;
        end
    end
    %     arr = [arr tss1+tss2];
    mat(i+1) = tss1+tss2;
    if (tss1+tss2<minTSS)  % to find the minimum required value
%         disp(tss1+tss2)
        minTSS = tss1+tss2;
        req_val = i;
    end
end

disp(req_val)   % this is the final Otsu's Value
an = img>req_val;
imwrite(an,'Otus_OUTPUT.png')
mat = mat';
% csvwrite('thresold_csv0.csv',mat)
writematrix(mat,'Otsus_allthresolds.csv')
imshow(an)
%
% image = imread(path);
% % disp(image)
% img = double(image);
% %
% % an = img<104;
% % imshow(uint8(an))
%
% min_tss = intmax;
% req_val = 0;
% for i=1:255
%     tss = 0;
%     temp = i;
%     for j=1:numel(image)
% %         disp(min_tss)
% %         disp(numel(image))
%         tss = tss + (temp-image(j)).^2;
%     end
%     if tss<min_tss
%         min_tss = tss;
%         req_val = temp;
%     end
% %     disp(image(i))
% end
% disp(req_val)
% an = image<req_val;
%
% figure, imshow(uint8(an))
%
%
