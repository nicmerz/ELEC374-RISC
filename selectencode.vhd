library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.mem_init.all;


entity selectencode is
   port
   (
		IRin	: in std_logic_vector(31 downto 0);
		Gra	: in std_logic;
		Grb	: in std_logic;
		Grc	: in std_logic;
		Rin	: in std_logic;
		Rout	: in std_logic;
		Baout	: in std_logic;
		Routvect : out std_logic_vector(15 downto 0);
		Rinvect	: out std_logic_vector(15 downto 0);
		Cextendedout	: out std_logic_vector(31 downto 0)
   );
end entity;
architecture logic of selectencode is
signal a, b, c, orout : std_logic_vector(3 downto 0);
signal decoderout : std_logic_vector(15 downto 0);
begin

a(3) <= IRin(26) and Gra;
a(2) <= IRin(25) and Gra;
a(1) <= IRin(24) and Gra;
a(0) <= IRin(23) and Gra;

b(3) <= IRin(22) and Grb;
b(2) <= IRin(21) and Grb;
b(1) <= IRin(20) and Grb;
b(0) <= IRin(19) and Grb;

c(3) <= IRin(18) and Grc;
c(2) <= IRin(17) and Grc;
c(1) <= IRin(16) and Grc;
c(0) <= IRin(15) and Grc;

orout <= a or b or c;

with orout select
decoderout <= "0000000000000001" when "0000",
					"0000000000000010" when "0001",
					"0000000000000100" when "0010",
					"0000000000001000" when "0011",
					"0000000000010000" when "0100",
					"0000000000100000" when "0101",
					"0000000001000000" when "0110",
					"0000000010000000" when "0111",
					"0000000100000000" when "1000",
					"0000001000000000" when "1001",
					"0000010000000000" when "1010",
					"0000100000000000" when "1011",
					"0001000000000000" when "1100",
					"0010000000000000" when "1101",
					"0100000000000000" when "1110",
					"1000000000000000" when others;
					
Routvect(15) <= decoderout(15) and (Rout or BAout);
Routvect(14) <= decoderout(14) and (Rout or BAout);
Routvect(13) <= decoderout(13) and (Rout or BAout);
Routvect(12) <= decoderout(12) and (Rout or BAout);
Routvect(11) <= decoderout(11) and (Rout or BAout);
Routvect(10) <= decoderout(10) and (Rout or BAout);
Routvect(9) <= decoderout(9) and (Rout or BAout);
Routvect(8) <= decoderout(8) and (Rout or BAout);
Routvect(7) <= decoderout(7) and (Rout or BAout);
Routvect(6) <= decoderout(6) and (Rout or BAout);
Routvect(5) <= decoderout(5) and (Rout or BAout);
Routvect(4) <= decoderout(4) and (Rout or BAout);
Routvect(3) <= decoderout(3) and (Rout or BAout);
Routvect(2) <= decoderout(2) and (Rout or BAout);
Routvect(1) <= decoderout(1) and (Rout or BAout);
Routvect(0) <= decoderout(0) and (Rout or BAout);

Rinvect(15) <= decoderout(15) and Rin;
Rinvect(14) <= decoderout(14) and Rin;
Rinvect(13) <= decoderout(13) and Rin;
Rinvect(12) <= decoderout(12) and Rin;
Rinvect(11) <= decoderout(11) and Rin;
Rinvect(10) <= decoderout(10) and Rin;
Rinvect(9) <= decoderout(9) and Rin;
Rinvect(8) <= decoderout(8) and Rin;
Rinvect(7) <= decoderout(7) and Rin;
Rinvect(6) <= decoderout(6) and Rin;
Rinvect(5) <= decoderout(5) and Rin;
Rinvect(4) <= decoderout(4) and Rin;
Rinvect(3) <= decoderout(3) and Rin;
Rinvect(2) <= decoderout(2) and Rin;
Rinvect(1) <= decoderout(1) and Rin;
Rinvect(0) <= decoderout(0) and Rin;

Cextendedout <= std_logic_vector(resize(signed(IRin(18 downto 0)), Cextendedout'length));

end architecture;