%% return the combination of input cell arrays
%% @input is a cell array of cell arrays to be combined.
function res=combineCellArrays(input)
	n=size(input,2);
	s=size(input{1},2);
	res=input{1};
	for (i=2:n)
		for (j=1:size(input{i},2))
			s=s+1;
			res{s}=input{i}{j};
		end
	end
end