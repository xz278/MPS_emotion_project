classdef PostTrees < handle
	properties
		ids; % a ArrayList of linkids in double
		trees; % a map<linkid, tree object>
		nTrees; % number of trees
	end

	methods
		function ts=PostTrees()
			ts.trees=Map();
			ts.nTrees=0;
			ts.ids=ArrayList();
		end

		% input @tree is a post tree object
		function addTree(self,tree)
			if (~self.ids.contains(tree.linkId))
				n=self.nTrees+1;
				self.nTrees=n;
				self.trees{n}=tree;
				self.ids.add(tree.linkId);
			end
		end
	end
end