%% an object is a collection of ThreadNodes

classdef ThreadTree < handle
  properties
    nodes; % a cell array that stores nodes
    ids; % an array of int representing ids from raw data
    treeSize;
    snopeId;
    snopeNode;
    snopedNode;
    depth;
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
      tree.snopeNode = -1;
      tree.snopedNode = -1;
      tree.depth = 0;
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
      if (~strcmp(class(id),'double'))
        id = str2num(id);
      end
      if (sum(self.ids==id)==0)
        n = null;
        frpintf('Invalid id\n');
      else
        n = self.nodes{self.ids==id};
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

        % generate snope and snoped node
        l = size(self.snopeId,2);
        snopeId = [''];
        c = 1;
        while (c<=l && ~strcmp(self.snopeId(c),'_'))
          snopeId = [snopeId self.snopeId(c)];
          c = c+1;
        end
        c = c+1;
        self.snopeNode = self.getNodeById(str2num(snopeId));
        
        % skip 'snope'
        while (c<=l && ~strcmp(self.snopeId(c),'_'))
          c = c+1;
        end
        c = c+1;
        snopedId = [''];
        while (c<=l && ~strcmp(self.snopeId(c),'_'))
          snopedId = [snopedId self.snopeId(c)];
          c = c+1;
        end
        self.snopedNode = self.getNodeById(str2num(snopedId));
    end
    
    function id = getSnopeId(self)
      id = self.snopeId;
    end
    
    % connect nodes according to ids, call this function when all entries for 
    % this tree is add.
    function chainNodes(self)
      n = self.treeSize;
      for (i=1:n)
        parentId = str2num(self.nodes{i}.getValue('parent_id'));
        if (size(parentId,2)==0)
          % no parent node
        else
          location = find(self.ids==parentId);
          if (size(location,2)==0)
            % no parent 
          else
            pNode = self.nodes{location};
            pNode.addChild(self.nodes{i}.getId());
            pNode.addChildObj(self.nodes{i});

            self.nodes{i}.setParent(parentId);
            self.nodes{i}.setParentObj(pNode);
          end
        end
      end

      % self.depth = ThreadTree.computeDepth(self,0);
    end 


    function n = getSnopeNode(self)
      n = self.snopeNode;
    end

    function n = getSnopedNode(self)
      n = self.snopedNode;
    end

    function d = getDepth(self)
      if (self.depth==0)
        self.depth = ThreadTree.computeDepth(self.snopedNode,0);
      end
      d = self.depth;
    end
    
    function draw(self)
      drawThreadTree(self.snopedNode,'b',0,0,1,1,0.2);
    end



  end

  
  methods(Static)
      function d = computeDepth(node,pd)
        set(0,'RecursionLimit',1000);
        % nc = node.getChildrenNum()
        if (node.isLeaf())
          d = pd+1;
        else
          nc = node.getChildrenNum();
          t = 0;
          for (i=1:nc)
            m = ThreadTree.computeDepth(node.children{i},pd+1);
            if (m>t)
              t = m;
            end
          end
          d = t;
        end
      end
  end


end