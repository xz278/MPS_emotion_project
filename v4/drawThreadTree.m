% draw tree with root, starts at (x,y)
% w: horizontal distance between nodes
% h: vertical distance between nodes
% r: radius of node
% w,h > 2r
function drawThreadTree(data,attr,root,showSnope,lineWidth,color,x,y,w,h,r,txt,hl,score)
	clr = color;
	if (strcmp(class(hl),'double') && hl==0)
		% do nothing
	else
		args = strsplit(hl,',');
		if (strcmp(args{2},data{root.index,attr.getIndex(args{1})}))
			clr = [15 111 232]./255;
		end
	end

	% color the node based on its value
	% if (strcmp('char',class(score)))
	% 	sc=str2num(root.getValue(score));
	% 	clr=[0 0 sc/100];
	% end


	if (root.isLeaf()) % if node is leaf
		if (showSnope && root.isSnope())
			drawTreeNode(x,y,r,clr,'r',lineWidth);
		else
			drawTreeNode(x,y,r,clr);
		end
		% return;
	else
		% calculate start and end location
		nl = PostTree.getLeafNum(root); % number of children/ whether is leaf
		width = nl*w;
		startX = x-width/2;
		nc = root.getChildrenNum();
		% weights = zeros(1,nc);
		for (i=1:nc)
			% weights[i] = root.children{i}.getChildrenNum()*w;
			% node = root.children{i};
			node = root.children{i};
			% weight = TestTreeNode.getLeafNum(node)*w;
			weight = PostTree.getLeafNum(node)*w;
			xx = startX+weight/2;
			plot([xx,x],[y-h,y],'color','k');
			drawThreadTree(data,attr,node,showSnope,lineWidth,color,xx,y-h,w,h,r,txt,hl,score);
			startX = startX+weight;
		end
		if (showSnope && root.isSnope())
			drawTreeNode(x,y,r,clr,'r',lineWidth);
		else
			drawTreeNode(x,y,r,clr);
		end
	end

	% text(x,y,...
	% 	num2str(root.nodeId),...
	% 	'Color', 'w',...
	% 	'HorizontalAlignment','center',...
	% 	'FontSize',10);


	if (strcmp(class(txt),'double') && txt==0)
		return;
	end
		
	textToShow=data{root.index,attr.getIndex(txt)};

	text(x,y-1.3*r,...
		textToShow, ...
		'Color','k',...
		'FontSize',9, ...
		'HorizontalAlignment','center');

end