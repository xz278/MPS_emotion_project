%% data in formated needed for Drew to carry out quantile analysis
%% Input is a trees object, fileNmae, and attribute
function printData(fileName,trees,attr)
	X={};
	X{1,1}='snope_id';
	X{1,2}='a1';
	X{1,3}='b1_snope_&_replied';
	X{1,4}='count';
	X{1,5}='b1_snope_&_not_replied';
	X{1,6}='count';
	X{1,7}='b1_not_snope_&_replied';
	X{1,8}='count';
	X{1,9}='b1_not_snope_&_not_replied';
	X{1,10}='count';
	X{1,11}='a2_reply_to_snope';
	X{1,12}='count';
	X{1,13}='a2_not_reply_to_snope';
	X{1,14}='count';

	nTrees=trees.nTrees;
	ts=trees.trees.values;
	for (i=1:nTrees)
		t=ts{i};
		nPosts=t.nPosts;
		X{i+1,1}=t.snopeid;
		a=[];
		b=[];
		c=[];
		d=[];
		e=[];
		f=[];
		for (j=1:nPosts)
			p=t.posts{j};
			value=p.getValue(attr);
			if (size(p.children,2)==0) 
				replied=0;
			else
				replied=1;
			end
			if (strcmp(p.status,'a1'))
				X{i+1,2}=value;
				continue;
			end
			if (strcmp(p.status,'a2'))
				if (p.parent.isSnope==1)
					e=[e value];
				else
					f=[f value];
				end
				continue;
			end
			if (strcmp(p.status,'b1'))
				if (p.isSnope==1)
					if (replied==1)
						a=[a value];
					else
						b=[b value];
					end
					continue;
				else
					if (replied==1)
						c=[c value];
					else
						d=[d value];
					end
					continue;
				end
			end
		end
		X{i+1,3}=mean(a);
		X{i+1,4}=size(a,2);
		X{i+1,5}=mean(b);
		X{i+1,6}=size(b,2);
		X{i+1,7}=mean(c);
		X{i+1,8}=size(c,2);
		X{i+1,9}=mean(d);
		X{i+1,10}=size(d,2);
		X{i+1,11}=mean(e);
		X{i+1,12}=size(e,2);
		X{i+1,13}=mean(f);
		X{i+1,14}=size(f,2);
	end

	xlswrite(fileName,X);

end