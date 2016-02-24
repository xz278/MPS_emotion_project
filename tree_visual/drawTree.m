% draw tree with root, starts at (x,y)
% w: horizontal distance between nodes
% h: vertical distance between nodes
% r: radius of node
% w,h > 2r
function drawTree(root,color,x,y,w,h,r)
	if (root.isLeaf()) % if node is leaf
		drawTreeNode(x,y,r,color);
		pause();
		return;
	else
		% calculate start and end location
		nl = TestTreeNode.getLeafNum(root) % number of children/ whether is leaf
		width = nl*w;
		startX = x-width/2;
		nc = root.getChildrenNum();
		% weights = zeros(1,nc);
		for (i=1:nc)
			% weights[i] = root.children{i}.getChildrenNum()*w;
			node = root.children{i};
			% weight = nc*w;
			weight = TestTreeNode.getLeafNum(node)*w;
			xx = startX+weight/2;
			fprintf('drawing line');
			pause();
			plot([xx,x],[y-h,y],'color','k');
			pause();
			drawTree(node,color,xx,y-h,w,h,r);
			startX = startX+weight;
		end
		drawTreeNode(x,y,r,color);
end