classdef PostTrees < handle
	properties
		% ids; % a ArrayList of linkids in double
		trees; % a map<linkid, tree object>
		nTrees; % number of trees
		fields; % a sset of fields

	end

	methods
		function ts=PostTrees()
			ts.trees=Map();
			ts.nTrees=0;
			% ts.ids=ArrayList();
			ts.fields=SSet();
		end

		function addFields(self,fs)
			n=size(self.fields,2);
			if (n==0)
				self.fields=SSet(fs);
			else
				m=size(fs,2);
				for (i=1:m)
					n=n+1;
					self.fields.putItem(fs{i});
				end
			end
		end

		function res=contains(self,linkid)
			if (~strcmp(class(linkid),'char'))
				linkid=num2str(linkid);
			end
			res=self.trees.contains(linkid);
		end

		% input @tree is a post tree object
		function addTree(self,tree)
			if (~self.trees.contains(tree.linkId))
				n=self.nTrees+1;
				self.nTrees=n;
				self.trees.putItem(tree.linkId,tree)
			end
		end

		function addPost(self,post)
			pid=post.id;
			tid=post.treeId;
			if (self.trees.contains(tid))
				self.trees.getValue(tid).addPost(post);
			else
				newT=PostTree(tid);
				newT.addPost(post);
				self.addTree(newT);
			end
		end

		function t=getTree(self,id)
			if (self.trees.contains)
				t=self.trees.getValue(id);
			else
				fprintf('link id not found');
			end
		end

		function t=getTreeAt(self,pos)
			if (pos>self.nTrees)
				fprintf('invalid input: PostTrees.getTreeAt(position)');
			else
				t=self.trees.getValueByPos(pos);
			end
		end


	end
end