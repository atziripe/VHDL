LIBRARY IEEE;
USE IEEE.STD_LOGIC.1164.ALL;

ENTITY RU8 IS
PORT(
		CLK, CLR, CD, CI : IN STD_LOGIC;
		C: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		DATO: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Q: INOUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE A_RU8 OF RU8 IS
--	SIGNAL Z: STD_LOGIC_VECTOR(7 DOWNTO 0);
	BEGIN
	
	PROCESS(CLK, CLR)
	BEGIN
		IF(CLR = '0') THEN
			Q <= "000";
		ELSIF(CLK'EVENT AND CLK='1') THEN
			CASE C IS
				WHEN "00" => Q <= DATO;
				WHEN "01" => Q <= Q;
				WHEN "10" =>
							 CICLO1: FOR I TO 7 DOWNTO 0 LOOP
								IF(I='7') THEN
									Q(I) <= CD;
								ELSE
									Q(I) <= Q(I+1);
								END IF;
							 END LOOP;
				WHEN OTHERS =>
							 CICLO2: FOR I TO 7 DOWNTO 0 LOOP
								IF(I='0') THEN
									Q(I) <= CI;
								ELSE
									Q(I) <= Q(I-1);
								END IF;
							 END LOOP;
			END CASE;
		END IF;
	END PROCESS;
END ARCHITECTURE;