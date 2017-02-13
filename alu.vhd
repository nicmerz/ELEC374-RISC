library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.my_components.all;

entity alu is
	port(
		-- 2 32 bits of input
		input0 : in std_logic_vector(31 downto 0);
		input1 : in std_logic_vector(31 downto 0);
		-- opcode input
		opInput : in std_logic_vector(4 downto 0);
		-- 32 bits of output
		output : out std_logic_vector(63 downto 0)
	);
end entity;

architecture logic of alu is

signal andOut : std_logic_vector(31 downto 0);
signal orOut : std_logic_vector(31 downto 0);
signal notOut : std_logic_vector(31 downto 0);

begin

aluAnd 	: and32 port map (input0, input1, andOut);
aluOr 	: or32 port map (input0, input1, orOut);
aluNot 	: not32 port map (input0, notOut);

alu : process(input0, input1, opInput, andOut, orOut, notOut)
begin
if(opInput = "00111") then
	output(31 downto 0) <= andOut;
	output(63 downto 32) <= (others => '0');
elsif(opInput = "01000") then
	output(31 downto 0) <= orOut;
	output(63 downto 32) <= (others => '0');
elsif(opInput = "10011") then
	output(31 downto 0) <= notOut;
	output(63 downto 32) <= (others => '0');
else
	output <= (others => '0');
end if;

end process;

end architecture;