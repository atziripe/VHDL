LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY RU8 IS
PORT(
		CLK, CLR, CD, CI : IN STD_LOGIC;
		C: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		DATO: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Q: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
ATTRIBUTE PIN_NUMBERS OF ABCD : ENTITY IS
        "Q(0):23 " &   
        "Q(1):22 " &   
        "Q(2):21 " &   
        "Q(3):20 " &   
        "Q(4):19 " &   
        "Q(5):18 " &   
        "Q(6):17 " &
	"Q(7):16 " & 
	"DATO(0):15 " &
        "DATO(1):14 " &
	"DATO(2):13 " &
        "DATO(3):11 " &
        "DATO(4):10 "  &
        "DATO(5):9 " &
        "DATO(6):8 " &
        "DATO(7):7 " &
	"C(0):6 " &
        "C(1):5 " &
        "CI:4 " &   
        "CD:3 " &   
        "CLR:2 " &   
        "CLK:1"; 
END ENTITY;

ARCHITECTURE A_RU8 OF RU8 IS
--	SIGNAL Z: STD_LOGIC_VECTOR(7 DOWNTO 0);
	BEGIN
	
	PROCESS(CLK, CLR)
	BEGIN
		IF(CLR = '0') THEN
			Q <= "00000000";
		ELSIF(CLK'EVENT AND CLK='1') THEN
			CASE C IS
				WHEN "00" => Q <= DATO;
				WHEN "01" => Q <= Q;
				WHEN "10" =>
							 CICLO1: FOR I IN 7 DOWNTO 0 LOOP
								IF(I=7) THEN
									Q(I) <= CD;
								ELSE
									Q(I) <= Q(I+1);
								END IF;
							 END LOOP;
				WHEN OTHERS =>
							 CICLO2: FOR I IN 7 DOWNTO 0 LOOP
								IF(I=0) THEN
									Q(I) <= CI;
								ELSE
									Q(I) <= Q(I-1);
								END IF;
							 END LOOP;
			END CASE;
		END IF;
	END PROCESS;
END ARCHITECTURE;
