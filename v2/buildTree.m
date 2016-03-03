% build trees script

%-----------------------------------

trees=PostTrees();
lineLimit=500;


% ----------------------add field title-------------------------
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
trees.addFields(keys);
keysT=strsplit(l2,',');
trees.addFields(getArrayFrom(keysT,1,1));
keysT=strsplit(l3,',');
trees.addFields(getArrayFrom(keysT,2,2));
keysT=strsplit(l4,',');
trees.addFields(getArrayFrom(keysT,2,2));
keysT=strsplit(l5,',');
nScore=size(keysT,2);
trees.addFields(getArrayFrom(keysT,2,nScore));
keys=trees.fields.toArray();
% -------------------------------------------------------------

% ----------------------- add data ----------------------------
c=0;
l=fgetl(fid);
l2=fgetl(fid2);
l3=fgetl(fid3);
l4=fgetl(fid4);
l5=fgetl(fid5);
while (~feof(fid) && c<lineLimit)
% while (~feof(fid),'double'))
% b=1;
% while (b<14778)
% 	b+1;
% 	l=fgetl(fid);
% 	l2=fgetl(fid2);
% 	l3=fgetl(fid3);
% 	l4=fgetl(fid4);
% 	l5=fgetl(fid5);
% end

% while (~feof(fid))
	% b=b+1;
	% create Post node
	c=c+1;
	% values=strsplit(l,',');
	% keys
	values=combineCellArrays({...
							  strsplit(l,','),...
						      getArrayFrom(strsplit(l2,','),1,1),...
						      getArrayFrom(strsplit(l3,','),2,2),...
						      getArrayFrom(strsplit(l4,','),2,2),...
						      getArrayFrom(strsplit(l5,','),2,nScore)...
						      });
	% size(keys,2)
	% size(values,2)
	post=Post(keys,values);
	trees.addPost(post);
	l=fgetl(fid);
	l2=fgetl(fid2);
	l3=fgetl(fid3);
	l4=fgetl(fid4);
	l5=fgetl(fid5);
end
% fclose(fid);
%-----------------------------------------------------------------


trees.update();



fclose(fid);
fclose(fid2);
fclose(fid3);
fclose(fid4);
fclose(fid5);
%-----------------------------------------------------------------