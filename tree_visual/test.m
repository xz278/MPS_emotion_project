# test scripts
fid = fopen('Raw_data_snoped_post_and_replies.csv');
fbody = fopen('body.csv');
fquote = fopen('quote.csv');
fbodyNoQuote = fopen('body_without_quote.csv');
bodyL = fgetl(fbody);
quoteL = fgetl(fquote);
bodyNoQuoteL = fgetl(fbodyNoQuote);
bodyL = fgetl(fbody);
quoteL = fgetl(fquote);
bodyNoQuoteL = fgetl(fbodyNoQuote);
line = fgetl(fid);
line = fgetl(fid);
title = getTitles('Raw_data_snoped_post_and_replies.csv');
node = ThreadNode(line,title,1,bodyL,quoteL,bodyNoQuoteL);



fclose(fbody);
fclose(fbodyNoQuote);
fclose(fquote);
fclose(fid);