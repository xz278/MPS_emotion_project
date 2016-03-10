classdef Post < handle
	properties
		id;
		index; % index
		parent; % parent object
		parentId;
		children; % array of children object
		isSnope;
		isSnoped;
		snopeid;
	end

	methods
		function p=Post(index)
			p.id=-1;
			p.index=index;
			p.parent=-1;
			p.parentId-1;
			p.children={};
			p.isSnope=false;
			p.isSnoped=false;
			p.snopeid=-1;
		end


		function v=getValue(self,key,data,attr)
			v=data{self.index,attr.getIndex(key)};
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
	end
end