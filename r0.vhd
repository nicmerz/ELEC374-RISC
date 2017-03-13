library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity r0 is
	port(
		-- clock, (active low) reset, and load enable
		clk : in std_logic;
		clr : in std_logic;
		load_en : in std_logic;
		-- 32 bits of input
		d : in std_logic_vector(31 downto 0);
		BAout : in std_logic;
		R0_output : out std_logic_vector(31 downto 0)
		
	);
end entity;

architecture logic of r0 is
signal q : std_logic_vector(31 downto 0);

begin

reg32 : process(clk, clr)
	begin
		-- if clear is active, set output to 0
		if(clr = '0') then
			q <= (others => '0');
		-- else, if rising edge
		elsif(clk'EVENT and clk = '1') then
			if(load_en = '1') then
				q <= d;
			end if;
		end if;
	end process;
	
	R0_output(0) <= q(0) and (not BAout);
	R0_output(1) <= q(1) and (not BAout);
	R0_output(2) <= q(2) and (not BAout);
	R0_output(3) <= q(3) and (not BAout);
	R0_output(4) <= q(4) and (not BAout);
	R0_output(5) <= q(5) and (not BAout);
	R0_output(6) <= q(6) and (not BAout);
	R0_output(7) <= q(7) and (not BAout);
	R0_output(8) <= q(8) and (not BAout);
	R0_output(9) <= q(9) and (not BAout);
	R0_output(10) <= q(10) and (not BAout);
	R0_output(11) <= q(11) and (not BAout);
	R0_output(12) <= q(12) and (not BAout);
	R0_output(13) <= q(13) and (not BAout);
	R0_output(14) <= q(14) and (not BAout);
	R0_output(15) <= q(15) and (not BAout);
	R0_output(16) <= q(16) and (not BAout);
	R0_output(17) <= q(17) and (not BAout);
	R0_output(18) <= q(18) and (not BAout);
	R0_output(19) <= q(19) and (not BAout);
	R0_output(20) <= q(20) and (not BAout);
	R0_output(21) <= q(21) and (not BAout);
	R0_output(22) <= q(22) and (not BAout);
	R0_output(23) <= q(23) and (not BAout);
	R0_output(24) <= q(24) and (not BAout);
	R0_output(25) <= q(25) and (not BAout);
	R0_output(26) <= q(26) and (not BAout);
	R0_output(27) <= q(27) and (not BAout);
	R0_output(28) <= q(28) and (not BAout);
	R0_output(29) <= q(29) and (not BAout);
	R0_output(30) <= q(30) and (not BAout);
	R0_output(31) <= q(31) and (not BAout);
	
	
end architecture;