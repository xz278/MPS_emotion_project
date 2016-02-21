classdef ThreadNode < handle
  properties
    id; % int; the number of lines given as an input
    parentId; % int; initally set to 0; added after the entire file is written.
    childrenIds; % an array of integers; same as above
    content; % a map objective
  end
  
  methods
    function node = TreadNode(line,titles,id)
      node.id = id;
      node.parentId = 0;
      node.childrenId = 0;
      node.content = Map();
      n = size(titles,2); % number of titles
      m = size(line,2);
      len = size(line,2);
      
      % fields before 'body': 1--17
      j = 1;
      for (i=1:17)
        % get ith filed value w
        wc = 1;
        w = [];
        while (j<=m && ~strcmp(',',l(j)))
          w(wc) = l(j);
          j = j+1;
          wc = wc+1;
        end
        j = j+1;
        % put this pair into content
        node.content.put(titles{i},w);
      end
      
      % three fileds related to 'body': 21-24
      k = 24;
      b = len;
      for (c=24:21)
        wc = 0; 
        w = [];
        while (b>0 && ~strcmp(line(b),','))
          wc = wc+1;
          w(wc) = line(b);
          b = b-1;
        end
        b = b-1;
        % reverse the word to corret order
        nw = [];
        for (index = 0:wc-1)
          nw(index) = w(wc-index);
        end
        % add the field to content
        node.content.put(titles{c},nw);
      end
      
      % fileds regarding 'body' text
      node.content.put('body',line(j:b));
    end
  end
end