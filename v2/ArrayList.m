classdef ArrayList < handle
	properties
		s; % size
		items; % a cell array of item
	end

	methods
		function list=ArrayList()
			list.s=0;
			list.items={};
		end

		function add(self,item)
			n=self.s+1;
			self.items{n}=item;
			self.s=n;
		end

		function item=get(self,pos)
			item=self.items{pos};
		end

		function res=contains(self,item)
			for (i=1:self.s)
				if (item==self.items{i})
					res=true;
					return;
				end
			end
			res=false;
		end
		
	end
end