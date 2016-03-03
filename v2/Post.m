classdef Post < handle
	properties
		id; % unique id from raw data, in double
		parent; % parent post object
		children; % a cell array of children objects
		content; % a map<field title, filed value>
		isSnope;
		isSnoped;
		treeId;
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
				p.treeId=-1
			elseif (nargin<2)
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
				p.treeId=str2num(p.content.getValue('link_id'));
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
			end
		end

		function addContent(self,key,value)
			n=size(key,2);
			for (i=1:n)
				self.content.putItem(key{i},value{i});
			end
		end

		function v=getValue(self,key)
			v=self.content.getValue(key);
		end

	end
end