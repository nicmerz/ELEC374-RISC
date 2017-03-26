LIBRARY ieee;
USE ieee.std_logic_1164.all;

use work.my_components.all;

ENTITY control_unit IS -- Here, you define the inputs and outputs to your Control Unit
	PORT(clk, rst, stop, CON_FF: IN STD_LOGIC;
		IR: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Gra, Grb, Grc, Rin, Rout, BAout: OUT STD_LOGIC;
		EncoderIn	: out std_logic_vector(15 downto 0);
		RegEnable	: out std_logic_vector(15 downto 0);
		MDRRead, MDRWrite, IncPC, run, clear: OUT STD_LOGIC;
		opCodeOut : out std_logic_vector(4 downto 0);
		stateval	: out State
	);
END control_unit;

ARCHITECTURE Behavior of control_unit IS
	--TYPE State IS (reset_state0, reset_state1, fetch0, fetch1, fetch2, fetch3, add3, add4, add5, sub3, sub4, sub5, mul3, mul4, mul5, mul6, and3, and4, and5, or3, or4, or5, div3, div4, div5, div6, andi3, andi4, andi5, ori3, ori4, ori5, branch3, branch4, jr3, jal3, jal4, in3, mfhi3, mflo3, shr3, shr4, shr5, shl3, shl4, shl5, ror3, ror4, ror5, rol3, rol4, rol5, neg3, neg4, not3, not4, ld3, ld4, ld5, ld6, ld7, ldi3, ldi4, ldi5, ldr2, ldr3, ldr4, ldr5, ldr6, addi3, addi4, addi5, out3, st3, st4, st5, st6, str3, str4, str5, str6, nop, halt);
	SIGNAL Present_state: State;
	signal HIout, LOout, Zhighout, Zlowout, PCout, MDRout, Inportout, Cout : std_logic;
	signal HIin, LOin, PCin, IRin, MDRin, MARin, Yin, Zin, Inin, Outin, CONin : std_logic;
BEGIN
-- Set EncoderIn and RegEnable bits to corresponding control signals
EncoderIn(0) <= HIout;
EncoderIn(1) <= LOout;
EncoderIn(2) <= Zhighout;
EncoderIn(3) <= Zlowout;
EncoderIn(4) <= PCout;
EncoderIn(5) <= MDRout;
EncoderIn(6) <= Inportout;
EncoderIn(7) <= Cout;
EncoderIn(8) <= '0';
EncoderIn(9) <= '0';
EncoderIn(10) <= '0';
EncoderIn(11) <= '0';
EncoderIn(12) <= '0';
EncoderIn(13) <= '0';
EncoderIn(14) <= '0';
EncoderIn(15) <= '0';

RegEnable(0) <= HIin;
RegEnable(1) <= LOin;
RegEnable(2) <= PCin;
RegEnable(3) <= IRin;
RegEnable(4) <= MDRin;
RegEnable(5) <= MARin;
RegEnable(6) <= Yin;
RegEnable(7) <= Zin;
RegEnable(8) <= Inin;
RegEnable(9) <= Outin;
RegEnable(10) <= CONin;
RegEnable(11) <= '0';
RegEnable(12) <= '0';
RegEnable(13) <= '0';
RegEnable(14) <= '0';
RegEnable(15) <= '0';

stateval <= Present_state;

	PROCESS (clk, rst, stop) -- finite state machine
	BEGIN
		IF (rst = '1') THEN -- reset the processor
			Present_state <= reset_state0;
		ELSIF(stop = '1') THEN
			Present_state <= halt;
		ELSIF (clk'EVENT AND clk = '1') THEN -- if clock rising-edge
			CASE Present_state IS
				WHEN reset_state0 =>
					Present_state <= reset_state1;
				WHEN reset_state1 =>
					Present_state <= fetch0;
				WHEN fetch0 =>
					Present_state <= fetch1;
				WHEN fetch1 =>
					Present_state <= fetch2;
				WHEN fetch2 =>
					Present_state <= fetch3;
					
-----------------------------------------------------------

				WHEN add3 =>
					Present_state <= add4;
				WHEN add4 =>
					Present_state <= add5;
				WHEN add5 =>
					Present_state <= fetch0;
				WHEN sub3 =>
					Present_state <= sub4;
				WHEN sub4 =>
					Present_state <= sub5;
				WHEN sub5 =>
					Present_state <= fetch0;
					
				WHEN mul3 =>
					Present_state <= mul4;
				WHEN mul4 =>
					Present_state <= mul5;
				WHEN mul5 =>
					Present_state <= mul6;
				WHEN mul6 =>
					Present_state <= fetch0;
					
				WHEN and3 =>
					Present_state <= and4;
				WHEN and4 =>
					Present_state <= and5;
				WHEN and5 =>
					Present_state <= fetch0;
					
				WHEN or3 =>
					Present_state <= or4;
				WHEN or4 =>
					Present_state <= or5;
				WHEN or5 =>
					Present_state <= fetch0;
					
				WHEN div3 =>
					Present_state <= div4;
				WHEN div4 =>
					Present_state <= div5;
				WHEN div5 =>
					Present_state <= div6;
				WHEN div6 =>
					Present_state <= fetch0;
				
				WHEN andi3 =>
					Present_state <= andi4;
				WHEN andi4 =>
					Present_state <= andi5;
				WHEN andi5 =>
					Present_state <= fetch0;
					
				WHEN ori3 =>
					Present_state <= ori4;
				WHEN ori4 =>
					Present_state <= ori5;
				WHEN ori5 =>
					Present_state <= fetch0;
					
				WHEN addi3 =>
					Present_state <= addi4;
				WHEN addi4 =>
					Present_state <= addi5;
				WHEN addi5 =>
					Present_state <= fetch0;
					
				WHEN branch3 =>
					Present_state <= branch4;
				WHEN branch4 =>
					Present_state <= fetch0;
					
				WHEN jal3 =>
					Present_state <= jal4;
				WHEN jal4 =>
					Present_state <= fetch0;
					
				WHEN jr3 =>
					Present_state <= fetch0;
					
				WHEN shr3 =>
					Present_state <= shr4;
				WHEN shr4 =>
					Present_state <= shr5;
				WHEN shr5 =>
					Present_state <= fetch0;
					
				WHEN shl3 =>
					Present_state <= shl4;
				WHEN shl4 =>
					Present_state <= shl5;
				WHEN shl5 =>
					Present_state <= fetch0;
					
				WHEN ror3 =>
					Present_state <= ror4;
				WHEN ror4 =>
					Present_state <= ror5;
				WHEN ror5 =>
					Present_state <= fetch0;
					
				WHEN rol3 =>
					Present_state <= rol4;
				WHEN rol4 =>
					Present_state <= rol5;
				WHEN rol5 =>
					Present_state <= fetch0;
					
				WHEN neg3 =>
					Present_state <= neg4;
				WHEN neg4 =>
					Present_state <= fetch0;
					
				WHEN not3 =>
					Present_state <= not4;
				WHEN not4 =>
					Present_state <= fetch0;
					
				WHEN ld3 =>
					Present_state <= ld4;
				WHEN ld4 =>
					Present_state <= ld5;
				WHEN ld5 =>
					Present_state <= ld6;
				WHEN ld6 =>
					Present_state <= ld7;
				WHEN ld7 =>
					Present_state <= fetch0;
					
				WHEN ldi3 =>
					Present_state <= ldi4;
				WHEN ldi4 =>
					Present_state <= ldi5;
				WHEN ldi5 =>
					Present_state <= fetch0;
					
				WHEN ldr2 =>
					Present_state <= ldr3;
				WHEN ldr3 =>
					Present_state <= ldr4;
				WHEN ldr4 =>
					Present_state <= ldr5;
				WHEN ldr5 =>
					Present_state <= ldr6;
				WHEN ldr6 =>
					Present_state <= fetch0;
					
				WHEN st3 =>
					Present_state <= st4;
				WHEN st4 =>
					Present_state <= st5;
				WHEN st5 =>
					Present_state <= st6;
				WHEN st6 =>
					Present_state <= fetch0;
					
				WHEN str3 =>
					Present_state <= st4;
				WHEN str4 =>
					Present_state <= st5;
				WHEN str5 =>
					Present_state <= st6;
				WHEN str6 =>
					Present_state <= fetch0;
					
				WHEN mfhi3 =>
					Present_state <= fetch0;
					
				WHEN mflo3 =>
					Present_state <= fetch0;
					
				WHEN in3 =>
					Present_state <= fetch0;
				
				WHEN out3 =>
					Present_state <= fetch0;
					
				---------------------------------------------------------------
				
				WHEN fetch3 => -- do cases based on opcode and set the new state
					CASE IR(31 DOWNTO 27) IS
						WHEN "00101" => -- this is the add instruction
							Present_state <= add3;
						WHEN "00110" => -- this is the sub instruction
							Present_state <= sub3;
						WHEN "10000" => -- this is the mul instruction
							Present_state <= mul3;
						WHEN "00111" => -- this is the and instruction
							Present_state <= and3;
						WHEN "01000" => -- this is the or instruction
							Present_state <= or3;
						WHEN "10001" => -- this is the div instruction
							Present_state <= div3;
						WHEN "01110" => -- this is the andi instruction
							Present_state <= andi3;
						WHEN "01111" => -- this is the ori instruction
							Present_state <= ori3;
						WHEN "10100" => -- this is the branch instruction
							Present_state <= branch3;
						WHEN "10101" => -- this is the jr instruction
							Present_state <= jr3;
						WHEN "10110" => -- this is the jr instruction
							Present_state <= jal3;
						WHEN "10111" => -- this is the in instruction
							Present_state <= in3;
						WHEN "11001" => -- this is the in instruction
							Present_state <= mfhi3;
						WHEN "11010" => -- this is the in instruction
							Present_state <= mflo3;
						WHEN "01001" => -- this is the shr instruction
							Present_state <= shr3;
						WHEN "01010" => -- this is the shl instruction
							Present_state <= shl3;
						WHEN "01011" => -- this is the ror instruction
							Present_state <= ror3;
						WHEN "01100" => -- this is the rol instruction
							Present_state <= rol3;
						
						WHEN "10010" => -- this is the neg instruction
							Present_state <= neg3;
						WHEN "10011" => -- this is the not instruction
							Present_state <= not3;
						WHEN "00000" => -- this is the ld instruction
							Present_state <= ld3;
						----------------------- CHANGE BACK!!! -------------------------	
						WHEN "00001" => -- this is the ldi instruction
							Present_state <= ldi3;
						WHEN "00011" => -- this is the ldr instruction
							Present_state <= ldr2;
						WHEN "01101" => -- this is the addi instruction
							Present_state <= addi3;
						WHEN "11000" => -- this is the out instruction
							Present_state <= out3;
						WHEN "00010" => -- this is the st instruction
							Present_state <= st3;
						WHEN "00100" => -- this is the str instruction
							Present_state <= str3;
						WHEN "11011" => -- this is the nop instruction
							Present_state <= fetch0;
						WHEN "11100" => -- this is the halt instruction
							Present_state <= halt;
						WHEN OTHERS =>
					END CASE;
				WHEN halt =>
				WHEN OTHERS =>
			END CASE;
		END IF;
	END PROCESS;
	
	PROCESS (Present_state, con_ff) -- do the job for each state
	BEGIN
		Gra <= '0'; -- initialize the signals
		Grb <= '0';
		Grc <= '0';
		BAout <= '0';
		Rin <= '0';
		Rout <= '0';
		
		IncPC <= '0';
		
		MDRRead <= '0';
		MDRWrite <= '0';
		
		OpCodeOut <= "00000";
		
		HIout <= '0';
		LOout <= '0';
		Zhighout <= '0';
		Zlowout <= '0';
		PCout <= '0';
		MDRout <= '0';
		Inportout <= '0';
		Cout <= '0';
		
		HIin <= '0';
		LOin <= '0';
		PCin <= '0';
		IRin <= '0';
		MDRin <= '0';
		MARin <= '0';
		Yin <= '0';
		Zin <= '0';
		Inin <= '0';
		Outin <= '0';
		CONin <= '0';

		CASE Present_state IS -- assert the signals we need to
			WHEN reset_state0 =>
				clear <= '0';
				run <= '0';
			WHEN reset_state1 => -- use this cycle to set the reset for all registers back to 1 (ie. reenable them) and set run to 1
				clear <= '1';
				run <= '1';
			WHEN fetch0 =>
				Zin <= '1';
				PCout <= '1';
				MARin <= '1';
				IncPC <= '1';
			WHEN fetch1 =>
				Zlowout <= '1';
				PCin <= '1';
				MDRRead <= '1';
				MDRin <= '1';
			WHEN fetch2 =>
				MDRout <= '1';
				IRin <= '1';
			WHEN fetch3 =>
			WHEN add3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN add4 =>
				Rout <= '1';
				Grc <= '1';
				opCodeOut <= "00101";
				Zin <= '1';
			WHEN add5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';
-------------------------------------------------------
			WHEN sub3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN sub4 =>
				Rout <= '1';
				Grc <= '1';
				opCodeOut <= "00110";
				Zin <= '1';
			WHEN sub5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';
				
			WHEN mul3 =>
				Rout <= '1';
				Gra<= '1';
				Yin <= '1';
			WHEN mul4 =>
				Rout <= '1';
				Grb <= '1';
				opCodeOut <= "10000";
				Zin <= '1';
			WHEN mul5 =>
				Zlowout <= '1';
				LOin <= '1';
			WHEN mul6 =>
				Zhighout <= '1';
				HIin <= '1';
				
			WHEN and3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN and4 =>
				Rout <= '1';
				Grc <= '1';
				opCodeOut <= "00111";
				Zin <= '1';
			WHEN and5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';
				
			WHEN or3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN or4 =>
				Rout <= '1';
				Grc <= '1';
				opCodeOut <= "01000";
				Zin <= '1';
			WHEN or5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';
				
				
			WHEN div3 =>
				Rout <= '1';
				Gra<= '1';
				Yin <= '1';
			WHEN div4 =>
				Rout <= '1';
				Grb <= '1';
				opCodeOut <= "10001";
				Zin <= '1';
			WHEN div5 =>
				Zlowout <= '1';                 ----wait for instruction to complete control signal?
				LOin <= '1';
			WHEN div6 =>
				Zhighout <= '1';
				HIin <= '1';
			----------------------------------
			WHEN shr3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN shr4 =>
				Rout <= '1';
				Grc <= '1';
				opCodeOut <= "01001";
				Zin <= '1';
			WHEN shr5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';
				
			WHEN shl3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN shl4 =>
				Rout <= '1';
				Grc <= '1';
				opCodeOut <= "01010";
				Zin <= '1';
			WHEN shl5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';
				
			WHEN ror3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN ror4 =>
				Rout <= '1';
				Grc <= '1';
				opCodeOut <= "01011";
				Zin <= '1';
			WHEN ror5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';
				
			WHEN rol3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN rol4 =>
				Rout <= '1';
				Grc <= '1';
				opCodeOut <= "01100";
				Zin <= '1';
			WHEN rol5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';
				
			WHEN neg3 =>
				Rout <= '1';
				Grb <= '1';
				opCodeOut <= "10010";
				Zin <= '1';
			WHEN neg4 =>
				Zlowout <= '1';
				Gra <= '1';
				Rin <= '1';
				
			WHEN not3 =>
				Rout <= '1';
				Grb <= '1';
				opCodeOut <= "10011";
				Zin <= '1';
			WHEN not4 =>
				Zlowout <= '1';
				Gra <= '1';
				Rin <= '1';
				
			WHEN out3 =>
			
				Gra <= '1';
				Rout <= '1';
				Outin <= '1';
			
			------------------------------------------------	
			WHEN andi3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN andi4 =>
				Cout <= '1';
				opCodeOut <= "00111";
				Zin <= '1';
			WHEN andi5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';	
				
			WHEN ori3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN ori4 =>
				Cout <= '1';
				opCodeOut <= "01000";
				Zin <= '1';
			WHEN ori5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';	
				
				
			WHEN addi3 =>
				Rout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN addi4 =>
				Cout <= '1';
				opCodeOut <= "00101";
				Zin <= '1';
			WHEN addi5 =>
				Zlowout <= '1';
				Rin <= '1';
				Gra <= '1';	
				
			WHEN branch3 =>
				Rout <= '1';
				Gra <= '1';
				CONin <= '1';
			WHEN branch4 =>
				Grb <= '1';
				Rout <= '1';
				if(CON_FF = '1') then
					PCin <= '1';
				end if;
				
			WHEN jr3 =>
				Rout <= '1';
				Gra <= '1';
				PCin <= '1';
				
			WHEN jal3 =>
				Rin <= '1';
				Grb <= '1';
				PCout <= '1';
				
			WHEN jal4 =>
				Rout <= '1';
				Gra <= '1';
				PCin <= '1';
				
				
				
			WHEN in3 =>
				Rin <= '1';
				Gra <= '1';
				inportout <= '1';
				
			WHEN mfhi3 =>
				Rin <= '1';
				Gra <= '1';
				HIout <= '1';
				
			WHEN mflo3 =>
				Rin <= '1';
				Gra <= '1';
				LOout<= '1';
			
			
			WHEN ld3 =>
				BAout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN ld4 =>
				Cout <= '1';
				opCodeOut <= "00101";
				Zin <= '1';
			WHEN ld5 =>
				Zlowout <= '1';
				MARin <= '1';
			WHEN ld6 =>
				MDRRead <= '1';
				MDRin <= '1';
			WHEN ld7 =>
				MDRout <= '1';
				Gra <= '1';
				Rin <= '1';
			
			
			
			WHEN ldi3 =>
				BAout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN ldi4 =>
				Cout <= '1';
				opCodeOut <= "00101";
				Zin <= '1';
			WHEN ldi5 =>
				Zlowout <= '1';
				Gra <= '1';
				Rin <= '1';
				
			WHEN ldr2 =>
				PCout <= '1';
				Yin <= '1';
			WHEN ldr3 =>
				Cout <= '1';
				opCodeOut <= "00101";
				Zin <= '1';
			WHEN ldr4 =>
				Zlowout	<= '1';
				MARin <= '1';
			WHEN ldr5 =>
				MDRRead <= '1';
				MDRin <= '1';
			WHEN ldr6 =>
				MDRout <= '1';
				Gra <= '1';
				Rin <= '1';
			
			
			WHEN st3 =>
				BAout <= '1';
				Grb <= '1';
				Yin <= '1';
			WHEN st4 =>
				Cout <= '1';
				opCodeOut <= "00101";
				Zin <= '1';
			WHEN st5 =>
				Zlowout <= '1';
				MARin <= '1';
			WHEN st6 =>
				MDRWrite <= '1';
				Gra <= '1';
				Rout <= '1';
				MDRin <= '1';
				
			WHEN str3 =>
				PCout <= '1';
				Yin <= '1';
			WHEN str4 =>
				Cout <= '1';
				opCodeOut <= "00101";
				Zin <= '1';
			WHEN str5 =>
				Zlowout <= '1';
				MARin <= '1';
			WHEN str6 =>
				MDRWrite <= '1';
				Gra <= '1';
				Rout <= '1';
				MDRin <= '1';
		----------------------			
			WHEN nop =>
			WHEN halt =>
				run <= '0';
			WHEN OTHERS =>
		END CASE;
	END PROCESS;
END Behavior;