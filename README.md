# Using homography to stitch images

> This code is from a homework project to stitch images together. 

To use, you call getPointsSideBySide.m and supply it the two images.  You must provide at least 4 points but > 8 
is more reasonable for good results.  Your can call `computeH` with these points to retrieve a Homography matrix
that maps from the projective of the first image to the second. 

Calling `warpImage` with the 2 images and the homography matrix will return 2 new images: 
1. The first image projected by the homography matrix
2. The two images stitched together.

__note__:  See hw4.m for an example of calling the methods to generate correspondence points and stitching images. 

__Functions__:
getPoints.m - Collects correspondence points for an image from the user.
getPointsSideBySide.m - Helper function that uses getPoints.m to visually show the user the points (and order) they selected them in with an option to retry.
computeH.m - calculate the projective matrix
applyH.m - applies H to points to get new set of points.  user does not have to bother with homogenuous points then.
warpIm.m - the main function, projects an image onto another, given a get a projective matrix. 



