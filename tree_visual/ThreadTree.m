%% an object is a collection of ThreadNodes

classdef ThreadTree < handle
  properties
    nodes; % a cell array that stores nodes
  end

  methods
    % constructor
    function tree = ThreadTree(fileName, bodyFile, quoteFile, bodyNoQuoteFile)
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
      cNodes = 0;
      lText = fgetl(fText);
      lBody = fgetl(fBody);
      lQuote = fgetl(fQuote);
      lBodyNoQuote = fgetl(fBodyNoQuote);
      tree.nodes = {};
      count = 0;
      while (all(lText~=-1) && count<=100)
        cNodes = cNodes+1;
        count = count+1;
        tree.nodes{cNodes} = ThreadNode(lText,titles,cNodes,lBody,lQuote,lBodyNoQuote);
        lText = fgetl(fText);
        lBody = fgetl(fBody);
        lQuote = fgetl(fQuote);
        lBodyNoQuote = fgetl(fBodyNoQuote);
      end
      
      fclose(fText);
      fclose(fBody);
      fclose(fQuote);
      fclose(fBodyNoQuote);
    end
  end

end