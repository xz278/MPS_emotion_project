classdef Post < handle
	properties
		id; % unique id from raw data, in double
		parent; % parent post object
		children; % a cell array of children objects
		content; % a map<field title, filed value>
		isSnope;
		isSnoped;
	end

	methods
		function p=Post(id)
			p.id=id;
			p.content=Map();
			p.parent=-1;
			p.children={};
			p.isSnoped=false;
			p.isSnope=false;
		end

		function addContent(self,key,value)
			self.content.putItem(key,value);
		end

		function v=getValue(self,key)
			v=self.content.getValue(key);
		end
		
	end
end