library ieee;
use ieee.std_logic_1164.all;

entity CLA_tb is
end;

architecture CLA_tb_struct of CLA_tb is
      signal x_tb   :  std_logic_vector(15 downto 0);
	   signal y_tb   : std_logic_vector(15 downto 0);
      signal c0_tb  : std_logic;
	   signal c16_tb : std_logic;
      signal s_tb :  std_logic_vector(15 downto 0);
	component CLA
      port(
		x   : in  std_logic_vector(15 downto 0);
	   y   : in  std_logic_vector(15 downto 0);
      c0  : in  std_logic;
	   c16 : out std_logic;
      s : out std_logic_vector(15 downto 0)
		);
    end component CLA;
begin

adder1 : CLA

port map (

x => x_tb ,
y => y_tb ,
c0 => c0_tb ,
c16 => c16_tb,
s => s_tb
);

sim_process: process

begin
wait for 0 ns;
x_tb <= b"0000000000000011";
y_tb <= b"0000000000000111";
c0_tb <= '0';

wait for 20 ns;
x_tb <= b"0000000000100011";
y_tb <= b"0000000000010101";
c0_tb <= '0';
wait;
end process sim_process;
end;


