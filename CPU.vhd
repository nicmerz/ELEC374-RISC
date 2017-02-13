library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.my_components.all;

entity CPU is
	PORT (
		clk			: in std_logic;
		reset_n		: in std_logic;
		-- This input will got to an unused port of the Bus Mux. The purpose of this input is for testing; an arbitrary signal can be sent, and using RegEnables, any registers' value can be set.
		dummyInput	: in std_logic_vector(31 downto 0);
		encoderIn	: in std_logic_vector(31 downto 0);
		RegEnableIn : in std_logic_vector(31 downto 0);
		BusMuxOut	: out std_logic_vector(31 downto 0)
	);
end entity;

----------------------------------------------------------------

architecture logic of CPU is

---- BusMux Inputs ----
signal BusMuxIn_R0 : std_logic_vector(31 downto 0);
signal BusMuxIn_R1 : std_logic_vector(31 downto 0);
signal BusMuxIn_R2 : std_logic_vector(31 downto 0);
signal BusMuxIn_R3 : std_logic_vector(31 downto 0);
signal BusMuxIn_R4 : std_logic_vector(31 downto 0);
signal BusMuxIn_R5 : std_logic_vector(31 downto 0);
signal BusMuxIn_R6 : std_logic_vector(31 downto 0);
signal BusMuxIn_R7 : std_logic_vector(31 downto 0);
signal BusMuxIn_R8 : std_logic_vector(31 downto 0);
signal BusMuxIn_R9 : std_logic_vector(31 downto 0);
signal BusMuxIn_R10 : std_logic_vector(31 downto 0);
signal BusMuxIn_R11 : std_logic_vector(31 downto 0);
signal BusMuxIn_R12 : std_logic_vector(31 downto 0);
signal BusMuxIn_R13 : std_logic_vector(31 downto 0);
signal BusMuxIn_R14 : std_logic_vector(31 downto 0);
signal BusMuxIn_R15 : std_logic_vector(31 downto 0);
signal BusMuxIn_HI : std_logic_vector(31 downto 0);
signal BusMuxIn_LO : std_logic_vector(31 downto 0);
signal BusMuxIn_Zhigh : std_logic_vector(31 downto 0);
signal BusMuxIn_Zlow : std_logic_vector(31 downto 0);
signal BusMuxIn_PC : std_logic_vector(31 downto 0);
signal BusMuxIn_MDR : std_logic_vector(31 downto 0);
signal BusMuxIn_Inport : std_logic_vector(31 downto 0);
signal C_sign_extended : std_logic_vector(31 downto 0);

---- BusMux Output ----
signal internalBusMuxOut : std_logic_vector(31 downto 0);

---- Default ----
signal defaultSig : std_logic_vector(31 downto 0);

begin

---- Set default values, to get rid of compiler warnings ----
BusMuxIn_Zhigh <= (others => '0');
BusMuxIn_Zlow <= (others => '0');
BusMuxIn_Inport <= (others => '0');
C_sign_extended <= (others => '0');
defaultSig <= (others => '0');

-- ...................  CLK  RESET_N  EN                 D              			Q ........... 

R0 	: reg32 port map (clk, reset_n, RegEnableIn(0),		internalBusMuxOut,  	   BusMuxIn_R0);
R1		: reg32 port map (clk, reset_n, RegEnableIn(1),		internalBusMuxOut,    	BusMuxIn_R1);
R2 	: reg32 port map (clk, reset_n, RegEnableIn(2),		internalBusMuxOut,   	BusMuxIn_R2);
R3 	: reg32 port map (clk, reset_n, RegEnableIn(3),		internalBusMuxOut,   	BusMuxIn_R3);
R4 	: reg32 port map (clk, reset_n, RegEnableIn(4),		internalBusMuxOut,   	BusMuxIn_R4);
R5 	: reg32 port map (clk, reset_n, RegEnableIn(5),		internalBusMuxOut,   	BusMuxIn_R5);
R6 	: reg32 port map (clk, reset_n, RegEnableIn(6),		internalBusMuxOut,   	BusMuxIn_R6);
R7 	: reg32 port map (clk, reset_n, RegEnableIn(7),		internalBusMuxOut,   	BusMuxIn_R7);
R8 	: reg32 port map (clk, reset_n, RegEnableIn(8),		internalBusMuxOut,   	BusMuxIn_R8);
R9 	: reg32 port map (clk, reset_n, RegEnableIn(9),		internalBusMuxOut,  		BusMuxIn_R9);
R10 	: reg32 port map (clk, reset_n, RegEnableIn(10),	internalBusMuxOut,  		BusMuxIn_R10);
R11 	: reg32 port map (clk, reset_n, RegEnableIn(11),	internalBusMuxOut,  		BusMuxIn_R11);
R12 	: reg32 port map (clk, reset_n, RegEnableIn(12),	internalBusMuxOut,  		BusMuxIn_R12);
R13 	: reg32 port map (clk, reset_n, RegEnableIn(13),	internalBusMuxOut,  		BusMuxIn_R13);
R14 	: reg32 port map (clk, reset_n, RegEnableIn(14),	internalBusMuxOut,  		BusMuxIn_R14);
R15 	: reg32 port map (clk, reset_n, RegEnableIn(15),	internalBusMuxOut,  		BusMuxIn_R15);
HI 	: reg32 port map (clk, reset_n, RegEnableIn(16),	internalBusMuxOut, 		BusMuxIn_HI);
LO 	: reg32 port map (clk, reset_n, RegEnableIn(17),	internalBusMuxOut, 		BusMuxIn_LO);
PC 	: reg32 port map (clk, reset_n, RegEnableIn(18),	internalBusMuxOut,     	BusMuxIn_PC);
MDR	: reg32 port map (clk, reset_n, RegEnableIn(19),	internalBusMuxOut,   	BusMuxIn_MDR);

---- Instantiate Encoder and Mux ----
CPUBus : myBus port map (BusMuxIn_R0, BusMuxIn_R1, BusMuxIn_R2, BusMuxIn_R3, BusMuxIn_R4, BusMuxIn_R5, BusMuxIn_R6, BusMuxIn_R7, BusMuxIn_R8, BusMuxIn_R9, BusMuxIn_R10, BusMuxIn_R11, BusMuxIn_R12, BusMuxIn_R13,
BusMuxIn_R14, BusMuxIn_R15, BusMuxIn_HI, BusMuxIn_LO, BusMuxIn_Zhigh, BusMuxIn_Zlow, BusMuxIn_PC, BusMuxIn_MDR, BusMuxIn_Inport, C_sign_extended, dummyInput, defaultSig, defaultSig, defaultSig, defaultSig, defaultSig, defaultSig, defaultSig, encoderIn, internalBusMuxOut);


BusMuxOut <= internalBusMuxOut;

end architecture;