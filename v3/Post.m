classdef Post < handle
	properties
		id;
		index; % index
		parent; % parent object
		parentId;
		children; % array of children object
		isSnope;
		isSnoped;
		treeId;
		snopeid;
	end

	methods
		function p=Post(index,id,parentId,isSnoped,isSnope,snopeid)
			p.index=index;
			p.id=str2num(id);
			p.parentId=str2num(parentId);
			if (strcmp(isSnope,'TRUE'))
				p.isSnope=true;
			else 
				p.isSnope=false;
			end
			if (strcmp(isSnoped,'1'))	
				p.isSnoped=true;
			else
				p.isSnoped=false;
			end
			p.snopeid=snopeid;
			p.parent=-1;
			p.children=[];
			p.treeId=-1;
		end

		function v=getValue(self,key)
			% v=self.content.getValue(key);
			
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

		% function res=isSnope()
		% 	res=self.isSnoped;
		% end

		% function res=isSnoped();
		% 	res=self.isSnoped;
		% end

	end
end