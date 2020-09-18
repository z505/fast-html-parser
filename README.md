# Fast HTML Parser
HTML Parser for FreePascal and Delphi originally written by Jazarsoft.

* Modified for use as a pure command line unit (no dialogs) for FreePascal.
* Also added UPPERCASE tags so that when you check for i.e. `<font>` it returns
  all tags like `<FONT>` and `<FoNt>` and `<font>`.

## Versions
Revision 18 is Version 1 of this tool

After revision 18 version 2 of the tool is being worked on with more object methods to access
elements by Name or ID for example just like a DOM.

## Todo
* keep the entire HTML file in an array for later usage: htmltags[] and text[]
* parse like this: OnSection(opentag, text, closetag); as a different parser
  kind so that globals are not needed to keep track of InTag booleans, etc.
  so that all are together, tag, text, closing tag, in the same procedure
* associate a number (open tag) with the text label using a record or such
  i.e. `<body><b>some text</b></body>`
  where `<b>` is tag "2" and some text is text "1"
* turn into a DLL using FPC or C so that other languages can use a callback
  to parse html fast in that language (i.e. Go, Python, etc.)

Use this parser for what reasons:
* make your own web browsers,
* make your own text copies of web pages for caching purposes
* Grab content from websites **without** using regular expressions
* Seems to be **much much faster** than regular expressions, as it is after all
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
