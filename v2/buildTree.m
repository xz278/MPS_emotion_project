% build trees script

%-----------------------------------

trees=PostTrees();
lineLimit=3;


% ----------------------add basic data-------------------------
fid=fopen('post_data.csv');
% add titles
l=fgetl(fid);
keys=strsplit(l,',');
trees.addFields(keys);
% build tree
c=0;
l=fgetl(fid);
while (~strcmp(class(l),'double') && c<lineLimit)
% while (~strcmp(class(l),'double'))
	% create Post node
	c=c+1;
	values=strsplit(l,',');
	post=Post(keys,values);
	trees.addPost(post);
	l=fgetl(fid);
end
fclose(fid);
%-----------------------------------------------------------------

% ----------------------add basic data-------------------------
fid=fopen('post_data.csv');
% add titles
l=fgetl(fid);
keys=strsplit(l,',');
trees.addFields(keys);
% build tree
c=0;
l=fgetl(fid);
while (~strcmp(class(l),'double') && c<lineLimit)
% while (~strcmp(class(l),'double'))
	% create Post node
	c=c+1;
	values=strsplit(l,',');
	post=Post(keys,values);
	trees.addPost(post);
	l=fgetl(fid);
end
fclose(fid);
%-----------------------------------------------------------------

% ----------------------add text(body,quote) data-----------------
fid=fopen('post_data.csv');
fid2=fopen('post_body.csv');
fid3=fopen('post_bodyNQ.csv');
fid4=fopen('post_quote.csv');
fid5=fopen('post_scores.csv');
% add titles
l=fgetl(fid);
l2=fgetl(fid2);
l3=fgetl(fid3);
l4=fgetl(fid4);
l5=fgetl(fid5);
keys=strsplit(l,',');
% trees.addFields(keys);
% keys=strsplit(l2,',');
% trees.addFields(keys);
% keys=strsplit(l3,',');
% trees.addFields(keys);
% keys=strsplit(l4,',');
% trees.addFields(keys);
% keys=strsplit(l5,',');
% trees.addFields(keys);
% build tree
c=0;
l=fgetl(fid);
l2=fgetl(fid2);
l3=fgetl(fid3);
l4=fgetl(fid4);
l5=fgetl(fid5);
while (~strcmp(class(l),'double') && c<lineLimit)
% while (~strcmp(class(l),'double'))
	% create Post node
	c=c+1;
	% values=combineCellArrays({strsplit(l,','),...
	% 					      strsplit(l2,','),...
	% 					      strsplit(l3,','),...
	% 					      strsplit(l4,','),...
	% 					      strsplit(l5,',')});
	% size(trees.fields,2)
	% size(values,2)
	values=strsplit(l,',');
	post=Post(keys,values);




	trees.addPost(post);
	l=fgetl(fid);
end
fclose(fid);
%-----------------------------------------------------------------