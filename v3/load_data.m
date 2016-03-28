%% scripts to load data from raw_data.xlsx in raw form (a cell array)
% clear attrT;
% clear ATTR;
% clear trees;



% ----------------------- load data --------------------------
fileName='raw_data.xlsx';
% fileName='raw_data_test.xlsx';
global DATA;
[~,~,DATA]=xlsread(fileName);
[n,d]=size(DATA);
attrT=Map();
% -----------create attributes and corresponding index -------
for (i=1:d)
	attrT.putItem(DATA{1,i},i);
end
global ATTR;
ATTR=Attr(attrT);
% ---------------------- create node -------------------------
trees=PostTrees();
for (i=2:n)
	post=Post(i);
	post.id=str2num(DATA{i,ATTR.getIndex('id')});
	post.parentId=str2num(DATA{i,ATTR.getIndex('parent_id')});
	issnope2=strcmp(DATA{i,ATTR.getIndex('is_snope')},'TRUE');
	post.isSnope=issnope2;
	issnoped2=~strcmp(DATA{i,ATTR.getIndex('is_snoped')},'0');
	post.isSnoped=issnoped2;
	post.snopeid=DATA{i,ATTR.getIndex('snope_id')};
	trees.addPost(post);
end

trees.update(DATA,ATTR);

% SCORES=xlsread('scores.xlsx');
% [~,~,SCORES_TITLE]=xlsread('scores_title.xlsx');
