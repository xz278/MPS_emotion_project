classdef SStack < handle
	properties
		items;
		s;
	end

	methods
		function s=SStack(item)
			if (nargin==0)
				s.items={};
				s.s=0;
			else
				s.items=item;
				s.s=size(item,2);
			end
		end

		function push(self,item)
			n=self.s+1;
			self.items{n}=item;
			self.s=n;
		end

		function i=pop(self)
			n=self.s;
			i=self.item{n};
			t={};
			for (i=1:n-1)
				t{i}=self.items{i};
			end
			self.items=t;
			self.s=n-1;
		end

		function res=isEmpty(self)
			res=self.s==0;
		end

		function s=getSize(self)
			s=self.s;
		end
	end



end