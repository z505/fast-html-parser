{ modified from jsFastHtmlParser  for use with freepascal 
  
 Original Author:
  James Azarja

 Contributor:
  Lars aka L505
  http://z505.com }
  
unit HTMLUtil; {$ifdef fpc} {$MODE OBJFPC} {$H+}{$endif}

interface

{ most commonly used }
function GetVal(const tag, attribname_ci: string): string;
function GetTagName(const Tag: string): string;
function GetUpTagName(const tag: string): string;

{ less commonly used, but useful }
function GetNameValPair(const tag, attribname_ci: string): string;
function GetValFromNameVal(const namevalpair: string): string;

{ rarely needed nAmE= case sensitivity }
function GetNameValPair_cs(const tag, attribname: string): string;

{ old code with bugs from James }
function GetVal_JAMES(const tag, attribname_ci: string): string;
function GetNameValPair_JAMES(const tag, attribname_ci: string): string;

{ other utilities }
function CopyBuffer(StartIndex: PChar; Len: integer): string;
function Ucase(s: string): string;

implementation

// Note: use sysutils if you have problems with your Win64/other platform 
uses 
  {$IFDEF FPC}CompactSysUtils{$ELSE}Sysutils{$ENDIF};

function CopyBuffer(StartIndex: PChar; Len: integer): string;
var s : String;
begin
  SetLength(s, Len);
  StrLCopy(@s[1], StartIndex, Len);
  result:= s;
end;

{ upper case }
function Ucase(s: string): string;
begin
 {$IFDEF FPC}result:= upcase(s);{$ELSE}result:= uppercase(s);{$ENDIF}
end;

{ return value of attrib, NAME case ignored, VALUE case preserved } 
function GetVal(const tag, attribname_ci: string): string;
var nameval: string;
begin
  result:= '';
  if tag = '' then exit;
  if attribname_ci = '' then exit;
  // returns full name=value pair
  nameval:= GetNameValPair(tag, attribname_ci);
  // extracts value portion only
  result:= GetValFromNameVal(nameval);
end;

{ Return tag name, case preserved }
function GetTagName(const tag: string): string;
var
  P : Pchar;
  S : Pchar;
begin
  P := Pchar(tag);
  while P^ in ['<',' ',#9] do inc(P);
  S := P;
  while Not (P^ in [' ','>',#0]) do inc(P);
  if P > S then
    Result := CopyBuffer( S, P-S);
end;

{ Return tag name in uppercase }
function GetUpTagName(const tag: string): string;
var
  P : Pchar;
  S : Pchar;
begin
  result:= '';
  if tag = '' then exit;
  P := Pchar(Ucase(tag));
  while P^ in ['<',' ',#9] do inc(P);
  S := P;
  while Not (P^ in [' ','>',#0]) do inc(P);
  if P > S then
    Result := CopyBuffer( S, P-S);
end;


{ Return name=value pair ignore case of NAME, preserve case of VALUE
  Lars' fixed version }
function GetNameValPair(const tag, attribname_ci: string): string;
var
  P    : Pchar;
  S    : Pchar;
  UpperTag,
  UpperAttrib   : string;
  Start: integer;
  L    : integer;
  C    : char;
begin
  result:= '';
  if tag = '' then exit;
  if attribname_ci = '' then exit;
  // must be space before case insensitive NAME, i.e. <a HREF= STYLE=
  UpperAttrib:= ' ' + Ucase(attribname_ci);
  UpperTag:= Ucase(Tag);
  P:= Pchar(UpperTag);
  S:= StrPos(P, Pchar(UpperAttrib));

  if S <> nil then
  begin
    inc(S); // skip space
    P:= S;

    // Skip until hopefully equal sign
    while not (P^ in ['=', ' ', '>', #0]) do
      inc(P);

    if (P^ = '=') then inc(P);
    
    while not (P^ in [' ','>',#0]) do
    begin
      if (P^ in ['"','''']) then
      begin
        C:= P^;
        inc(P); { Skip quote }
      end else
        C:= ' ';

      { thanks to Dmitry [mail@vader.ru] }
      while not (P^ in [C, '>', #0]) do
        Inc(P);

      if (P^ <> '>') then inc(P); { Skip current character, except '>' }

      break;
    end;

    L:= P - S;
    Start:= S - Pchar(UpperTag);
    P:= Pchar(Tag);
    S:= P;
    inc(S, Start);
 
    result:= CopyBuffer(S, L);
  end;
end;

{ Get value of attribute, e.g WIDTH=36 returns 36, preserves case of value }
function GetValFromNameVal(const namevalpair: string): string;
var
  P: Pchar;
  S: Pchar;
  C: Char;
begin
  result:= '';
  if namevalpair = '' then exit;
  P:= Pchar(namevalpair);
  S:= StrPos(P, '=');

  if S <> nil then     
  begin
    inc(S); // skip equal
    P:= S;  // set P to a character after =

    if (P^ in ['"','''']) then
    begin
      C:= P^;
      Inc(P); { Skip current character }
    end else
      C:= ' ';

    S:= P;
    while not (P^ in [C, #0]) do
      inc(P);

    if (P <> S) then { Thanks to Dave Keighan (keighand@yahoo.com) }
      Result:= CopyBuffer(S, P - S) 
    else
      Result:= '';
  end;
end;

{ return name=value portion, case sensitive, case preserved, rarely useful }
function GetNameValPair_cs(const Tag, attribname: string): string;
var
  P    : Pchar;
  S    : Pchar;
  C    : Char;
begin
  result:= '';
  if tag = '' then exit;
  if attribname = '' then exit;
  P := Pchar(Tag);
  S := StrPos(P, Pchar(attribname));
  if S<>nil then
  begin
    P := S;

    // Skip attribute name
    while not (P^ in ['=',' ','>',#0]) do
      inc(P);

    if (P^ = '=') then inc(P);
    
    while not (P^ in [' ','>',#0]) do
    begin

      if (P^ in ['"','''']) then
      begin
        C:= P^;
        inc(P); { Skip current character }
      end else
        C:= ' ';

      { thanks to Dmitry [mail@vader.ru] }
      while not (P^ in [C, '>', #0]) do
        inc(P);

      if (P^<>'>') then inc(P); { Skip current character, except '>' }
      break;
    end;

    if P > S then
      Result:= CopyBuffer(S, P - S) 
    else
      Result:= '';
  end;
end;


{ ----------------------------------------------------------------------------
  BELOW FUNCTIONS ARE OBSOLETE OR RARELY NEEDED SINCE THEY EITHER CONTAIN BUGS
  OR THEY ARE TOO CASE SENSITIVE (FOR THE TAG NAME PORTION OF THE ATTRIBUTE  }

{ James old buggy code for testing purposes. 
  Bug: when finding 'ID', function finds "width", even though width <> "id" }
function GetNameValPair_JAMES(const tag, attribname_ci: string): string;
var
  P    : Pchar;
  S    : Pchar;
  UT,
  UA   : string;
  Start: integer;
  L    : integer;
  C    : char;
begin
  UA:= Ucase(attribname_ci);
  UT:= Ucase(Tag);
  P:= Pchar(UT);
  S:= StrPos(P, Pchar(UA));
  if S <> nil then
  begin

    P := S;

    // Skip attribute name
    while not (P^ in ['=',' ','>',#0]) do
      inc(P);

    if (P^ = '=') then inc(P);
    
    while not (P^ in [' ','>',#0]) do
    begin

      if (P^ in ['"','''']) then
      begin
        C:= P^;
        inc(P); { Skip current character }
      end else
        C:= ' ';

      { thanks to Dmitry [mail@vader.ru] }
      while not (P^ in [C, '>', #0]) do
        Inc(P);

      if (P^ <> '>') then inc(P); { Skip current character, except '>' }
      break;
    end;

    L:= P - S;
    Start:= S - Pchar(UT);
    P:= Pchar(Tag);
    S:= P;
    inc(S, Start);
    result:= CopyBuffer(S, L);
  end;
end;


{ James old buggy code for testing purposes }
function GetVal_JAMES(const tag, attribname_ci: string): string;
var namevalpair: string;
begin
  namevalpair:= GetNameValPair_JAMES(tag, attribname_ci);
  result:= GetValFromNameVal(namevalpair);
end;


end.





(* alternative, not needed

{ return value (case preserved) from a name=value pair, ignores case in given NAME= portion }
function GetValFromNameVal(namevalpair: string): string;

  type 
    TAttribPos = record
      startpos: longword; // start pos of value
      len: longword;      // length of value
    end;

  { returns case insensitive start position and length of just the value 
    substring in name=value pair}
  function ReturnPos(attribute: string): TAttribPos;
  var
    P    : Pchar;
    S    : Pchar;
    C    : Char;
  begin
    result.startpos:= 0;
    result.len:= 0;
    P:= Pchar(uppercase(Attribute));
    // get substring including and everything after equal
    S:= StrPos(P, '=');
    result.startpos:= pos('=', P); 

    if S <> nil then
    begin
      inc(S);  
      // set to character after =
      inc(result.startpos);
      P:= S; 

      if (P^ in ['"','''']) then
      begin
        C:= P^;
        // skip quote 
        inc(P); 
        inc(result.startpos);
      end else
        C:= ' ';

      S:= P;
      // go to end quote or end of value
      while not (P^ in [C, #0]) do
        inc(P);

      if (P <> S) then 
      begin
        result.len:= p - s;
      end;
    end;

  end;

var 
  found: TAttribPos;
begin
  found:= ReturnPos(namevalpair);
  // extract using coordinates
  result:= MidStr(namevalpair, found.startpos, found.len);
end;

*)




