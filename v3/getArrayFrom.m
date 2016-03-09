%% return the cell array @a at specified index defined by @s[tart] and @e[nd]
function res=getArrayFrom(a,s,e)
	n=size(a,2);
	if (s>n || e>n || s>e)
		fprintf('---------------- ERROR ---------------\n');
		fprintf('   Invalid index: getArrayFrom(a,s,e)\n');
		fprintf('         start at %d, end at %d, size: %d\n', s, e,n);
		fprintf('--------------------------------------\n');
		res=-1;
	else
		res={};
		m=0;
		for (i=s:e)
			m=m+1;
			res{m}=a{i};
		end
	end
end