library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.my_components.all;

entity datapath is
	PORT (
		clk			: in std_logic;
		clr		: in std_logic;
		IncPC			: in std_logic;
		encoderIn	: in std_logic_vector(15 downto 0);
		RegEnableIn : in std_logic_vector(15 downto 0);
		---- The purpose of this input is for testbenching; it can easily set initial register values ----
		dummyInput	: in std_logic_vector(31 downto 0);
		MDRRead		: in std_logic;
		MDRWrite		: in std_logic;
		Baout			: in std_logic;
		Gra			: in std_logic;
		Grb			: in std_logic;
		Grc			: in std_logic;
		Rin			: in std_logic;
		Rout			: in std_logic;
		aluOp			: in std_logic_vector(4 downto 0);
		inport		: in std_logic_vector(31 downto 0);
		outport		: out std_logic_vector(31 downto 0);
		conffout		: out std_logic;
		
		---- Outputports for testing purposes ----
		BusMuxOut	: out std_logic_vector(31 downto 0);
		R0out			: out std_logic_vector(31 downto 0);
		R1out			: out std_logic_vector(31 downto 0);
		R2out			: out std_logic_vector(31 downto 0);
		R3out			: out std_logic_vector(31 downto 0);
		R4out			: out std_logic_vector(31 downto 0);
		R5out			: out std_logic_vector(31 downto 0);
		R6out			: out std_logic_vector(31 downto 0);
		R7out			: out std_logic_vector(31 downto 0);
		R8out			: out std_logic_vector(31 downto 0);
		R9out			: out std_logic_vector(31 downto 0);
		R10out		: out std_logic_vector(31 downto 0);
		R11out		: out std_logic_vector(31 downto 0);
		R12out		: out std_logic_vector(31 downto 0);
		R13out		: out std_logic_vector(31 downto 0);
		R14out		: out std_logic_vector(31 downto 0);
		R15out		: out std_logic_vector(31 downto 0);
		HIout			: out std_logic_vector(31 downto 0);
		LOout			: out std_logic_vector(31 downto 0);
		IRout			: out std_logic_vector(31 downto 0);
		PCval		   : out std_logic_vector(31 downto 0); ---aded for testbenches
		Zout			: out std_logic_vector(63 downto 0)

	);
end entity;

----------------------------------------------------------------

architecture logic of datapath is

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

---- ALU-Related Signals ----
signal overflow : std_logic;

---- Memory-Related Signals ----
signal MARout	: std_logic_vector(31 downto 0);
signal RAMout	: std_logic_vector(31 downto 0);

---- Select and Encode Signals
signal internalEncoderIn	: std_logic_vector(31 downto 0);
signal internalRegEnableIn : std_logic_vector(31 downto 0);
signal internalIRout			: std_logic_vector(31 downto 0);

begin

---- Set default values, to get rid of compiler warnings ----
defaultSig <= (others => '0');
		
reg0 	: r0 port map (clk, clr, internalRegEnableIn(0), internalBusMuxOut, Baout, BusMuxIn_R0);

-- ...................  CLK  clr  EN									D              			Q ........... 

R1		: reg32 port map (clk, clr, internalRegEnableIn(1),		internalBusMuxOut,    	BusMuxIn_R1);
R2 	: reg32 port map (clk, clr, internalRegEnableIn(2),		internalBusMuxOut,   	BusMuxIn_R2);
R3 	: reg32 port map (clk, clr, internalRegEnableIn(3),		internalBusMuxOut,   	BusMuxIn_R3);
R4 	: reg32 port map (clk, clr, internalRegEnableIn(4),		internalBusMuxOut,   	BusMuxIn_R4);
R5 	: reg32 port map (clk, clr, internalRegEnableIn(5),		internalBusMuxOut,   	BusMuxIn_R5);
R6 	: reg32 port map (clk, clr, internalRegEnableIn(6),		internalBusMuxOut,   	BusMuxIn_R6);
R7 	: reg32 port map (clk, clr, internalRegEnableIn(7),		internalBusMuxOut,   	BusMuxIn_R7);
R8 	: reg32 port map (clk, clr, internalRegEnableIn(8),		internalBusMuxOut,   	BusMuxIn_R8);
R9 	: reg32 port map (clk, clr, internalRegEnableIn(9),		internalBusMuxOut,  		BusMuxIn_R9);
R10 	: reg32 port map (clk, clr, internalRegEnableIn(10),	internalBusMuxOut,  		BusMuxIn_R10);
R11 	: reg32 port map (clk, clr, internalRegEnableIn(11),	internalBusMuxOut,  		BusMuxIn_R11);
R12 	: reg32 port map (clk, clr, internalRegEnableIn(12),	internalBusMuxOut,  		BusMuxIn_R12);
R13 	: reg32 port map (clk, clr, internalRegEnableIn(13),	internalBusMuxOut,  		BusMuxIn_R13);
R14 	: reg32 port map (clk, clr, internalRegEnableIn(14),	internalBusMuxOut,  		BusMuxIn_R14);
R15 	: reg32 port map (clk, clr, internalRegEnableIn(15),	internalBusMuxOut,  		BusMuxIn_R15);
HI 	: reg32 port map (clk, clr, internalRegEnableIn(16),	internalBusMuxOut, 		BusMuxIn_HI);
LO 	: reg32 port map (clk, clr, internalRegEnableIn(17),	internalBusMuxOut, 		BusMuxIn_LO);
PC 	: reg32 port map (clk, clr, internalRegEnableIn(18),	internalBusMuxOut,     	BusMuxIn_PC);

---- IR Register ----
IR		: reg32 port map (clk, clr, internalRegEnableIn(19), internalBusMuxOut, internalIRout);
IRout <= internalIRout;

---- MDR Register ----
MDR	: regMDR port map (clk, clr, internalRegEnableIn(20),	MDRRead, internalBusMuxOut, RAMout, BusMuxIn_MDR);

---- MAR Register ----
MAR	: reg32 port map (clk, clr, internalRegEnableIn(21), internalBusMuxOut, MARout);

---- Instantiate ALU ----
DatapathAluPath : aluPath port map (clk, clr, 
internalRegEnableIn(22), -- Yin
internalRegEnableIn(23), -- Zin
internalBusMuxOut, internalBusMuxOut, IncPC, aluOp, overflow, BusMuxIn_Zhigh, BusMuxIn_Zlow);

---- Inport and Outport Registers ----
Inreg		: reg32 port map (clk, clr, internalRegEnableIn(24), inport, BusMuxIn_Inport);
OutReg	: reg32 port map (clk, clr, internalRegEnableIn(25), internalBusMuxOut, outport);

---- CONFF ----
confflogic : conff port map(clk, internalIRout(1 downto 0), internalBusMuxOut, conffout, internalRegEnableIn(26));

---- RAM Instantiation ----
RAMinfer	: RAM512 port map (BusMuxIn_MDR, MARout(8 downto 0), MDRWrite, MDRread, RAMout);

---- Select and Encode Instantiation ----
selectandencode : selectencode port map (internalIRout, Gra, Grb, Grc, rin, Rout, Baout, internalEncoderIn(15 downto 0), internalRegEnableIn(15 downto 0), C_sign_extended);

internalEncoderIn(31 downto 16) <= encoderIn;
internalRegEnableIn(31 downto 16) <= RegEnableIn;

---- Instantiate Encoder and Mux ----
-- Number comments next to ports refer to which bit corresponds to that port in EncoderIn (ie. how to select that input as the output to BusMuxOut)
DatapathBus : myBus port map (
BusMuxIn_R0, -- 0
BusMuxIn_R1, -- 1
BusMuxIn_R2, -- 2
BusMuxIn_R3, -- 3
BusMuxIn_R4, -- 4
BusMuxIn_R5, -- 5
BusMuxIn_R6, -- 6
BusMuxIn_R7, -- 7
BusMuxIn_R8, -- 8
BusMuxIn_R9, -- 9
BusMuxIn_R10, -- 10
BusMuxIn_R11, -- 11
BusMuxIn_R12, -- 12
BusMuxIn_R13, -- 13
BusMuxIn_R14, -- 14
BusMuxIn_R15, -- 15
BusMuxIn_HI, -- 16
BusMuxIn_LO, -- 17
BusMuxIn_Zhigh, -- 18
BusMuxIn_Zlow, -- 19
BusMuxIn_PC, -- 20
BusMuxIn_MDR, -- 21
BusMuxIn_Inport, -- 22
C_sign_extended, -- 23
dummyInput, -- 24
defaultSig, defaultSig, defaultSig, defaultSig, defaultSig, defaultSig, defaultSig, internalencoderIn, internalBusMuxOut);

---- Set testing outports to internal signals ----
BusMuxOut <= internalBusMuxOut;
R0out <= BusMuxIn_R0;
R1out <= BusMuxIn_R1;
R2out <= BusMuxIn_R2;
R3out <= BusMuxIn_R3;
R4out <= BusMuxIn_R4;
R5out <= BusMuxIn_R5;
R6out <= BusMuxIn_R6;
R7out <= BusMuxIn_R7;
R8out <= BusMuxIn_R8;
R9out <= BusMuxIn_R9;
R10out <= BusMuxIn_R10;
R11out <= BusMuxIn_R11;
R12out <= BusMuxIn_R12;
R13out <= BusMuxIn_R13;
R14out <= BusMuxIn_R14;
R15out <= BusMuxIn_R15;
HIout <= BusMuxIn_HI;
LOout <= BusMuxIn_LO;
Zout(63 downto 32) <= BusMuxIn_Zhigh;
Zout(31 downto 0) <= BusMuxIn_Zlow;
PCval <= BusMuxIn_PC; --- added for testing purposes


end architecture;