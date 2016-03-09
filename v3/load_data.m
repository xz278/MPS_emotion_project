%% scripts to load data from raw_data.xlsx in raw form (a cell array)
% ----------------------- load data --------------------------
fileName='raw_data.xlsx';
[~,~,data]=xlsread(fileName);
[n,d]=size(data);
attrT=Map();
% -----------create attributes and corresponding index -------
for (i=1:d)
	attrT.add(data{1,i},i);
end
attr=Attr(attrT);
% ---------------------- create node -------------------------

for (i=2:n)
	post=Post(i,...
			  data{i,attr.getIndex('id')},...
			  data{i,attr.getIndex('')}
			  )
end
