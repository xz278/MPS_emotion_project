function drawCircle(x,y,r,c)
	rectangle('Position',[x,y,r,r],'Curvature',[1 1],...
				'FaceColor',c,'EdgeColor','k');
end