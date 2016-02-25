classdef TestTreeNode < handle
	properties
		value;
		parent;
		children; % a cell array of TestTreeNode
	end

	methods

		function t = TestTreeNode(v,p,c)
			if (nargin==3)
				t.value = v;
				t.parent = p;
				t.children = c;
			else
				t.value = v;
				t.parent = -1;
				t.children = {};
			end
		end

		function n = getParent(self)
			n = self.parent;
		end

		function n = getChildren(self)
			n = self.children;
		end

		function n = getChildrenNum(self)
			n = size(self.children,2);
		end

		function v = getValue(self)
			v = self.value;
		end

		function setParent(self,p)
			self.parent = p;
		end

		function addChild(self,c)
			n = self.getChildrenNum();
			for (i=1:size(c,2))
				n = n+1;
				self.children{n} = c{i};
				c{i}.setParent(self);
			end
		end

		function l = isLeaf(self)
			l = self.getChildrenNum()==0;
		end

		% function getLeafNum(self)
		% 	n = size(self.children);
		% 	if (n==0)
		% 	end
		% end

	end

	methods(Static)

		% function n = factor(x)
		% 	if (x==1)
		% 		n = 1
		% 	else
		% 		n = x*TestTreeNode.factor(x-1)
		% 	end
		% end


		function n = getLeafNum(node)
			nc = size(node.children,2);
			if (nc==0)
				n = 1;
			else
				c = 0;
				for (i=1:nc)
					c = c+TestTreeNode.getLeafNum(node.children{i});
				end
				n = c;
			end
		end

		function d = getDepth(node,pd)
			if (node.isLeaf())
				d = pd+1;
			else
				nc = node.getChildrenNum();
				t = 0;
				for (i=1:nc)
					m = TestTreeNode.getDepth(node.children{i},pd+1);
					if (m>t)
						t = m;
					end
				end
				d = t;
			end
		end


	end


end