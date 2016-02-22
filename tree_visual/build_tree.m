% scripts to buid a tread tree

fileName = 'Raw_data_snoped_post_and_replies.csv';
bodyFile = 'body.csv';
quoteFile = 'quote.csv';
bodyNoQuoteFile = 'body_without_quote.csv';
  
%tree = ThreadTree(fileName, bodyFile, quoteFile, bodyNoQuoteFile);
trees = ThreadTrees(fileName, bodyFile, quoteFile, bodyNoQuoteFile);