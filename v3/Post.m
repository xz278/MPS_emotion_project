classdef Post < handle
	properties
		id;
		index; % index
		parent; % parent object
		children; % array of children object
		isSnope;
		isSnoped;
		treeId;
		snopeid;
	end

	methods
		function p=Post(index,id,parentIndex,isSnoped,isSnope,snopeid)
			p.index=index;
			p.id=id;
			p.isSnoped=isSnoped;
			p.isSnope=isSnope;
			p.snopeid=snopeid;
			p.parent=-1;
			p.children=[];
			p.treeId=-1;
		end

		function v=getValue(self,key)
			v=self.content.getValue(key);
		end

		function addChild(self,c)
			n=size(self.children,2);
			n=n+1;
			self.children{n}=c;
		end

		function n=getChildrenNum(self)
			n=size(self.children,2);
		end

		function res=isLeaf(self)
			res=self.getChildrenNum==0;
		end

		function res=isRoot(self)
			res=self.isSnoped;
		end

		function res=isSnope()
			res=self.isSnoped;
		end

		function res=isSnoped();
			res=self.isSnoped;
		end

	end
end