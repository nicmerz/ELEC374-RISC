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
		-- Overflow out
		overflow : out std_logic;
		-- 32 bits of output
		output : out std_logic_vector(63 downto 0)
	);
end entity;

architecture logic of alu is


signal andOut : std_logic_vector(31 downto 0);
signal orOut : std_logic_vector(31 downto 0);
signal notOut : std_logic_vector(31 downto 0);
signal CLAOut : std_logic_vector(15 downto 0);
signal CLAc0 : std_logic;
signal CLAOverflow : std_logic;
signal addSubOut : std_logic_vector(31 downto 0);
signal addSubSignal : std_logic;
signal addSubOverflow : std_logic;

begin
aluAnd 	: and32 port map (input0, input1, andOut);
aluOr 	: or32 port map (input0, input1, orOut);
aluNot 	: not32 port map (input0, notOut);
aluCLA	: CLA port map (input0(15 downto 0), input1(15 downto 0), CLAc0, CLAOverflow, CLAOut);
aluAddSub : lpm_add_sub0 port map (addSubSignal, input0, input1, addSubOverflow, addSubOut);

CLAc0 <= '0';

alu : process(
	input0, input1, opInput, 
	andOut, orOut, notOut, 
	CLAOut, CLAc0, CLAOverflow,
	addSubOut, addSubSignal, addSubOverflow
)
begin
addSubSignal <= '0';
overflow <= '0';

---- AND ----
if(opInput = "00111") then
	output(31 downto 0) <= andOut;
	output(63 downto 32) <= (others => '0');

---- OR ----
elsif(opInput = "01000") then
	output(31 downto 0) <= orOut;
	output(63 downto 32) <= (others => '0');
	
---- NOT ----
elsif(opInput = "10011") then
	output(31 downto 0) <= notOut;
	output(63 downto 32) <= (others => '0');
	
---- 32-bit Add ----
elsif(opInput = "00101") then
	addSubSignal <= '1';
	output(31 downto 0) <= addSubOut;
	output(63 downto 32) <= (others => '0');
	overflow <= addSubOverflow;

---- 32-bit Sub ----
elsif(opInput = "00110") then
	addSubSignal <= '0';
	output(31 downto 0) <= addSubOut;
	output(63 downto 32) <= (others => '0');
	overflow <= addSubOverflow;
	
---- CLA 16-bit Add ----
elsif(opInput = "11111") then
	output(15 downto 0) <= CLAOut;
	output(63 downto 16) <= (others => '0');
	overflow <= CLAOverflow;
	
---- Edge Case ----
else
	output <= (others => '0');
end if;

end process;

end architecture;