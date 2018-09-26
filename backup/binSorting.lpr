program binSorting;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this };

const length = 10000;
type
  binSortingz = class(TCustomApplication)      //z on the end to sort out an error
  protected
    procedure DoRun; override;
  public
  end;
  intArray = array[0..length] of integer;
  bins = array[0..length , 0..20] of integer;
{ binSorting }
var intTemp:integer;
      i:integer;  //i is a counter
function randDataSet() :intArray ; begin
    i:=0;
    repeat
          result[i]:=Random(9) + 1;
          writeln('Generating a random Data Set, ',i,', out of ',length,' members made. Num was', result[i]);
          i:=i+1;
    until i>length;
    writeln('Data set fully generated');
end;
var counter, sum: integer;
function getBinSum(bin: bins; i: integer) : integer; begin
    counter:=0;
    sum:=0;
    while counter<=20 do begin
        sum:=sum + bin[i , counter];
        counter:=counter + 1;
    end;
    result:=sum;
end;
var countera, suma: integer;
function getBinYHeight(bin: bins; i: integer{i=x pos}) : integer; begin
    countera:=0;
    suma:=0;
    while countera<=20 do begin
        if bin[i , countera] > 0 then begin
           suma:= suma + 1;
        end;
        countera:=countera + 1;
    end;
    result:=suma;
end;
procedure binSortingz.DoRun;
var
  ErrorMsg: String;
  dataSet: intArray;
  bin: bins;
  dataSetCounter, binCounterX, x ,counterX,counterY: integer;
begin
  randomize();
  // get dataset
  dataSet:=randDataSet();
  // init bin
  writeln('initiliasing bin');
  counterX:=0;
  while counterX <= length do begin
      counterY:=0;
      while counterY <= 20 do begin
            bin[counterX,counterY]:=0;
            counterY:=counterY + 1;
      end;
      counterX:=counterX + 1;
  end;
  writeln('Bin initialised');
  // bin sort alg
  dataSetCounter:=0;
  while dataSetCounter<=length do begin
      binCounterX:=0;
      while binCounterX<=length do begin
          if (getBinSum(bin,binCounterX) + dataSet[dataSetCounter]) <= 20 then begin
             bin[binCounterX, getBinYHeight(bin, binCounterX)]:=dataSet[dataSetCounter];
             writeln('Assigned ',dataSet[dataSetCounter],' to bin number ',binCounterX,' at y pos ',getBinYHeight(bin, binCounterX));
             break;
          end;
          binCounterX:= binCounterX+1;
      end;
      dataSetCounter:=dataSetCounter + 1;
  end;
  writeln('The bins are:');
  // get the bins!
  x:=0;
  while x <= length do begin
      if bin[x,0]<>0 then begin
         writeln('Bin ',x,' Values: '
         ,bin[x,0],',', bin[x,1],',', bin[x,2],',', bin[x,3],','
         ,bin[x,4],',', bin[x,5],',', bin[x,6],',', bin[x,7],','
         ,bin[x,8],',', bin[x,9],',', bin[x,10],',', bin[x,11],','
         ,bin[x,12],',', bin[x,13],',', bin[x,14],',', bin[x,15],','
         ,bin[x,16],',', bin[x,17],',', bin[x,18],',', bin[x,19],','
         ,bin[x,20]);
      end;
      x:=x+1;
  end;
  // stop program loop
  writeln('Ended, press enter to end program');
  readln();
  Terminate;
end;

var
  Application: binSortingz;
begin
  Application:=binSortingz.Create(nil);
  Application.Title:='binSorting';
  Application.Run;
  Application.Free;
end.

