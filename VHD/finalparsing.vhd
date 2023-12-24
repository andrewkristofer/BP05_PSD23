library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity finalparsing is
    port (
        PC : IN INTEGER;
        LPT2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RE : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
        CYPHERTEXT : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
end entity finalparsing;

architecture rtl of finalparsing is
    
begin
    PROC : PROCESS (PC)
    BEGIN
        CYPHERTEXT <= RE(31 DOWNTO 0) & LPT2;
    END PROCESS;
    
    
end architecture rtl;