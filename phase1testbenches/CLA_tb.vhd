library ieee;
use ieee.std_logic_1164.all;

entity CLA_tb is
end;

architecture logic of CLA_tb is
signal clk_tb : std_logic;
IRbits_tb   : std_logic_vector(1 downto 0);
busmuxbits_tb   : std_logic_vector(31 downto 0);
			q_tb : std_logic;
			CONin_tb : std_logic );
type	state is(default, Reg_load1, Reg_load2, Reg_load3, T0, T1, T2, T3, T4, T5);
signal	present_state: State := default;

 component ConFF
		port(
			clk : in std_logic;
			IRbits   : in  std_logic_vector(1 downto 0);
			busmuxbits   : in  std_logic_vector(31 downto 0);
			q	: out std_logic;
			CONin : in std_logic );
	end component;

confflogic : conff port map(clk, internalIRout(1 downto 0), internalBusMuxOut, conffout, internalRegEnableIn(26));

clk_process: process
begin
	clk_tb <= '1', '0' after 10 ns;
	wait for 20 ns;
end process clk_process;

process(clk_tb)
begin
	if(clk_tb'EVENT and clk_tb = '1') then
		case present_state is
			when default =>
				present_state <= Reg_load1;
			when Reg_load1 =>
				present_state <= Reg_load2;
		end case;
	end if;
end process;

process (present_state)
begin
	case present_state is
		when default =>
			clr_tb <= '1';
			IncPC_tb <= '0';
			MDRRead_tb <= '0';
			CLA_tb <= (others => '0');
			encoderIn_tb <= (others => '0');
			RegEnable_tb <= (others => '0');
			
		when Reg_load1 =>
			dummyInput_tb <= x"00000012";
			RegEnable_tb <= (18 => '1', others => '0');
			encoderIn_tb <= (24 => '1', others => '0');
		when Reg_load2 =>
			dummyInput_tb <= x"00000014";
			RegEnable_tb <= (2 => '1', others => '0');
			encoderIn_tb <= (24 => '1', others => '0');
		when others =>
	end case;
end process;
end architecture;