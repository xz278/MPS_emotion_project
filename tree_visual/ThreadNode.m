classdef ThreadNode < handle
  properties
    id; % id given in raw data, in double, for better search speed
    nodeId; % int; the number of lines given as an input
    parentId; % int; initally set to 0; added after the entire file is written.
    childrenIds; % an array of integers; same as above
    content; % a map objective
  end
  
  methods
    function node = ThreadNode(line,titles,id,bodyL,quoteL,bodyNoQuoteL)
      node.nodeId = id;
      node.parentId = 0;
      node.childrenIds = [];
      node.content = Map();
      n = size(titles,2); % number of titles
      m = size(line,2);
      len = size(line,2);
      
      % fields before 'body': 1--17
      j = 1;
      for (i=1:17)
        % get ith filed value w
        wc = 1;
        w = [''];
        while (j<=m && ~strcmp(',',line(j)))
          w(wc) = line(j);
          j = j+1;
          wc = wc+1;
        end
        j = j+1;
        % put this pair into content
        node.content.putItem(titles{i},char(w));
      end
      
      % three fileds related to 'body': 21-24
      k = 24;
      b = len;
      for (c=24:-1:21)
        wc = 0; 
        w = [''];
        while (b>0 && ~strcmp(line(b),','))
          wc = wc+1;
          w(wc) = line(b);
          b = b-1;
        end
        b = b-1;
        % reverse the word to corret order
        nw = [''];
        for (index = 0:wc-1)
          nw(index+1) = w(wc-index);
        end
        % add the field to content
        node.content.putItem(titles{c},char(nw));
        tempId = node.content.getValue('id');
        if (~strcmp('double',class(tempId)))
          tempId = str2num(tempId);
        end
        node.id = tempId;
      end
      
      % fileds regarding 'body' text
      % node.content.putItem('body',line(j:b));
      % add body, quote, and body without quote
      % skip the id
      i = 1;
      while (~(strcmp(bodyL(i),',')))
        i = i+1;
      end
      i = i+1;
      nw = bodyL(i:end);
      node.content.putItem(titles{18},nw);
      
      if (i<=size(quoteL,2))
        nw = quoteL(i:end);
        node.content.putItem(titles{19},nw);
      else
        node.content.putItem(titles{19},'');
      end
      if (i<=size(bodyNoQuoteL,2))
        nw = bodyNoQuoteL(i:end);
        node.content.putItem(titles{20},nw);
      else
        node.content.putItem(titles{20},'');
      end  
    end
    
    function print(self)
      self.content.print();
    end
    
    function v = getValue(self,key)
      v = self.content.getValue(key);
    end
    
    % return the id in string form for better display
    function id = getId(self)
      id = num2str(self.id); 
    end
    
    function setChild(self)
      n = size(self.childrenIds,2);
      
    end
    
  end
end