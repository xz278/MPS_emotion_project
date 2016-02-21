classdef Point2D < handle
  properties
    x;
    y;
  end
  
  methods
    function p = Point2D(x,y)
      p.x = x;
      p.y = y;
    end
  end
end