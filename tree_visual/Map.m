classdef Map < handle
  properties
    keys;
    values;
    s; % size
  end
  
  methods
    function map = Map(key,value)
      if (nargin<2)
        map.keys = {};
        map.values = {};
        map.s = 0;
      else
        map.keys = keys;
        map.values = values;
        map.s = size(keys,2)
      end
    end
    
    function a = contains(self,key)
      a = 0;
      i = 1;
      while (i<=self.s)
        if (strcmp(self.keys{i},key))
          a = 1;
          i = self.s+1;
        else
          i = i+1;
        end
      end
    end   
    
    function putItem(self,key,value)
      hasKey = false;
      index = 1;
      while (~hasKey && index<=self.s)
        if (strcmp(key,self.keys{index}))
          hasKey = true;
          self.values{index} = value;
        end
        index = index+1;
      end
      if (~hasKey)
        self.keys{index} = key;
        self.values{index} = value;
        self.s = self.s+1;
      end
    end
    
    function value = getValue(self,key)
      hasKey = false;
      index = 1;
      while (~hasKey && index<=self.s)
        if (strcmp(key,self.keys{index}))
          hasKey = true;
          value = self.values{index};
        end
        index = index+1;
      end
      if (~hasKey)
        value = null;
        fpintf('Invalid Key\n');
      end
    end
    
    function str = toString(self)
      str = [];
      for (i=1:self.s)
        str = [str self.keys(i) ': ' self.values(i) '\n'];
      end
    end
    
    function print(self)
      for (i=1:self.s)
        fprintf('%s: %s\n',self.keys{i},self.values{i});
      end
    end
    
    function printKeys(self)
      str = [''];
      for (i=1:self.s)
        str = [str self.keys{i} '\n'];
      end
      fprintf(str);
    end
    
    
  end
end