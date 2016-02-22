%% an object is a collection of ThreadNodes

classdef ThreadTree < handle
  properties
    nodes; % a cell array that stores nodes
    ids; % an array of int representing ids
    treeSize;
  end

  methods
    % constructor
    function tree = ThreadTree(fileName, bodyFile, quoteFile, bodyNoQuoteFile)
      if (nargin<4)
        tree.nodes = {};
        tree.ids = [];
      else
        % get titles
        titles = getTitles(fileName);
        nTitles = size(titles,2);
        
        % load files
        fText = fopen(fileName);
        fBody = fopen(bodyFile);
        fQuote = fopen(quoteFile);
        fBodyNoQuote = fopen(bodyNoQuoteFile);
         
        % skip titles
        lText = fgetl(fText);
        lBody = fgetl(fBody);
        lQuote = fgetl(fQuote);
        lBodyNoQuote = fgetl(fBodyNoQuote);
        
        % generate nodes
        cNodes = 1;
        lText = fgetl(fText);
        lBody = fgetl(fBody);
        lQuote = fgetl(fQuote);
        lBodyNoQuote = fgetl(fBodyNoQuote);
        tree.nodes = {};
        tree.ids = [];
        count = 0;
        while (all(lText~=-1) && cNodes<=3)
          tree.nodes{cNodes} = ThreadNode(lText,titles,cNodes,lBody,lQuote,lBodyNoQuote);
          tree.ids(cNodes) = str2num(tree.nodes{cNodes}.getValue('id'));
          lText = fgetl(fText);
          lBody = fgetl(fBody);
          lQuote = fgetl(fQuote);
          lBodyNoQuote = fgetl(fBodyNoQuote);
          cNodes = cNodes+1;
        end
        
        fclose(fText);
        fclose(fBody);
        fclose(fQuote);
        fclose(fBodyNoQuote);
      end
      tree.treeSize = size(tree.nodes,2);
    end
    
    function addNode(self,node)
      id = str2num(node.getValue('id'));
      if (sum(self.ids==id)==0)
        t = self.treeSize+1;
        self.ids(t) = id;
        self.nodes{t} = node;
        self.treeSize = t;
      end
    end
    
    function n = getNode(self,index)
      n = self.nodes{index};
    end
    
    function s = getSize(self)
      s = self.treeSize;
    end
    
  end

end