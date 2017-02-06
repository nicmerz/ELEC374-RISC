library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity regMDR is
	port(
	
		BusMuxOut, MDataIn : in std_logic_vector(31 downto 0);
		MDR_q : out std_logic_vector(31 downto 0);
		MDR_read, clr, clk, MDR_enable : in std_logic
		);
		-- clock, (active low) reset, and load enable
		--clk, clr, load_en : in std_logic;
		-- 32 bits of input
		--d : in std_logic_vector(31 downto 0);
		-- 32 bits of output
		--q : out std_logic_vector(31 downto 0)

end entity;

architecture logic of regMDR is

signal MDMuxOut : std_logic_vector(31 downto 0);

begin


MDMuxOut <= BusMuxOut    when MDR_read = '0' else
	         MDataIn; -- when MDR_read = '1'
		
 process(clk, clr)
	begin
		if(clr = '0') then
			MDR_q <= (others => '0');
		elsif(clk'EVENT and clk = '1') then
			if(MDR_enable = '1') then
				MDR_q <= MDMuxOut;
			end if;
		end if;
	end process;
end architecture;