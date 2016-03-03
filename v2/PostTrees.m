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
			n=self.fields.getSize();
			m=size(fs,2);
			for (i=1:m)
				n=n+1;
				self.fields.putItem(fs{i});
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
				t=self.trees.getValueAt(pos);
			end
		end

		function update(self)
			for (i=1:self.nTrees)
				self.trees.values{i}.update();
			end
		end

		function s=getSize(self)
			s=self.nTrees;
		end


		function print(self)
	        fprintf('            link_id          size        depth       \n');
	        fprintf('----------------------------------------------------------------------------------------\n');
	        for (i=1:self.nTrees)
	            fprintf('%4.0d     %11s         %3.0d          %2.0d           \n', i, num2str(self.getTreeAt(i).linkId),...
		                                                  self.getTreeAt(i).getSize(),...
		                                                  self.getTreeAt(i).getDepth()...
		                                                  );
	        end
	    end

	    function draw(self,showSnope,lineWidth,arg1,arg2,arg3,arg4)
	      txt = 0;
	      hl = 0;
	      if (nargin~=3)
	        if (nargin==5)
	          if (strcmp(arg1,'highlight') || strcmp(arg1,'hl'))
	            if (~strcmp(class(arg2),'char') && ~strcmp(class(arg2),'double'))
	              fprintf('invalid arguments: bad type\n');
	              return;
	            end
	            hl = arg2;
	          elseif (strcmp(arg1,'text'))
	            txt = arg2;
	          else
	            fprintf('error 01:\n');
	            fprintf('invalid arguments\n');
	            return;
	          end
	        elseif (nargin==7)
	          if (strcmp(arg1,'highlight') || strcmp(arg1,'hl'))
	            if (~strcmp(class(arg2),'char') && ~strcmp(class(arg2),'double'))
	              fprintf('invalid arguments: bad type\n');
	              return;
	            end
	            hl = arg2;
	          elseif (strcmp(arg1,'text'))
	            txt = arg2;
	          else
	            fprintf('error 02:\n');
	            fprintf('invalid arguments\n');
	            return;
	          end
	          if (strcmp(arg3,'highlight') || strcmp(arg1,'hl'))
	            if (~strcmp(class(arg4),'char') && ~strcmp(class(arg4),'double'))
	              fprintf('invalid arguments: bad type\n');
	              return;
	            end
	            hl = arg4;
	          elseif (strcmp(arg3,'text'))
	            txt = arg4;
	          else
	            fprintf('error 03:\n');
	            fprintf('invalid arguments\n');
	            return;
	          end
	        else
	            fprintf('error 04:\n');
	            fprintf('invalid arguments\n');
	            return;
	        end
	      end
	        
	      close all;
	      hold on;
	      axis off;
	      drawThreadTree(self.root,showSnope,lineWidth,[0.7 0.7 0.7],0,0,1,1,0.2,txt,hl);
	    end


	end
end