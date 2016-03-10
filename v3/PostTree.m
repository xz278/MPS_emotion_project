classdef PostTree < handle

	properties
		root; % root post object
		posts; % a cell of post objects
		depth; % double
		% snopeid; % from raw data in double
		snopeid; 
		nPosts; % number of posts
		ids; % a array of ids
		breadths;
	end

	methods
		function pt=PostTree(id)
			pt.snopeid=id;
			pt.root=-1;
			pt.posts={};
			pt.depth=0;
			pt.nPosts=0;
			pt.ids=[];
		end

		% add post object to tree object
		function addPost(self,post)
			if (~strcmp(class(post),'Post'))
				fprintf('ERROR!: input arg for addPost has to be Post object');
				return;
			end
			n=self.nPosts+1;
			self.posts{n}=post;
			self.nPosts=n;
			self.ids(n)=post.id;
		end

		function s=getSize(self)
			s=self.nPosts;
		end

		function d=getDepth(self)
			d=self.depth;
		end

		function id=getId(self)
			id=self.snopeid;
		end

		function update(self)
			% fprintf('tree_id: %s\n',num2str(self.snopeid));
			% find root
			c=1;
			found=false;
			while (c<=self.nPosts && ~found)
				if (self.posts{c}.isSnoped)
					found=true;
					self.root=self.posts{c};
				end
				c=c+1;
			end

			% build tree strucutre
			for (i=1:self.nPosts)
				pid=self.posts{i}.parentId;
				index=find(self.ids==pid);
				if (size(index,2)==0)
					self.posts{i}.parent=0;
				else
					self.posts{i}.parent=self.posts{index};
					self.posts{index}.addChild(self.posts{i});
				end
			end

			[self.depth,self.breadths]=self.computeDepthAndBreadths();

		end

		function [d,b]=computeDepthAndBreadths(self)
			if (strcmp(class(self.root),'double'))
				d=0;
				b=[0 0 0];
				fprintf('null tree root\n');
				fprintf('	tree_id: %s\n', num2str(self.snopeid));
				return;
			end
			q=SQueue();
			q.offer(self.root);
			d=0;
			b=[];
			c=0;
			while (~q.isEmpty())
				s=q.getSize();
				d=d+1;
				c=c+1;
				b(c)=s;
				for (i=1:s)
					node=q.poll();
					children=node.children;
					for (j=1:node.getChildrenNum())
						q.offer(children{j});
					end
				end
			end

		end

    function draw(self,showSnope,lineWidth,arg1,arg2,arg3,arg4)
    	  if (strcmp(class(self.root),'double'))
    	  		fprintf('No root/snopee/a1 found: %s\n',self.snopeid);
    	  		return;
    	  end
	      txt = 0;
	      hl = 0;
	      score = 0;
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
	          elseif (strcmp(arg1,'score'))
	          	score = arg2;
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
	      drawThreadTree(self.root,showSnope,lineWidth,[0.7 0.7 0.7],0,0,1,1,0.2,txt,hl,score);
	    end

	    function b=getBreadthAt(self,d)
	    	b=self.breadths(d);
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
            m = Post.computeDepth(node.children{i},pd+1);
            if (m>t)
              t = m;
            end
          end
          d = t;
        end
      end

    function n = getLeafNum(node)   
      if (node.isLeaf())
        n = 1;
      else
        c = 0;
        for (i=1:node.getChildrenNum())
          c = c+PostTree.getLeafNum(node.children{i});
        end
        n = c;
      end
    end

	end
end