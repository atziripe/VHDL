LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY FFD IS
PORT(D, CLK, CLR, PRE : IN STD_LOGIC;
     Q, NQ : OUT STD_LOGIC
);
END ENTITY;

ARCHITECTURE A_FFD OD FFD IS
BEGIN
 PROCESS(CLR, PRE, CLK, D)
 BEGIN
 IF(CLR = '0') THEN
   Q <= '0';
   NQ <= '1';
 ELSIF(CLK'EVENT AND CLK='1') THEN
   IF(PRE='1') THEN
      Q <= '1';
      NQ <= '0';
   ELSIF(D='0') THEN
      Q <= '0';
      NQ <= '1';
   ELSIF(D='1') THEN
      Q <= '1';
      NQ <= '0';
   END IF;
 END IF;
 END PROCESS;
END A_FFD;