%% return the titles from raw data
%% @var titles is a cell array
function titles = getTitles(fileName)
  fid = fopen(fileName);
  line = fgetl(fid);
  titles = strsplit(line,',');
  fclose(fid);
 end