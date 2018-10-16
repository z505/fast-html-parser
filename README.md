# Fast HTML Parser
HTML Parser for FPC and Delphi originally written by Jazarsoft

* Modified for use as a pure command line unit (no dialogs) for freepascal.
* Also added UPPERCASE tags so that when you check for i.e. <font> it returns
  all tags like <FONT> and <FoNt> and <font>

TODO:
* keep the entire HTML file in an array for later usage: htmltags[] and text[]
* parse like this: OnSection(opentag, text, closetag); as a different parser 
  kind so that globals are not needed to keep track of InTag booleans, etc.

Use this parser for what reasons:
* make your own web browsers,
* make your own text copies of web pages for caching purposes
* Grab content from websites -without- using regular expressions
* Seems to be MUCH MUCH FASTER than regular expressions, as it is after all
  a true parser
* convert website tables into spreadsheets (parse TD and TR, turn in to
  CSV or similar)
* convert websites into txt files
* convert website tables into CSV/Database (parse TD and TR)
* find certain info from a web page.. i.e. all the bold text or hyperlinks in
  a page.
* Parse websites remotely from a CGI app using something like Sockets or
  Synapse and SynWrap to first get the HTML site. This would allow you to
  dynamically parse info from websites and display data on your site in real
  time.
* HTML editor.. WYSIWYG or a partial WYSIWYG editor. Ambitious, but possible.
* HTML property editor. Not completely wysiwyg but ability to edit proprties
  of tags. Work would need to be done to parse each property in a tag.


