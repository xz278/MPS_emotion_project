% a custom set class 
% --------function included--------------------
% constructor: SSet()
% putItem(item)
% contains(item)
% getItems() return all items in a cell array
% print()  print to screen
% --------------------------------------------
classdef SSet < handle
  properties
    items; % a cell array of items in the set, in the form of string
    nItems; % number of items
  end
  
  methods 
    function sset = SSet(cellArray)
      if (nargin<1)
        sset.items = {};
      else
        sset.items = cellArray;
      end
      sset.nItems = size(sset.items,2);
    end
    
    function putItem(self,item)
      if (~strcmp(class(item),'char'))
        item=num2str(item);
      end
      i = 1;
      exist = false;
      while (i<=self.nItems && ~exist)
        if (strcmp(self.items{i},item))
          exist = true;
          i = self.nItems+1;
        else
          i = i+1;
        end
      end
      if (~exist)
        self.nItems = self.nItems+1;
        self.items{self.nItems} = item;
      end
    end
    
    function a = contains(self,item)
      if (~strcmp(class(item),'char'))
        item=num2str(item);
      end
      i = 1;
      a = 0;
      while (i<=self.nItems)
        if (strcmp(self.items{i},item))
          a = 1;
          i = self.nItems+1;
        else
          i = i+1;
        end
      end
    end
    
    
    function i = getItems(self)
      i = self.items;
    end
    
    function print(self)
      str = [''];
      for (i=1:self.nItems)
        str = [str self.items{i} '\n'];
      end
      fprintf(str);
    end
    
    function s=getSize(self)
      s=self.nItems;
    end
    
    function s=toArray(self)
      s=self.items;
    end
  end
  
end