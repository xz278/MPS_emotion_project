classdef Post < handle
	properties
		id; % unique id from raw data, in double
		parent; % parent post object
		children; % a cell array of children objects
		content; % a map<field title, filed value>
		isSnope;
		isSnoped;
		treeId; % snope id
		status;
	end

	methods
		function p=Post(a,b)
			if (nargin<1)
				p.id=-1;
				p.content=Map();
				p.parent=-1;
				p.children={};
				p.isSnoped=false;
				p.isSnope=false;
				p.treeId=-1;
				p.status='not found';
			elseif (nargin<2) % only one input, the input is post id
				p.id=a;
				p.content=Map();
				p.parent=-1;
				p.children={};
				p.isSnoped=false;
				p.isSnope=false;
				p.treeId=-1
			else
				p.content=Map();
				n=size(a,2);
				for (i=1:n)
					p.content.putItem(a{i},b{i});
				end
				p.id=str2num(p.content.getValue('id'));
				p.treeId=p.content.getValue('snope_id');
				p.parent=-1;
				p.children={};
				if (strcmp('TRUE',p.content.getValue('is_snope')))
					p.isSnope=true;
				else 
					p.isSnope=false;
				end
				if (strcmp('1',p.content.getValue('is_snoped')))
					p.isSnoped=true;
				else
					p.isSnoped=false;
				end
				p.status=p.content.getValue('status');
			end
		end


		function addContent(self,key,value)
			% n=size(key,2);
			% for (i=1:n)
			% 	self.content.putItem(key{i},value{i});
			% end
			self.content.putItem(key,value);
			if (strcmp(key,'id'))
				self.id=value;
			end
			if (strcmp(key,'snope_id'))
				self.treeId=value;
			end
			if (strcmp(key,'is_snope') && value==1)
				self.isSnope=true;
			end
			if (strcmp(key,'is_snoped') && value==1)
				self.isSnoped=true;
			end
			if (strcmp(key,'status'))
				self.status=value;
			end
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

	end
end