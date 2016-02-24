classdef ThreadTrees < handle
  properties
    trees; % a cell array of ThreadThree
    snopeIds; % a map of snopeIds to corresponding position
    nTrees;
  end

  methods
    % constructor
    % constructor
    function t = ThreadTrees(fileName, bodyFile, quoteFile, bodyNoQuoteFile)
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
      
      % generate trees
      cNodes = 1;
      lText = fgetl(fText);
      lBody = fgetl(fBody);
      lQuote = fgetl(fQuote);
      lBodyNoQuote = fgetl(fBodyNoQuote);
      t.trees = {};
      t.snopeIds = Map();
      t.nTrees = 0;
      while (sum(lText==-1)==0 && cNodes<=50)
        % generate next node
        tempNode = ThreadNode(lText,titles,cNodes,lBody,lQuote,lBodyNoQuote);
        snopeId = tempNode.getValue('snope_id');
        % add node to corresponding tree
        if (t.nTrees==0)
          t.nTrees = t.nTrees+1;
          t.trees{t.nTrees} = ThreadTree();
          t.snopeIds.putItem(snopeId,t.nTrees);
          t.trees{t.nTrees}.addNode(tempNode);
        else
          % if corresponding tree exists
          if (t.snopeIds.contains(snopeId))
            treeIndex = t.snopeIds.getValue(snopeId);
            t.trees{treeIndex}.addNode(tempNode);
          else % if not exists
            t.nTrees = t.nTrees+1;
            t.trees{t.nTrees} = ThreadTree();
            t.snopeIds.putItem(snopeId,t.nTrees);
            t.trees{t.nTrees}.addNode(tempNode);
          end
        end
        
        % go to next line
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

    function s = getSize(self)
      s = self.nTrees;
    end
    
    function t = getTree(self,index)
      if (index>self.nTrees)
        t = 'index out of bound';
      else
        t = self.trees{index};
      end
    end
    
    function t = getTreeById(self,snopeId)
      id = self.snopeIds.getValue(snopeId);
      if (isnull(id))
        t = null;
      else
        t = trees{id};
      end
    end
    
    function ids = getTreesId(self)
      ids = self.snopeIds.keys;
    end
    
    function ids = printTreesId(self)
      self.snopeIds.printKeys();
    end
    
    function addSnopeId(self)
      for (i=1:self.nTrees)
        self.trees{i}.addSnopeId();
      end
    end
    
  end
  
end