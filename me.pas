program me;

(*
  Purpose: Freepascal source code to calculate the minimum entropy of a file
  Usage: me < file
  Cor van Wandelen v4-2023
  
  This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
  You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>. 
*)

{$MODE DELPHI}
{$RANGECHECKS ON}
{$OPTIMIZATION ON}
{$DEBUGINFO OFF}

uses SysUtils;

var b : Char;
	totb, ones, zeroes, g : Int64;
	me : extended;

function SparseBitCount(b: Byte): Byte;
begin
	Result := 0;
    	while b <> 0 do
    	begin
        	Inc(Result);
        	b := b and (b - 1);
    	end;
end;

function Log (n : extended) : extended;
begin
	Log := ln(n) / ln(10);
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
        me := -Log((g/totb))/Log(2);
    	writeln('minimum entropy: ', FormatFloat('0.00000000', me), ' bits per bit');
end.
