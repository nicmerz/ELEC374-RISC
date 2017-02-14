library ieee;
use ieee.std_logic_1164.all;

package my_components is
	component lpm_mux0
		PORT
		(
			data0x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data1x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data2x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data3x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data4x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data5x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data6x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data7x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data8x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data9x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data10x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data11x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data12x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data13x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data14x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data15x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data16x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data17x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data18x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data19x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data20x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data21x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data22x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data23x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data24x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data25x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data26x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data27x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data28x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data29x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data30x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			data31x		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
	
			sel		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
	
	component encoder32
		PORT
		(
			input : in std_logic_vector(31 downto 0);
			result		: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
		);
	end component;
	
	component reg32
		port(
			-- clock, (active low) reset, and load enable
			clk, clr, load_en : in std_logic;
			-- 32 bits of input
			d : in std_logic_vector(31 downto 0);
			-- 32 bits of output
			q : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component reg64
		port(
			-- clock, (active low) reset, and load enable
			clk, clr, load_en : in std_logic;
			-- 64 bits of input
			d : in std_logic_vector(63 downto 0);
			-- 2 sets of 32 bits of output
			q1 : out std_logic_vector(31 downto 0);
			q0 : out std_logic_vector(31 downto 0)	
		);
	end component;
	
	component regMDR
		port(
			clk, clr, MDR_enable, MDRead : in std_logic;
			MDIn0, MDIn1 : in std_logic_vector(31 downto 0);
			MDOut : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component myBus
		PORT (
			muxIn0		: in std_logic_vector (31 downto 0);
			muxIn1		: in std_logic_vector (31 downto 0);
			muxIn2		: in std_logic_vector (31 downto 0);
			muxIn3		: in std_logic_vector (31 downto 0);
			muxIn4		: in std_logic_vector (31 downto 0);
			muxIn5		: in std_logic_vector (31 downto 0);
			muxIn6		: in std_logic_vector (31 downto 0);
			muxIn7		: in std_logic_vector (31 downto 0);
			muxIn8		: in std_logic_vector (31 downto 0);
			muxIn9		: in std_logic_vector (31 downto 0);
			muxIn10		: in std_logic_vector (31 downto 0);
			muxIn11		: in std_logic_vector (31 downto 0);
			muxIn12		: in std_logic_vector (31 downto 0);
			muxIn13		: in std_logic_vector (31 downto 0);
			muxIn14		: in std_logic_vector (31 downto 0);
			muxIn15		: in std_logic_vector (31 downto 0);
			muxIn16		: in std_logic_vector (31 downto 0);
			muxIn17		: in std_logic_vector (31 downto 0);
			muxIn18		: in std_logic_vector (31 downto 0);
			muxIn19		: in std_logic_vector (31 downto 0);
			muxIn20		: in std_logic_vector (31 downto 0);
			muxIn21		: in std_logic_vector (31 downto 0);
			muxIn22		: in std_logic_vector (31 downto 0);
			muxIn23		: in std_logic_vector (31 downto 0);
			muxIn24		: in std_logic_vector (31 downto 0);
			muxIn25		: in std_logic_vector (31 downto 0);
			muxIn26		: in std_logic_vector (31 downto 0);
			muxIn27		: in std_logic_vector (31 downto 0);
			muxIn28		: in std_logic_vector (31 downto 0);
			muxIn29		: in std_logic_vector (31 downto 0);
			muxIn30		: in std_logic_vector (31 downto 0);
			muxIn31		: in std_logic_vector (31 downto 0);
			encoderIn	: in std_logic_vector(31 downto 0);
			BusMuxOut	: out std_logic_vector(31 downto 0)
		);
	end component;

---- ALU Components ----

	component and32
		port(
			-- 2 32 bits of input
			input0 : in std_logic_vector(31 downto 0);
			input1 : in std_logic_vector(31 downto 0);
			-- 32 bits of output
			output : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component or32
		port(
			-- 2 32 bits of input
			input0 : in std_logic_vector(31 downto 0);
			input1 : in std_logic_vector(31 downto 0);
			-- 32 bits of output
			output : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component not32
		port(
			-- 2 32 bits of input
			input : in std_logic_vector(31 downto 0);
			-- 32 bits of output
			output : out std_logic_vector(31 downto 0)
		);
	end component;
	
	component CLA
		port(
			x   : in  std_logic_vector(15 downto 0);
			y   : in  std_logic_vector(15 downto 0);
			c0  : in  std_logic;
			c16 : out std_logic;
			s : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component lpm_add_sub0
		PORT
		(
			add_sub		: IN STD_LOGIC ;
			dataa		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			datab		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			overflow		: OUT STD_LOGIC ;
			result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	end component;
end package;