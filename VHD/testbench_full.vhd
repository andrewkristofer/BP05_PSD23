library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench_full is
end entity testbench_full;

architecture tb_arch of testbench_full is
    constant CLK_PERIOD : time := 10 ns; -- Periode clock
    signal CLK : std_logic := '0'; -- Sinyal clock
    signal ENABLE : std_logic := '1'; -- Sinyal enable (misalnya, aktif)
    signal PLAIN_CODE : std_logic_vector(63 downto 0) := (others => '0'); -- Contoh plain code
    signal KEY_INPUT : std_logic_vector(63 downto 0) := (others => '0'); -- Contoh key input
    signal OUTPUT_SIGNAL : std_logic_vector(63 downto 0); -- Sinyal output

 
    COMPONENT main
        port (
            CLK : IN STD_LOGIC;
            ENABLE : IN STD_LOGIC;
            PLAIN_CODE : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
            KEY_INPUT : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
            OUPUT : OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
        );
    END COMPONENT;

begin
    
    main_inst : main
        port map (
            CLK => CLK,
            ENABLE => ENABLE,
            PLAIN_CODE => PLAIN_CODE,
            KEY_INPUT => KEY_INPUT,
            OUPUT => OUTPUT_SIGNAL
        );

    clk_process: process
    begin
        wait for CLK_PERIOD / 2;
        CLK <= not CLK;
    end process clk_process;

    main_process: process
    begin
    
        -- RESET
        ENABLE <= '0';
        PLAIN_CODE <= (others => '0');
        KEY_INPUT <= (others => '0');
        wait for 10 ns;

        ENABLE <= '1'; -- Aktifkan
        PLAIN_CODE <= "1010101010101010101010101010101010101010101010101010101010101010";
        KEY_INPUT <= "1100110011001100110011001100110011001100110011001100110011001100";
        wait for 100 ns;
        assert FALSE report "Simulasi Testbench Berhasil!" severity FAILURE;
    end process main_process;

end architecture tb_arch;
