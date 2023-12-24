library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity main is
    port (
        CLK : IN STD_LOGIC;
        ENABLE : IN STD_LOGIC;
        PLAIN_CODE : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        KEY_INPUT : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
        OUPUT : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
    );
end entity main;

architecture rtl of main is

    COMPONENT inputdata is
        port (
            PRG_CNT : in integer; -- Program counter
            INTITIAL_KEY : in std_logic_vector(63 downto 0); -- Initial key for encryption
            PLAIN_TEXT : in std_logic_vector(63 downto 0); -- Code to be encrypted
            KEY : out std_logic_vector(63 downto 0);
            OUT_CODE : out std_logic_vector(63 downto 0) -- Address of third operand
        );
    end COMPONENT inputdata;

    COMPONENT initpermutation is
        port (
            PC : IN INTEGER;
            KEY : in std_logic_vector(63 downto 0); -- Initial key for encryption
            CODE : in std_logic_vector(63 downto 0);
            PERMUTATED_KEY : out std_logic_vector(55 downto 0);
            PERMUTATED_CODE : out std_logic_vector(63 downto 0)
        );
    end COMPONENT initpermutation;

    COMPONENT encyphering is
        port (
            PC : IN INTEGER;
            KEY : in std_logic_vector(55 downto 0); -- Initial key for encryption
            CODE : in std_logic_vector(63 downto 0);
            LPT_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            RE_OUT : OUT STD_LOGIC_VECTOR(47 DOWNTO 0)
        );
    end COMPONENT encyphering;

    COMPONENT finalparsing is
        port (
            PC : IN INTEGER;
            LPT2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            RE : IN STD_LOGIC_VECTOR(47 DOWNTO 0);
            CYPHERTEXT : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
        );
    end COMPONENT finalparsing;
    
    --SIGNAL AND VARIABLE
    SIGNAL PC : INTEGER := 0;
    SIGNAL INPUTDATA_KEY_IN : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL INPUTDATA_CODE_IN : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL INPUTDATA_KEY_OUT : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL INPUTDATA_CODE_OUT : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL P_INPUTDATA_KEY_OUT : STD_LOGIC_VECTOR(55 DOWNTO 0);
    SIGNAL P_INPUTDATA_CODE_OUT : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL CYPHERTEXT_FINISH : STD_LOGIC_VECTOR(63 DOWNTO 0);
    SIGNAL LPT_OUT_A : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RE_OUT_A : STD_LOGIC_VECTOR(47 DOWNTO 0);
    --MAKE TYPE FOR STATE
    TYPE stateType IS (IDLE, FETCH, DECODE, EXECUTE, COMPLETE);
    SIGNAL currentState : stateType := IDLE;

begin
    --PORT MAP
    inputdata_PM : inputdata PORT MAP(PC, INPUTDATA_KEY_IN, INPUTDATA_CODE_IN, INPUTDATA_KEY_OUT, INPUTDATA_CODE_OUT);
    initpermutation_PM : initpermutation PORT MAP(PC, INPUTDATA_KEY_OUT, INPUTDATA_CODE_OUT, P_INPUTDATA_KEY_OUT, P_INPUTDATA_CODE_OUT);
    encyphering_PM : encyphering PORT MAP(PC, P_INPUTDATA_KEY_OUT, P_INPUTDATA_CODE_OUT, LPT_OUT_A, RE_OUT_A);
    finalparsing_PM : finalparsing PORT MAP(PC, LPT_OUT_A, RE_OUT_A, CYPHERTEXT_FINISH);
    
    PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            CASE currentState IS
                WHEN IDLE =>
                    PC <= PC + 1;
                    IF enable = '1' THEN
                        currentState <= FETCH;
                    ELSE
                        currentState <= IDLE;
                    END IF;
                WHEN FETCH =>
                    PC <= PC + 1;
                    currentState <= DECODE;
                WHEN DECODE =>
                    PC <= PC + 1;
                    INPUTDATA_KEY_IN <= KEY_INPUT;
                    INPUTDATA_CODE_IN <= PLAIN_CODE;
                    currentState <= EXECUTE;
                WHEN EXECUTE =>
                    PC <= PC + 1;
                    currentState <= COMPLETE;
                WHEN COMPLETE =>
                    REPORT "BERHASIL CUYY";
                    PC <= PC + 1;
                    OUPUT <= CYPHERTEXT_FINISH;
                    currentState <= IDLE;   
            END CASE;
        END IF;
    END PROCESS;
    
end architecture rtl;