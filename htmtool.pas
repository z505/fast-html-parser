unit htmtool; {$IFDEF FPC}{$MODE OBJFPC}{$H+}{$ENDIF}

interface

function IsTag(TagType: string; Tag: string): boolean;
function IsCloseTag(TagType: string; Tag: string): boolean;
function Substr(sub, s: string): boolean;
function StripTabs(s: string): string;
function ReturnsToSpaces(s: string): string;
function LessenSpaces(s: string): string;
function CleanHtm1(s: string): string;

implementation

uses
  sysutils;
{ strips tabs, lessens spaces, converts returns to spaces }

function CleanHtm1(s: string): string;
begin
  result:= s;
  result:= stripTabs(result);
  result:= ReturnsToSpaces(result);
  result:= LessenSpaces(result);
end;

{ strips double spaces into single spaces (recursively) }
function LessenSpaces(s: string): string;
var
  found: integer;
begin
  result:= '';
  result:= s;
  found:= 0;
  repeat
    result:= stringreplace(result, '  ', ' ', [rfReplaceAll]);
    found:= pos('  ', result);
  until found < 1;
end;

{ strips tabs }
function StripTabs(s: string): string;
const
  TABCHAR = #9;
begin
  result:= '';
  result:= stringreplace(s, TABCHAR, '', [rfReplaceAll]);
end;

{ strips returns but replaces them with spaces }
function ReturnsToSpaces(s: string): string;
const
  CR = #13;
  LF = #10;
begin
  result:= '';
  result:= s;
  result:= stringreplace(result, CR+LF, ' ', [rfReplaceAll]);
  result:= stringreplace(result, CR, ' ', [rfReplaceAll]);
  result:= stringreplace(result, LF, ' ', [rfReplaceAll]);
end;

// same as POS but returns boolean
function Substr(sub, s: string): boolean;
begin
  result:= false;
  if pos(sub, s) > 0 then result:= true;
end;

// is a '</TAG>'
function IsCloseTag(TagType: string; Tag: string): boolean;
begin
  result:= false;
  if uppercase(Tag) = '</'+ uppercase(TagType) +'>' then result:= true;
end;

// is a '<TAG>' or '<TAG '
function IsTag(TagType: string; Tag: string): boolean;
var
  TagUp: string;
  TypeUp: string;
begin
  result:= false;
  TagUp:= uppercase(Tag);
  TypeUp:= uppercase(TagType);
  if (pos('<'+ TypeUp+'>', TagUp) > 0) or
     (pos('<' +TypeUp+' ', TagUp) > 0)
  then
    result:= true;

end;

end.
 