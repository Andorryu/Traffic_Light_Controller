----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 09:54:42 PM
-- Design Name: 
-- Module Name: traffic_light_controller - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.math_real.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity traffic_light_controller is
port (
	car_ew, car_ns, clk, rst: in std_logic;
	lights: out std_logic_vector(5 downto 0)
);
end traffic_light_controller;

architecture arch of traffic_light_controller is
	type traf_state is
	(GNS, YNS, RNS, GEW, YEW, REW);
	signal current_state, next_state: traf_state;
	signal chosen_state: traf_state;
	signal GNS_next, GEW_next: traf_state;
	signal slow_clk: std_logic;
	signal count: std_logic_vector(3 downto 0) := (others => '0');
    
	component clock_divider is
	generic(f_in : natural := 100E6; --fin = 100MHz - FPGA's clock frequency
        	f_out: natural := 1   --fout = 1Hz
	);
	port(
    	clk: in std_logic;
    	f_o: out std_logic
	);
end component;
begin
	-- clock divider
	CD: clock_divider port map(clk => clk, f_o => slow_clk);
	-- d FF
	dFF: process(slow_clk)
	begin
    	if (rising_edge(slow_clk)) then
        	if (count = "0101") then
            	count <= "0000";
            	current_state <= next_state;
        	else
            	count <= count+1;
        	end if;
    	end if;
	end process;
	-- Next State Logic
	with rst select
    	next_state <= GNS when '1',
                  	chosen_state when others;
	with car_ew select
    	GNS_next <= YNS when '1',
                	GNS when others;
	with car_ns select
    	GEW_next <= YEW when '1',
                	GEW when others;
	with current_state select
    	chosen_state <= GNS_next when GNS,
                    	RNS when YNS,
                    	GEW when RNS,
                    	GEW_next when GEW,
                    	REW when YEW,
                    	GNS when others;
	-- Output Logic (Moore)
	with current_state select
    	lights <= "100001" when GNS,
              	"010001" when YNS, -- "101001" for RGB
              	"001100" when GEW,
              	"001010" when YEW, -- "001101" for RGB
              	"001001" when others;
end arch;

