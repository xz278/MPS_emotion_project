% function included
% Map()                     constructor
% boolean                   contains(key)
% void                      putItem(key,value)
% <E>                       getValue(key)
% string                    toString(self)
% void                      print()
% void                      printKeys()
% a cell array of keys      getKeys()
% a cell array of values    getValues()
% <E>                       getValueByPos(pos)
%----------------------------------------

classdef Map < handle
  properties
    keys; % cell array
    values; % cell array
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
      if (~strcmp(class(key),'char'))
        key=num2str(key);
      end
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
      if (~strcmp(class(key),'char'))
        key=num2str(key);
      end

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
        self.keys{self.s+1} = key;
        self.values{self.s+1} = value;
        self.s = self.s+1;
      end
    end
    
    function value = getValue(self,key)
      if (~strcmp(class(key),'char'))
        key=num2str(key);
      end

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
        value = '-1';
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
    
    function k=getKeys(self)
      k=self.keys;
    end

    function v=getValues(self)
      v=self.values;
    end
    
    function v=getValueAt(self,pos)
      v=self.values{pos};
    end

  end
end