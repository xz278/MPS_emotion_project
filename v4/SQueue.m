classdef SQueue < handle
	properties
		items;
		s;
	end

	methods
		function s=SQueue(item)
			if (nargin==0)
				s.items={};
				s.s=0;
			else
				s.items=item;
				s.s=size(item,2);
			end
		end

		function offer(self,item)
			n=self.s+1;
			self.items{n}=item;
			self.s=n;
		end

		function res=poll(self)
			n=self.s;
			res=self.items{1};
			t={};
			for (i=2:n)
				t{i-1}=self.items{i};
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