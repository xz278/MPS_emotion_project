%% an object is a collection of ThreadNodes

classdef ThreadTree < handle
  properties
    nodes; % a cell array that stores nodes
    ids; % an array of int representing ids from raw data
    treeSize;
    snopeId;
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
      tree.snopeId = '';
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
    
    % get node by id
    function n = getNodeById(self,id)
      if (strcmp(class(id),'char'))
        id = str2num(id);
      end
      if (sum(self.ids==id)==0)
        n = null;
        frpintf('Invalid id\n');
      else
        n = self.nodes{self.ids==id}
      end   
    end
    
    % get node by index
    function n = getNode(self,index)
      if (index>self.treeSize)
        n = null;
        fprintf('Index out of bound\n');
      else
        n = self.nodes{index};
      end
    end
    
    function s = getSize(self)
      s = self.treeSize;
    end
    
    function addSnopeId(self)
        if (self.treeSize>0)
          self.snopeId = self.nodes{1}.getValue('snope_id');
        end
    end
    
    function id = getSnopeId(self)
      id = self.snopeId;
    end
    
    % connect nodes according to ids, call this function when all entries for 
    % this tree is add.
    function chainNodes(self)
      n = self.TreeSize;
      for (i=1:n)
        parentId = str2num(self.nodes{i}.getValue('parent_id'));
        if (length(parentId)==0)
          % no parent node
        else
          location = find(self.ids==parentId);
          if (location==0)
            % no parent 
          else
            pNode = sef.nodes{locatoin};
            pNode.
          end
        end
      end
    end 
    
  end

end