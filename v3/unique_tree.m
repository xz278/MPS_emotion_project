% scripts to find unique tree
% name of data: trees2
[n,d]=size(trees2);
uniqueTree={};
c=0;
for (i=2:n)
	if (trees2{i,10}==1)
		c=c+1;
		for (j=1:d)
			uniqueTree{c,j}=trees2{i,j};
		end
	end
end