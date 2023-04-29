program me;

{$MODE DELPHI}
{$RANGECHECKS ON}
{$OPTIMIZATION ON}
{$DEBUGINFO OFF}

uses SysUtils;

var b : Char;
	totb, ones, zeroes, g : Int64;
	me : extended;

function SparseBitCount(b: Byte): Int64;
begin
	Result := 0;
    	while b <> 0 do
    	begin
        	Inc(Result);
        	b := b and (b - 1);
    	end;
end;

function log (n : extended) : extended;
begin
	log := ln(n)/ln(10);
end;

begin
	if paramstr(1) = '-h' then
	begin
        	writeln('calculates minimum entropy of a file');
        	writeln('Cor van Wandelen v.4-2023');
        	writeln('usage: me < file');
        	halt(1);
    	end;
    	totb := 0;
    	ones := 0;
	zeroes := 0;
	while not EOF(input) do
	begin
        	read(b);
        	totb := totb + 1;
        	ones := ones + SparseBitCount(byte(b));
	end;
    	totb := totb * 8;
    	zeroes := totb - ones;
    	if ones >= zeroes then g := ones else g := zeroes;
        me := -log((g/totb))/log(2);
    	writeln('minimum entropy: ', FormatFloat('0.00', me), ' bits per bit');
end.
