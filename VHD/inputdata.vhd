library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inputdata is
    port (
        PRG_CNT : in integer; -- Program counter
        INTITIAL_KEY : in std_logic_vector(63 downto 0); -- Initial key for encryption
        PLAIN_TEXT : in std_logic_vector(63 downto 0); -- Code to be encrypted
        KEY : out std_logic_vector(63 downto 0);
        OUT_CODE : out std_logic_vector(63 downto 0) -- Address of third operand
    );
end entity inputdata;

architecture rtl of inputdata is

begin
    INPUT_PROC : process(PRG_CNT)
    begin 
        KEY <= INTITIAL_KEY(63 downto 0);
        OUT_CODE <= PLAIN_TEXT(63 downto 0);
    end process;
end architecture rtl;