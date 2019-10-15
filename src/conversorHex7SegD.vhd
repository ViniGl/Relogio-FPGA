
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conversorHex7SegD is
    port
    (
		clk : in std_logic;
		-- Input ports
		NUM : in  std_logic_vector(7 downto 0);
		enable : in std_logic_vector(2 downto 0);
		-- Output ports
		HEXSeg : out std_logic_vector(6 downto 0);  -- := (others => '1')
		HEXMin : out std_logic_vector(6 downto 0); -- := (others => '1')
		HEXHour : out std_logic_vector(6 downto 0)	-- := (others => '1')
    );
end entity;

architecture comportamento of conversorHex7SegD is
   --
   --       0
   --      ---
   --     |   |
   --    5|   |1
   --     | 6 |
   --      ---
   --     |   |
   --    4|   |2
   --     |   |
   --      ---
   --       3
   --
    signal rascSaida7: std_logic_vector(6 downto 0);
	 
	 signal SWinteiro : integer range 0 to 59;
	 
begin
	 
	 SWinteiro <= to_integer(unsigned(NUM)) / 10;

	 rascSaida7 <=    "1000000" when SWinteiro=0  else ---0
									 "1111001" when SWinteiro=1 else ---1
									 "0100100" when SWinteiro=2 else ---2
									 "0110000" when SWinteiro=3 else ---3
									 "0011001" when SWinteiro=4 else ---4
									 "0010010" when SWinteiro=5 else ---5
									 "0000010" when SWinteiro=6 else ---6
									 "1111000" when SWinteiro=7 else ---7
									 "0000000" when SWinteiro=8 else ---8
									 "0010000" when SWinteiro=9 else  ---9
									 "1111111"; -- Apaga todos segmentos.
											 

	process(clk)
		begin
			if(enable = "011") then
				if(rising_edge(clk)) then
					HEXSeg <= rascSaida7;
				end if;
			elsif(enable = "101") then
				if(rising_edge(clk)) then
					HEXMin <= rascSaida7;
				end if;
			elsif(enable = "110") then
				if(rising_edge(clk)) then
					HEXHour <= rascSaida7;
				end if;
			end if;
	end process;
end architecture;