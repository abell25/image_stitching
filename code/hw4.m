1;
load ../data/cc1.mat;
load ../data/cc2.mat;

pkg load image;

function [warpIm, mergeIm] = plotMerge(im1, im2, points1, points2, warpImageInd=1)
    subplot(2,2,1);
    hold on;
    imshow(im1);
    plot(points1'(:,1), points1'(:,2), 'rx', 'linewidth', 2);
    hold off;
    
    subplot(2,2,2);
    hold on;
    imshow(im2);
    plot(points2'(:,1), points2'(:,2), 'rx', 'linewidth', 2);
    hold off;
    
    H = computeH(points1, points2);
    printf('mean projective error: %.2f\n', mean(mean(abs(applyH(H, points1) - points2))));
    
    if warpImageInd,
        [warpIm, mergeIm] = warpImage(im1, im2, H);
    else,
        [warpIm, mergeIm] = projImageOnRect(im1, im2, H);
    endif
       
    subplot(2,2,3);
    imshow(warpIm);
    subplot(2,2,4);
    imshow(mergeIm);

endfunction



%figure(1);
%[cropWarpIm, cropMergeIm] = plotMerge(imread('../data/crop1.jpg'), imread('../data/crop2.jpg'), cc1, cc2);

%figure(2);
im1 = imread('../data/wdc1.jpg');
im2 = imread('../data/wdc2.jpg');

load points1.mat
load points2.mat

%% uncomment these to get new points
%%[points1 points2] = getPointsSideBySide(im1, im2);
%%save points1.mat points1
%%save points2.mat points2

%[buildingWarpIm, buildingMergeIm] = plotMerge(im1, im2, points1, points2);

room1 = imread('../data/rm1.jpg');
room2 = imread('../data/rm2.jpg');
room3 = imread('../data/rm3.jpg');
room4 = imread('../data/rm4.jpg');
room5 = imread('../data/rm5.jpg');

load room_points/p12.mat
load room_points/p21.mat
load room_points/p34.mat
load room_points/p43.mat
load room_points/p14.mat
load room_points/p41.mat

%figure(3);
%[p12 p21] = getPointsSideBySide(room1, room2);
%figure(4);
%[p34 p43] = getPointsSideBySide(room3, room4);

%figure(5);
%[room12WarpIm, room12MergeIm] = plotMerge(room1, room2, p12, p21);
%figure(6);
%[room34WarpIm, room34MergeIm] = plotMerge(room3, room4, p34, p43);

%figure(7);
%[p14 p41] = getPointsSideBySide(room12MergeIm, room34MergeIm);

%save room_points/p12.mat p12
%save room_points/p21.mat p21
%save room_points/p34.mat p34
%save room_points/p43.mat p43
%save room_points/p14.mat p14
%save room_points/p41.mat p41

%figure(8);
%[room14WarpIm, room14MergeIm] = plotMerge(room12MergeIm, room34MergeIm, p14, p41);

%[pImage, pBox] = getPointsSideBySide(im1, room2);
%save room_points/pImage.mat pImage
%save room_points/pBox.mat pBox

load room_points/pImage.mat
load room_points/pBox.mat

[imgBoxWarpIm, imgBoxMergeIm] = plotMerge(im1, room2, pImage, pBox, 0);
