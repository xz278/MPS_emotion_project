%% write trees to xls files
% input is a PostTrees object
function writeTreesToFile(trees,fileName)
	n=trees.nTrees;
	x={};
	x{1,1}='snope_id';
	x{1,2}='size';
	x{1,3}='depth';
	x{1,4}='breadth at 2';
	x{1,5}='breadth at 3';
	for (i=1:n)
		x{i+1,1}=trees.getTreeAt(i).snopeid;
		x{i+1,2}=trees.getTreeAt(i).getSize();
		x{i+1,3}=trees.getTreeAt(i).getDepth();
		x{i+1,4}=trees.getTreeAt(i).breadths(2);
		x{i+1,5}=trees.getTreeAt(i).breadths(3);
	end
	xlswrite(fileName,x);
end