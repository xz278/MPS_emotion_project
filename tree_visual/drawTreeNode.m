% draw the node at location (x,y) in specified color c and radius r.
function drawTreeNode(x,y,r,c,lineColor,lineWidth)
	if (nargin<=4)
		if (nargin<4)
			c = 'w';
		end
		% rectangle('Position',[x,y,r,r],'Curvature',[1 1],'FaceColor',c,...
		% 			'EdgeColor','k');
		drawCircle(x-r,y-r,2*r,c);
	else
		drawCircle(x-r,y-r,2*r,c,lineColor,lineWidth);
	end
end
