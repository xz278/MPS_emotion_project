classdef PostTrees < handle
	properties
		% ids; % a ArrayList of linkids in double
		trees; % a map<snopeid, tree object>
		nTrees; % number of trees
		% fields; % a sset of fields

	end

	methods
		function ts=PostTrees()
			ts.trees=Map();
			ts.nTrees=0;
			% ts.ids=ArrayList();
			% ts.fields=SSet();
		end

		% function addFields(self,fs)
		% 	n=self.fields.getSize();
		% 	m=size(fs,2);
		% 	for (i=1:m)
		% 		n=n+1;
		% 		self.fields.putItem(fs{i});
		% 	end
		% end

		function res=contains(self,linkid)
			% if (~strcmp(class(linkid),'char'))
			% 	linkid=num2str(linkid);
			% end
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
			if (self.trees.contains(id))
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

	    function depthStats(self,d)
	    	yCount=[];
	    	yCount2=[];
	    	m=size(yCount);
	    	m2=size(yCount2);
	    	for (i=1:self.nTrees)
	    		t=self.getTreeAt(i);
	    		b=t.getBreadthAt(2);

	    		if (b>m)
	    			yCount(b)=1;
	    		else
	    			yCount(b)=yCount(b)+1;
	    		end
	    		m=size(yCount,2);
	    		if (t.getDepth()>2)
		    		b2=t.getBreadthAt(3);
		    		if (b2>m2)
		    			yCount2(b2)=1;
		    		else
		    			yCount2(b2)=yCount2(b2)+1;
		    		end
		    		m2=size(yCount2,2);
		    	end
	    	end
	    	xBreadths=1:m;
	    	close all;
	    	% hold on;
	    	subplot(2,1,1);
	    	bar(xBreadths,yCount);
	    	subplot(2,1,2);
	    	bar(1:m2,yCount2);
	    end
	


	end
end