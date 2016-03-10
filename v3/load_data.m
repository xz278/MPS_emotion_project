%% scripts to load data from raw_data.xlsx in raw form (a cell array)
% ----------------------- load data --------------------------
fileName='raw_data.xlsx';
[~,~,data]=xlsread(fileName);
[n,d]=size(data);
attrT=Map();
% -----------create attributes and corresponding index -------
for (i=1:d)
	attrT.putItem(data{1,i},i);
end
attr=Attr(attrT);
% ---------------------- create node -------------------------
trees=PostTrees();
for (i=2:n)
	post=Post(i,...
			  data{i,attr.getIndex('id')},...
			  data{i,attr.getIndex('parent_id')},...
			  data{i,attr.getIndex('is_snoped')},...
			  data{i,attr.getIndex('is_snope')},...
			  data{i,attr.getIndex('snope_id')}...
			  );
	% add node to a tree
	if (trees.contains(post.))

end
