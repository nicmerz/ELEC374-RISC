# ELEC374-RISC

#### RegEnable Numbers (which bits in RegEnable correspond to which registers' load enables)

0 - 15: Registers 0 - 15, respectively
16: HI
17: LO
18: PC
19: IR
20: MDR
21: MAR
22: Yin
23: Zin

#### EncoderIn Numbers (which bits in EncoderIn correspond to which input is selected in the BusMux)
0 - 15: Registers 0 - 15, respectively
16: BusMuxIn_HI
17: BusMuxIn_LO
18: BusMuxIn_Zhigh
19: BusMuxIn_Zlow
20: BusMuxIn_PC
21: BusMuxIn_MDR
22: BusMuxIn_Inport
23: C_sign_extended
24: dummyInput