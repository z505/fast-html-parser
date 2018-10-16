{ Demo for fast html parser

  Try arrays }

program project1;

{$mode objfpc}{$H+}

uses
  fasthtmlparser, // html parser
  arrhtmlparser,  // same as fasthtmlparser but stores all tags/text in an array for later use
  sysutils;

const
  HTMStringA = '<html><head></head><body><p>some text</p> <b>text in bold tag</b> more text <p><b>more bold</b></p> and the end of html</body></html>';
var
  InBold: boolean = false;

procedure msg(s: string);
begin writeln(s);
end;

procedure msg(s1,s2: string);
begin writeln(s1,s2);
end;

procedure msg(s1: string; i: integer);
begin writeln(s1,i);
end;


//  TOnFoundTagP = procedure(NoCaseTag, ActualTag: string);
//  TOnFoundTextP = procedure(Text: string);

procedure ExOnTag(NoCaseTag, ActualTag: string);
begin
  if NoCaseTag = '<B>' then begin
    InBold := true;
    msg('bold start');
  end;

  if NoCaseTag = '</B>' then begin
    InBold := false;
    msg('bold end');
  end;
end;

procedure ExOnText(Text: string);
begin
  if InBold then begin
    msg('Text tag: ', Text);
  end;
end;

procedure Example1;
var
  hp: THTMLParser;
begin
  hp := THTMLParser.create(HTMStringA);
  hp.OnFoundTagP := @ExOnTag;
  hp.OnFoundTextP := @ExOnText;
  hp.Exec;
  hp.free; hp := nil;
end;

procedure Example2;
var
  ahp: TArrHTMLParser;
  i: integer;
begin
  ahp := TArrHTMLParser.create(HTMStringA);
  ahp.OnFoundTagP := @ExOnTag;
  ahp.OnFoundTextP := @ExOnText;
  ahp.Exec;
  msg('Printing all tag items:');
  msg('Length of Tags array: ',length(ahp.Tags));
  // print out all tags in array
  for i := low(ahp.Tags) to high(ahp.Tags) do begin
    writeln(i,':',ahp.Tags[i]);
  end;
  msg('Printing all text items:');
  msg('Length of Texts array: ', length(ahp.Texts));
  // print out all texts in array
  for i := low(ahp.Texts) to high(ahp.Texts) do begin
    writeln(i,':',ahp.Texts[i]);
  end;
  ahp.free; ahp := nil;
end;

procedure Line;
begin writeln('-----------------------------------------------');
end;

begin
  Example1;
  Line;
  Example2;
  Line;
  ReadLn; // pause program on exit for <enter> to quit
end.

