LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY ABCD IS
PORT(
	A,B,C,D,SEL,REF:IN STD_LOGIC_VECTOR(0 TO 1);
    DISPLAY1:OUT STD_LOGIC_VECTOR(0 TO 6);
	Z1:INOUT STD_LOGIC_VECTOR(0 TO 1)
);
ATTRIBUTE PIN_NUMBERS OF ABCD : ENTITY IS
        "Display1(0):18 "   &   
        "Display1(1):21 "   &   
        "Display1(2):20 "   &   
        "Display1(3):17 "   &   
        "Display1(4):16 "   &   
        "Display1(5):22 "   &   
        "Display1(6):15 "   & 
        "Z1(0):23"          &   
	"Z1(1):14 "          & 
	"A(0):13 "          & 
        "A(1):11 "          &   
        "B(0):10 "          &   
        "B(1):9 "          &
        "C(0):8 "          &   
        "C(1):7 "          &   
	"D(0):6 "          &   
        "D(1):5 "          &
        "REF(0):4 "  &   
        "REF(1):3 "  &   
        "SEL(0):2 " &   
        "SEL(1):1"; 
END ABCD;

ARCHITECTURE A_ABCD OF ABCD IS
   --SIGNAL SAL: STD_LOGIC_VECTOR(2 DOWNTO 0);
   CONSTANT IGUAL: STD_LOGIC_VECTOR(0 TO 6):="0110111";
   CONSTANT MAYOR: STD_LOGIC_VECTOR(0 TO 6):="0000111";
   CONSTANT MENOR: STD_LOGIC_VECTOR(0 TO 6):="0110001";

   BEGIN
   MUX: PROCESS(SEL,A,B,C,D)
	BEGIN
	CASE SEL IS
	   WHEN "00" => Z1 <= A;
	   WHEN "01" => Z1 <= B;
	   WHEN "10" => Z1 <= C;
	   WHEN OTHERS =>Z1 <= D;
	END CASE;
   END PROCESS MUX;

   PROCESS(Z1, REF)
   begin
	IF(Z1=REF) THEN
	   DISPLAY1 <= IGUAL;
	ELSIF(Z1>REF) THEN
 	   DISPLAY1 <= MAYOR;
	ELSE
	   DISPLAY1 <= MENOR;
	END IF;
   END PROCESS;
END A_ABCD;
