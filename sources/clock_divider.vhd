----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.math_real.all;
use IEEE.std_logic_unsigned.all;

entity clock_divider is
    generic(f_in : natural := 100E6; --fin = 100MHz
            f_out: natural := 1   --fout = 1MHz
    );
    port(
        clk: in std_logic;
        f_o: out std_logic
    );
end clock_divider;

architecture Behavioral of clock_divider is
--Signal/constant/component declarations
constant count_max: natural := integer(round(real(f_in)/real(f_out)));
constant n: integer := integer(ceil(log2(real(f_in)/real(f_out))));
signal count: std_logic_vector(n - 1 downto 0) := (others => '1');
signal eq_max: std_logic;
begin
    eq_max <= '1' when (count = count_max - 1) else '0';
    process(clk)
    begin
        if (rising_edge(clk)) then
            if (eq_max = '0') then
                count <= count+1;
            else
                count <= (others => '0');
            end if;
        end if;
    end process;
    f_o <= '1' when (count < count_max/2) else '0';
end Behavioral;
