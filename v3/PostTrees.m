classdef PostTrees < handle
	properties
		% ids; % a ArrayList of linkids in double
		trees; % a map<snopeid, tree object>
		nTrees; % number of trees
		% fields; % a sset of fields
		% data;
		% attr;

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

		function res=contains(self,snopeid)
			% if (~strcmp(class(linkid),'char'))
			% 	linkid=num2str(linkid);
			% end
			res=self.trees.contains(snopeid);
		end

		% input @tree is a post tree object
		function addTree(self,tree)
			if (~self.trees.contains(tree.snopeid))
				n=self.nTrees+1;
				self.nTrees=n;
				self.trees.putItem(tree.snopeid,tree)
			end
		end

		function addPost(self,post)
			pid=post.id;
			tid=post.snopeid;
			if (self.trees.contains(tid))
				self.trees.getValue(tid).addPost(post);
			else
				newT=PostTree(tid);
				newT.addPost(post);
				self.addTree(newT);
			end
		end

		function t=getTree(self,snopeid)
			if (self.trees.contains(snopeid))
				t=self.trees.getValue(snopeid);
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

		function update(self,data,attr)
			for (i=1:self.nTrees)
				self.trees.values{i}.update(data,attr);
			end
		end

		function s=getSize(self)
			s=self.nTrees;
		end


		function print(self)
	        fprintf('                         link_id               size       depth    breadth at 1    breadth at 2 \n');
	        fprintf('----------------------------------------------------------------------------------------\n');
	        for (i=1:self.nTrees)
	            fprintf('%4.0d     %30s         %3.0d          %2.0d        %3.0d          %3.0d\n', i, num2str(self.getTreeAt(i).snopeid),...
		                                                  self.getTreeAt(i).getSize(),...
		                                                  self.getTreeAt(i).getDepth(),...
		                                                  self.getTreeAt(i).breadths(2),...
		                                                  self.getTreeAt(i).breadths(3)...
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
	

	    % write tree data to excel file
	    function writeToFile(self,fileName)
	    	x={};
	    	x{1,1}='snope_id';
	    	x{1,2}='root';
	    	x{1,3}='snoper';
	    	x{1,4}='snopee';
	    	x{1,5}='number of nodes';
	    	x{1,6}='depth';
	    	x{1,7}='breadth at 2';
	    	x{1,8}='breadth at 3';
	    	x{1,9}='link_id';
	    	ts=self.trees.getValues();
	    	for (i=1:self.nTrees)
	    		x{i+1,1}=self.getTreeAt(i).snopeid;
	    		if (strcmp(class(self.getTreeAt(i).root),'double'))
		    		x{i+1,2}=-1;
		    	else
		    		x{i+1,2}=self.getTreeAt(i).root.id;
		    	end
	    		x{i+1,3}=self.getTreeAt(i).snoper;
	    		x{i+1,4}=self.getTreeAt(i).snopee;
	    		x{i+1,5}=self.getTreeAt(i).nPosts;
	    		x{i+1,6}=self.getTreeAt(i).depth;
	    		x{i+1,7}=self.getTreeAt(i).breadths(2);
	    		x{i+1,8}=self.getTreeAt(i).breadths(3);
	    		x{i+1,9}=self.getTreeAt(i).link_id;
    		end
    		xlswrite(fileName,x);
	    end

	    function n=getTotalNumber(self)
	    	n=0;
	    	for (i=1:self.nTrees)
	    		n=n+self.getTreeAt(i).nPosts;
	    	end
	    end

	    % write all nodes to excel file
	    % id,index,parentId,is_snope,is_snoped,status(1,2.1,2.2,3.1,3.2),link_id,snoper,snopee
	    function writeAllToFile(self,data,attr)
	    	titles=strsplit('id,index,parentId,is_snope,is_snoped,status,link_id,snoper,snopee',',');
	    	xlswrite('nodes_title',titles);
	    	r=1;
	    	x=[];
	    	for (i=1:self.nTrees)
	    		t=self.getTreeAt(i);
	    		for (j=1:t.nPosts)
	    			p=t.posts{j};
	    			x(r,1)=p.id;
	    			x(r,2)=p.index;
	    			x(r,3)=p.parentId;
	    			x(r,4)=p.isSnope;
	    			x(r,5)=p.isSnoped;
	    			status=p.getValue('status',data,attr);
	    			if (strcmp('a1',status))
	    				x(r,6)=1;
	    			elseif (strcmp('b1',status) && p.isSnope)
	    				x(r,6)=2.1;
	    			elseif (strcmp('b1',status) && ~p.isSnope)
	    				x(r,6)=2.2;
	    			elseif (strcmp('a2',status) && p.parent.isSnope)
	    				x(r,6)=3.1;
	    			% elseif (strcmp('a2',status) && ~p.parent.is_snope)
	    			else
	    				x(r,6)=3.2;
	    			end
	    			x(r,7)=t.link_id;
	    			x(r,8)=t.snoper;
	    			x(r,9)=t.snopee;
	    			r=r+1;
	    		end
	    	end
	    	xlswrite('nodes.xlsx',x);
	    end

	end

	
	
end