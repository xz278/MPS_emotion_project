classdef PostTree < handle

	properties
		root; % root post object
		posts; % a cell of post objects
		depth; % double
		linkId; % from raw data in double 
		nPosts; % number of posts
	end

	methods
		function pt=PostTree(id)
			pt.linkId=id;
			pt.root=-1;
			pt.posts={};
			pt.depth=0;
			pt.nPosts=0;
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
		end
	end
end