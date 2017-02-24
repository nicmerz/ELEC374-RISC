library ieee;
use ieee.std_logic_1164.all;

entity datapath_shr_tb is
end;

architecture logic of datapath_shr_tb is
signal clk_tb : std_logic;
signal clr_tb : std_logic;
signal IncPC_tb	: std_logic;
signal MDRRead_tb	: std_logic;
signal SHR_tb		: std_logic_vector(4 downto 0);
signal encoderIn_tb	: std_logic_vector(31 downto 0);
signal RegEnable_tb		: std_logic_vector(31 downto 0);
signal Mdatain_tb, BusMuxOut_tb	: std_logic_vector(31 downto 0);

signal dummyInput_tb : std_logic_vector(31 downto 0);

type	state is(default, Reg_load1, Reg_load2, Reg_load3, T0, T1, T2, T3, T4, T5);
signal	present_state: State := default;

component datapath
	PORT (
		clk			: in std_logic;
		clr		: in std_logic;
		IncPC			: in std_logic;
		encoderIn	: in std_logic_vector(31 downto 0);
		RegEnableIn : in std_logic_vector(31 downto 0);
		Mdatain 		: in std_logic_vector(31 downto 0);
		---- The purpose of this input is for testbenching; it can easily set initial register values ----
		dummyInput	: in std_logic_vector(31 downto 0);
		MDRRead		: in std_logic;
		aluOp			: in std_logic_vector(4 downto 0);
		BusMuxOut	: out std_logic_vector(31 downto 0)
	);
end component;

begin
datapathTest : datapath port map (clk_tb, clr_tb, IncPC_tb, encoderIn_tb, RegEnable_tb, Mdatain_tb, dummyInput_tb, MDRRead_tb, SHR_tb, BusMuxOut_tb);

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
			when Reg_load2 =>
				present_state <= Reg_load3;
			when Reg_load3 =>
				present_state <= T0;
			when T0 =>
				present_state <= T1;
			when T1 =>
				present_state <= T2;
			when T2 =>
				present_state <= T3;
			when T3 =>
				present_state <= T4;
			when T4 =>
				present_state <= T5;
			when others =>
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
			SHR_tb <= (others => '0');
			encoderIn_tb <= (others => '0');
			RegEnable_tb <= (others => '0');
			
		when Reg_load1 =>
			dummyInput_tb <= x"00000012";
			RegEnable_tb <= (2 => '1', others => '0');
			encoderIn_tb <= (24 => '1', others => '0');
		when Reg_load2 =>
			dummyInput_tb <= x"00007015";
			RegEnable_tb <= (1 => '1', others => '0');
			encoderIn_tb <= (24 => '1', others => '0');
		when Reg_load3 =>
			dummyInput_tb <= x"00000004";
			RegEnable_tb <= (3 => '1', others => '0');
			encoderIn_tb <= (24 => '1', others => '0');
		
		when T0 =>
			encoderIn_tb <= (20 => '1', others => '0');
			RegEnable_tb <= (21 => '1', 23 => '1', others => '0');
			IncPC_tb <= '1';
		when T1 =>
			encoderIn_tb <= (19 => '1', others => '0');
			RegEnable_tb <= (18 => '1', 20 => '1', others => '0');
			IncPC_tb <= '0';
			MDRRead_tb <= '1';
			Mdatain_tb <= x"49098000";
		when T2 =>
			MDRRead_tb <= '0';
			Mdatain_tb <= (others => '0');
			encoderIn_tb <= (21 => '1', others => '0');
			RegEnable_tb <= (19 => '1', others => '0');
		when T3 =>
			encoderIn_tb <= (1 => '1', others => '0');
			RegEnable_tb <= (22 => '1', others => '0');
		when T4 =>
			encoderIn_tb <= (3 => '1', others => '0');
			SHR_tb <= "01001";
			RegEnable_tb <= (23 => '1', others => '0');
		when T5 =>
			encoderIn_tb <= (19 => '1', others => '0');
			RegEnable_tb <= (2 => '1', others => '0');
		when others =>
	end case;
end process;
end architecture;