function [warpIm, mergeIm] = projImageOnRect(inputIm, refIm, H)
   ydim = size(inputIm,1);
   xdim = size(inputIm,2);
   ref_ydim = size(refIm,1);
   ref_xdim = size(refIm,2);

   [p,q] = meshgrid(1:xdim,1:ydim);
   input_coords = [p(:),q(:)]';
   output_coords = applyH(H, input_coords);

   % dimensions of warped image
   warp_x_min = floor( min(output_coords(1,:)));
   warp_x_max = ceil(max(output_coords(1,:)));
   warp_y_min = floor( min(output_coords(2,:)));
   warp_y_max = ceil(max(output_coords(2,:)));
   x_min = min(1,        floor( min(output_coords(1,:))));
   x_max = max(ref_xdim, ceil(max(output_coords(1,:))));
   y_min = min(1,        floor( min(output_coords(2,:))));
   y_max = max(ref_ydim, ceil(max(output_coords(2,:))));

   printf('x range: [%d %d], y range: [%d %d]\n', x_min, x_max, y_min, y_max);
   printf('warp x range: [%d %d], warp y range: [%d %d]\n', warp_x_min, warp_x_max, warp_y_min, warp_y_max);
    
   x_width = x_max - (x_min+1)
   y_width = y_max - (y_min+1)

   warpMat = ones(y_width, x_width, 3);
   mergeMat = ones(y_width, x_width, 3);

   [p,q] = meshgrid(x_min:x_max,y_min:y_max);
   warpIm_coords = [p(:),q(:)]';
   origIm_coords = applyH(pinv(H), warpIm_coords);

   for x=1:ref_xdim,
       for y=1:ref_ydim,
           for c=1:3,
             x_adjusted = x - (x_min+1);
             y_adjusted = y - (y_min+1);
             if y_adjusted > 1 && x_adjusted > 1 && y_adjusted < y_width && x_adjusted < x_width,
                 mergeMat(y_adjusted, x_adjusted, c) = refIm(y, x, c);
             end
           end
       end
   end

   for k=1:columns(warpIm_coords),
       x_out = floor(warpIm_coords(1,k));
       y_out = floor(warpIm_coords(2,k));
       x_out_adjusted = max(1, x_out - x_min+1);
       y_out_adjusted = max(1, y_out - y_min+1);
       x_in = round(origIm_coords(1,k));
       y_in = round(origIm_coords(2,k));
       if x_in > 0 && x_in < xdim && y_in > 0 && y_in < ydim,
          for c=1:3,
             warpMat(y_out_adjusted, x_out_adjusted, c) = inputIm(y_in, x_in, c);
             mergeMat(y_out_adjusted, x_out_adjusted, c) = inputIm(y_in, x_in, c);
          end
       end
   end

  warpIm = mat2gray(warpMat);
  mergeIm = mat2gray(mergeMat);

endfunction
