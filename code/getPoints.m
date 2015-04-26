function points = getPoints(image)
  done = false;
  while !done,
      imshow(image);
      title('Click on correspondence points, press ENTER when complete');
      hold on;
      [xs ys] = ginput();
      points = [xs ys]';
      plot(xs, ys, 'rx', 'linewidth', 2);
      for k=1:rows(xs),
          text(xs(k), ys(k)-10, num2str(k))
      end
      title('do these look ok? Type yes or no');
      done = yes_or_no('do these look ok?')
      title('');
      hold off;
  end
endfunction

