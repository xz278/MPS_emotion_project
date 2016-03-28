[~,~,DATA]=xlsread('unique_tree_nodes.xlsx');
[n,d]=size(DATA);

trees=PostTrees();
for (i=1:d)
	trees.addField(DATA{1,i});
end
for (i=2:n)
	post=Post();
	for (j=1:d)
		post.addContent(DATA{1,j},DATA{i,j});
	end
	trees.addPost(post);
end

trees.update();