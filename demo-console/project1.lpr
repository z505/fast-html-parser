{ Demo for fast html parser

  Try arrays }

program project1;

{$mode objfpc}{$H+}

uses
  fasthtmlparser,
  sysutils;

const
  HTMString1 = '<html><head></head><p>some text</p> <b>text in bold tag</b> more text <p><b>more bold</b></p> and the end of html</html>';
var
  InBold: boolean = false;

procedure msg(s: string);
begin writeln(s);
end;

procedure msg(s1,s2: string);
begin writeln(s1,s2);
end;

//  TOnFoundTagP = procedure(NoCaseTag, ActualTag: string);
//  TOnFoundTextP = procedure(Text: string);

procedure Ex1OnTag(NoCaseTag, ActualTag: string);
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

procedure Ex1OnText(Text: string);
begin
  if InBold then begin
    msg('Text tag: ', Text);
  end;
end;

procedure Example1;
var
  hp: THTMLParser;
begin
  hp := THTMLParser.create(HTMString1);
  hp.OnFoundTagP := @Ex1OnTag;
  hp.OnFoundTextP := @Ex1OnText;
  hp.Exec;
  hp.free; hp := nil;
end;

begin
  Example1;
  ReadLn; // pause program on exit for <enter> to quit
end.

