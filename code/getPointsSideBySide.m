function [points1, points2] = getPointsSideBySide(image1, image2)
    subplot(1,2,1);
    imshow(image1);
    subplot(1,2,2);
    imshow(image2);

    subplot(1,2,1);
    points1 = getPoints(image1);
    subplot(1,2,2);
    points2 = getPoints(image2);
endfunction
