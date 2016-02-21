classdef ThreadNode < handle
  properties
    id; # int; the number of lines given as an input
    parentId; # int; initally set to 0; added after the entire file is written.
    childrenIds; # an array of integers; same as above
    content; # a map objective
  end
  
  methods
    function node = ThreadNode(line,titles,id,bodyL,quoteL,bodyNoQuoteL)
      node.id = id;
      node.parentId = 0;
      node.childrenIds = [];
      node.content = Map();
      n = size(titles,2); # number of titles
      m = size(line,2);
      len = size(line,2);
      
      # fields before 'body': 1--17
      j = 1;
      for (i=1:17)
        # get ith filed value w
        wc = 1;
        w = [];
        while (j<=m && ~strcmp(',',line(j)))
          w(wc) = line(j);
          j = j+1;
          wc = wc+1;
        end
        j = j+1;
        # put this pair into content
        node.content.putItem(titles{i},w);
      end
      
      # three fileds related to 'body': 21-24
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
        # reverse the word to corret order
        nw = [];
        for (index = 0:wc-1)
          nw(index) = w(wc-index);
        end
        # add the field to content
        node.content.putItem(titles{c},nw);
      end
      
      # fileds regarding 'body' text
      # node.content.putItem('body',line(j:b));
      # add body, quote, and body without quote
      # skip the id
      i = 1;
      while (~(strcmp(bodyL(i),',')))
        i = i+1;
      end
      i = i+1;
      #node.content.putItem(titles{18},quoteL(i:end));
      # node.content.putItem('body','test');
#      
#      if (i<=size(quoteL,2))
#        node.content.putItem(titles{19},quoteL(i:end));
#      else
#        node.content.putItem(titles{19},'');
#      end
#      if (i<=size(bodyNoQuoteL,2))
#        node.content.putItem(titles{20},bodyNoQuoteL(i:end));
#      else
#        node.content.putItem(titles{20},'');
#      end  
    end
    
    
    
  end
end