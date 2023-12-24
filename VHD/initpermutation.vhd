library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity initpermutation is
    port (
        PC : IN INTEGER;
        KEY : in std_logic_vector(63 downto 0); -- Initial key for encryption
        CODE : in std_logic_vector(63 downto 0);
        PERMUTATED_KEY : out std_logic_vector(55 downto 0);
        PERMUTATED_CODE : out std_logic_vector(63 downto 0)
    );
end entity initpermutation;

architecture rtl of initpermutation is
    
begin
    PERMUTATION_PROC : process(PC)
    begin 
        PERMUTATED_KEY <= KEY(56) & KEY(48) & KEY(40) & KEY(32) & KEY(24) & KEY(16) & KEY(8) & KEY(0)
                            & KEY(57) & KEY(49) & KEY(41) & KEY(33) & KEY(25) & KEY(19) 
                            & KEY(9) & KEY(1) & KEY(58) & KEY(50) & KEY(42) & KEY(34) & KEY(26) & KEY(18) 
                            & KEY(10) & KEY(2) & KEY(59) & KEY(51) & KEY(43) & KEY(35) 
                            & KEY(62) & KEY(54) & KEY(46) & KEY(38)& KEY(30) & KEY(22) & KEY(14) & KEY(6) 
                            & KEY(61) & KEY(53) & KEY(45) & KEY(37)& KEY(29) & KEY(21) 
                            & KEY(13) & KEY(5) & KEY(60) & KEY(52) & KEY(44) & KEY(36) & KEY(28) & KEY(20) 
                            & KEY(12) & KEY(4) & KEY(27) & KEY(19) & KEY(11) & KEY(3);

        PERMUTATED_CODE <= CODE(57) & CODE(49) & CODE(41) & CODE(33) & CODE(25) & CODE(17) & CODE(9) & CODE(1) 
                            & CODE(59) & CODE(51) & CODE(43) & CODE(35) & CODE(27) & CODE(19) & CODE(11) & CODE(3)
                            & CODE(61) & CODE(53) & CODE(45) & CODE(37) & CODE(29) & CODE(21) & CODE(13) & CODE(5)
                            & CODE(63) & CODE(55) & CODE(47) & CODE(39) & CODE(31) & CODE(23) & CODE(15) & CODE(7)
                            & CODE(56) & CODE(48) & CODE(40) & CODE(32) & CODE(24) & CODE(16) & CODE(8) & CODE(0)
                            & CODE(58) & CODE(50) & CODE(42) & CODE(34) & CODE(26) & CODE(18) & CODE(10) & CODE(2)
                            & CODE(60) & CODE(52) & CODE(44) & CODE(36) & CODE(28) & CODE(20) & CODE(12) & CODE(4)
                            & CODE(62) & CODE(54) & CODE(46) & CODE(38) & CODE(30) & CODE(22) & CODE(14) & CODE(6);
    end process;
    
end architecture rtl;