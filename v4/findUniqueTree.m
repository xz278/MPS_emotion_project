
[~,~,data]=xlsread('raw_data.xlsx');



%----------- build tree table (link_id, snoppe_id)----------
[n,d]=size(data);
linkid=[];
snopeid={};
c=0;
for (i=2:n)
	if (i==n)
		if (~strcmp(data{i,24},data{i-1,24}))
			linkid=[linkid str2num(data{i,6})];
			c=c+1;
			snopeid{c}=data{i,24};
		end
	else
		if (~strcmp(data{i,24},data{i+1,24}))
			linkid=[linkid str2num(data{i,6})];
			c=c+1;
			snopeid{c}=data{i,24};
		end
	end
end






%----------------find unique tree--------------------
% linkid=zeros(1,n-1);
% for (i=2:n)
% 	linkid(i-1)=str2num(data{i,6});
% end


t=[];
[sorted,index]=sort(linkid);
sortedip={}
for (i=1:c)
	sortedip{i}=snopeid{index(i)};
end

[d,n]=size(sorted);
for (i=1:n)
	if (i==1)
		if (sorted(i)~=sorted(i+1))
			t=[t i];
		end
	elseif (i==n)
		if (sorted(i)~=sorted(i-1))
			t=[t i];
		end 
	else
		if (sorted(i)~=sorted(i-1) && sorted(i)~=sorted(i+1))
			t=[t i];
		end
	end
end

unique_linkid=sorted(t);
xlswrite('unique_linkid.xlsx',unique_linkid);

% ------------- extract node in unique link_id ----------------

[n,d]=size(data);
uniqeNode{1,1}='index';
for (i=1:d)
	uniqueNode{1,i+1}=data{1,i};
end
c=1
for (i=2:n)
	clinkid=str2num(data{i,6});
	if (sum(unique_linkid==clinkid)==1)
		c=c+1;
		uniqueNode{c,1}=i;
		for (j=1:d)
			uniqueNode{c,j+1}=data{i,j};
		end
	end
end

xlswrite('unique_nodes.xlsx',uniqueNode);

% -------------  build unique node matrix  ----------------------

[n,d]=size(uniqueNode);
unm=zeros(n,13); % unique node matrix: 
				 % 1-id, 2-parentid, 3-linkid, 4-is_snope, 5-is_snoped, 6-status{11,21,12},
				 % 7-affect, 8-posemo, 9-negemo, 10-anx, 11-anger, 12-sad, 13-posemo/affect
for (i=2:n)
	unm(i,1)=str2num(uniqueNode{i,2});
	unm(i,2)=str2num(uniqueNode{i,5});
	unm(i,3)=str2num(uniqueNode{i,7});
	if (strcmp('TRUE',uniqueNode{i,11})) t=1;
	else t=0;
	end
	unm(i,4)=t;
	if (strcmp('1',uniqueNode{i,12})) t=1;
	else t=0;
	end
	unm(i,5)=t;
	if (strcmp('a1',uniqueNode{i,13})) t=11;
	elseif (strcmp('b1',uniqueNode{i,13})) t=21;
	else t=12;
	end
	unm(i,6)=t;
	unm(i,7)=uniqueNode{i,55};
	unm(i,8)=uniqueNode{i,56};
	unm(i,9)=uniqueNode{i,57};
	unm(i,10)=uniqueNode{i,58};
	unm(i,11)=uniqueNode{i,59};
	unm(i,12)=uniqueNode{i,60};
	unm(i,13)=uniqueNode{i,56}/uniqueNode{i,55};
end
xlswrite('unique_nodes_matrix.xlsx',unm);

% -------------  build tree  ----------------------


trees={};
nT=0;

n=size(unique_linkid,2);
utm=unique_linkid'; % unique tree matrix
					% 1-linkid, 2-root's id, 3-depth, 4-breath_1, 5-b_2, 6-b_3, 7-#nodes
ftrees{1,1}='index'; % position w/r to utm
ftrees{1,2}='linkid';
ftrees{1,3}='snope_id';
ftrees{1,4}='root id';
for (i=1:n)
	nT=nT+1;
	clinkid=utm(i,1); % current link_id in work
	nodesPos=find(unm(:,3)==clinkid); % index of nodes of current link_id/position in unique node matrix
	nodesId=unm(nodesPos,1);
	[nNodes,~]=size(nodesPos);
	tempNodes={};
	root=0;
	for (j=1:nNodes)
		cNodePos=nodesPos(j);
		tempNode=Node(cNodePos,unm(cNodePos,1));
		tempNodes{j}=tempNode;
		% if (unm(cNodePos,5)==1) root=tempNode; % if this node is root, add to trees{}
		if (strcmp('a1',uniqueNode{cNodePos,13})) root=tempNode;
		end
	end
	if (strcmp(class(root),'double')) 
		nT=nT-1;
		utm(i,2)=0;
		continue;
	end
	trees{nT}=root;
	utm(i,2)=root.id;
	for (j=1:nNodes)
		parentid=unm(tempNodes{j}.pos,2);
		parentPos=find(nodesId==parentid);
		[p,~]=size(parentPos);
		if (p==0) continue
		end
		tempNodes{j}.parent=tempNodes{parentPos};
		tempNodes{parentPos}.addChild(tempNodes{j});
	end

	utm(i,3)=root.getDepth();
	utm(i,7)=nNodes;

	ftrees{nT+1,1}=i; % position w/r to utm
	ftrees{nT+1,2}=clinkid;
	ftrees{nT+1,3}=uniqueNode{root.pos,25};
	ftrees{nT+1,4}=root.id;

end

xlswrite('unique_tree_matrix.xlsx',utm);