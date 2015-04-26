function points2 = applyH(H, points1)
    uvw = H*[points1; ones(1, columns(points1))];
    xs = uvw(1,:)./uvw(3,:);
    ys = uvw(2,:)./uvw(3,:);
    points2 = [xs; ys];
endfunction
