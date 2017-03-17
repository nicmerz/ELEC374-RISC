library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ConFF is

port(

	clk : in std_logic;
	IRbits   : in  std_logic_vector(1 downto 0);
	busmuxbits   : in  std_logic_vector(31 downto 0);
	q	: out std_logic;
	CONin : in std_logic

);

end entity;

architecture logic of ConFF is

	signal d_conFF :std_logic;

	signal decoderOut :std_logic_vector(3 downto 0);
	signal or_lt0, or_gte0, or_nonzero, or_0 : std_logic;
	signal and0, and1, and2, and3 : std_logic;
	signal norout : std_logic;
	
	
	begin 
	
	decoderOut <= "0001" when (IRbits = "00") else
					 "0010" when (IRbits = "01") else
					 "0100" when (IRbits = "10") else
					 "1000" ; -- when (IRbits = "11")
	norout <= not(busmuxbits(0) or busmuxbits(1) or busmuxbits(2) or busmuxbits(3) or busmuxbits(4) or busmuxbits(5) or busmuxbits(6) or busmuxbits(7) or busmuxbits(8) or busmuxbits(9) or busmuxbits(10) or busmuxbits(11) or busmuxbits(12) or busmuxbits(13) or busmuxbits(14) or busmuxbits(15) or busmuxbits(16) or busmuxbits(17) or busmuxbits(18) or busmuxbits(19) or busmuxbits(20) or busmuxbits(21) or busmuxbits(22) or busmuxbits(23) or busmuxbits(24) or busmuxbits(25) or busmuxbits(26) or busmuxbits(27) or busmuxbits(28) or busmuxbits(29) or busmuxbits(30) or busmuxbits(31));
	or_0 <= decoderOut(0) and norout;
	
	or_nonzero <= (not(norout)) and decoderOut(1);
	
	or_gte0 <= decoderOut(2) and (not(busmuxbits(31)));
	
	or_lt0 <= decoderOut(3) and busmuxbits(31);
	
	d_conFF <= or_0 or or_nonzero or or_gte0 or or_lt0;
	
	ConFF : process(clk, CONin)
	begin
		-- if clear is active, set output to 0
		--if(clr = '0') then
			--q <= (others => '0');
		-- else, if rising edge
		if(clk'EVENT and clk = '1') then
			if(CONin = '1') then
				q <= d_conFF;
			end if;
		end if;
	end process;
	

end architecture;