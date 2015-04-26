%Maps image with homography matrix H to a new transformed image
function [input_coords, projIm_coords, origIm_coords, projIm] = projectIm(H, im)
  ydim = size(im,1)
  xdim = size(im,2)
  channels = size(im,3);
  [p,q] = meshgrid(1:xdim,1:ydim);
  input_coords = [p(:),q(:)]';
  output_coords = applyH(H, input_coords);
  x_min = ceil(min(output_coords(1,:)));
  x_max = floor(max(output_coords(1,:)));
  y_min = ceil(min(output_coords(2,:)));
  y_max = floor(max(output_coords(2,:)));
  printf('x range: [%d %d], y range: [%d %d]\n', x_min, x_max, y_min, y_max);
  
  x_width = x_max - (x_min+1)
  y_width = y_max - (y_min+1)
  projIm = ones(y_width, x_width, 3);

  [p,q] = meshgrid(x_min:x_max,y_min:y_max);
  projIm_coords = [p(:),q(:)]';
  origIm_coords = applyH(pinv(H), projIm_coords);

  for k=1:columns(projIm_coords),
      x_out = floor(projIm_coords(1,k));
      y_out = floor(projIm_coords(2,k));
      x_out_adjusted = max(1, x_out - x_min+1);
      y_out_adjusted = max(1, y_out - y_min+1);
      x_in = round(origIm_coords(1,k));
      y_in = round(origIm_coords(2,k));
      if x_in > 0 && x_in < xdim && y_in > 0 && y_in < ydim,
         for c=1:3,
            projIm(y_out_adjusted, x_out_adjusted, c) = im(y_in, x_in, c);
         end
      end
  end

endfunction
