LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY FFD IS 
PORT(
		S, R, J, K, T, D: IN STD_LOGIC;
		CLK,CLR,PRE: IN STD_LOGIC;
		SEL: IN STD_LOGIC_VECTOR(0 TO 1);
		DISPLAY: OUT STD_LOGIC_VECTOR(0 TO 6)
	);
END ENTITY;

ARCHITECTURE A_FFD OF FFD IS
SIGNAL QSR, QJK, QT, QD: STD_LOGIC;
SIGNAL SAL: STD_LOGIC;
--SIGNAL NQSR, NQJK, NQT, NQD: STD_LOGIC;
CONSTANT DISPLAY0: STD_LOGIC_VECTOR(0 TO 6):="0000001";
CONSTANT DISPLAY1: STD_LOGIC_VECTOR(0 TO 6):="1001111";
BEGIN
--===================Flip Flop SR==================
	FlipFlopSR:PROCESS(CLR, PRE, CLK, S, R)
	BEGIN
		IF(CLR='0') THEN
			QSR <= '0';
			--NQSR <= '1';
		ELSIF(CLK'EVENT AND CLK='1') THEN
			IF(PRE='1') THEN
				QSR <= '1';
				--NQSR <= '0';
			ELSE
				QSR <= (QSR AND (NOT R)) OR S;
			END IF;
		END IF;
	END FlipFlopSR;

	--===================Flip Flop JK==================
	FlipFlopJK:PROCESS(CLR, PRE, CLK, J, K)
	BEGIN
		IF(CLR='0') THEN
			QJK <= '0';
			--NQJK <= '1';
		ELSIF(CLK'EVENT AND CLK='1') THEN
			IF(PRE='1') THEN
				QJK <= '1';
				--NQJK <= '0';
			ELSE
				QJK <= ((NOT QJK)AND J) OR ((NOT K)AND QJK); 
			END IF;
		END IF;
	END FlipFlopJK;

--===================Flip Flop T==================
	FlipFlopT:PROCESS(CLR, PRE, CLK, T)
	BEGIN
		IF(CLR='0') THEN
			QT <= '0';
			--NQT <= '1';
		ELSIF(CLK'EVENT AND CLK='1') THEN
			IF(PRE='1') THEN
				QT <= '1';
				--NQT <= '0';
			ELSE
				QT <= T XOR QT;
			END IF;
		END IF;
	END FlipFlopT;

--===================Flip Flop D==================
	FlipFlopD:PROCESS(CLR, PRE, CLK, D)
	BEGIN
		IF(CLR='0') THEN
			QD <= '0';
			--NQD <= '1';
		ELSIF(CLK'EVENT AND CLK='1') THEN
			IF(PRE='1') THEN
				QD <= '1';
				--NQD <= '0';
			ELSE
				QD <= D;
			END IF;
		END IF;
	END FlipFlopD;

--=====================MUX================
	MUX: PROCESS(SEL,QD,QT,QSR,QJK)
	BEGIN
		CASE SEL IS
		WHEN "00" => SAL <= QSR;
		WHEN "01" => SAL <= QJK;
		WHEN "10" => SAL <= QT;
		WHEN OTHER => SAL <= QD;
	END CASE;
	END PROCESS;

--=============DECODIFICACION===============
	DECOD: PROCESS(SAL)
	BEGIN
		IF(SAL='0') THEN
			DISPLAY <= DISPLAY0;
		ELSE
			DISPLAY <= DISPLAY1;
		END IF;
	END CASE;
	END PROCESS;
END A_FFD;
