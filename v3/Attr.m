%% a class to store the attibutes of raw data and
%% functions to look up specified attribute index
classdef Attr < handle
	properties
		attrmap; % map<attr_name, attr_index>;
	end

	methods
		function a=Attr(data)
			a.attrmap=data;
		end

		function i=getIndex(self,attr)
			i=self.attrmap.getValue(attr);
		end
	end
end