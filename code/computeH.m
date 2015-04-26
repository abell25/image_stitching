function [H] = computeH(t1, t2)
  N = size(t1, 2)

  if size(t2, 2) ~= N,
      error("dimensions dont match!");
  end

  if size(t1, 1) ~= 2 || size(t2, 1) ~= 2,
      error("expecting 2 values each");
  end

  points1 = t1';
  points2 = t2';

  A = zeros(2*N, 8);
  h = zeros(8,1);
  b = t2(:);

  % x' = h00 x0 + h01 y0 + h02 / h20 x0 + h21 y0 + 1
  % y' = h10 x0 + h11 y0 + h12 / h20 x0 + h21 y0 + 1

  for k=1:N,
    idx = (k-1)*2 + 1;
    x  = points1(k, 1);
    y  = points1(k, 2);
    xp = points2(k, 1);
    yp = points2(k, 2);
    A(idx,   :) = [x y 1 0 0 0 -x*xp -y*xp];
    A(idx+1, :) = [0 0 0 x y 1 -x*yp -y*yp];
  end

  % Ah = b  ->  h = A^-1 * b
  h = A \ b;
  h(9) = 1;

  H = reshape(h,3,3)';
endfunction
