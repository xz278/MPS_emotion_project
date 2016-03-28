classdef Node < handle
	properties
		pos; % index w/r the pos in unique node matrix and unique_nodes.xlsx file
		id; % id given in raw data
		parent; % pointer to its parent node
		children; % a cell array of pointers to its children nodes
	end


	methods
		function n=Node(pos,id)
			n.pos=pos;
			n.id=id;
			n.parent=0;
			n.children={};
		end

		function addChild(self,c)
			n=size(self.children,2);
			self.children{n+1}=c;
		end

		function d=getDepth(self)
			d=0;
			q=SQueue();
			q.offer(self);
			while (~q.isEmpty())
				d=d+1;
				s=q.getSize();
				for (i=1:s)
					n=q.poll();
					children=n.children;
					l=size(children);
					for (j=1:l)
						q.offer(children{j});
					end
				end
			end
		end
	end




end