
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conversorHex7SegU is
    port
    (
	 	 clk : in std_logic;

        -- Input ports
        NUM : in  std_logic_vector(7 downto 0);
		enable_seg : in std_logic;
        -- Output ports
        HEX0 : out std_logic_vector(6 downto 0)  -- := (others => '1')
    );
end entity;

architecture comportamento of conversorHex7SegU is
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
    signal rascSaida7seg: std_logic_vector(6 downto 0);
	 
	 signal SWinteiro : integer range 0 to 59;
	 
begin
	 
		 --if(enable_seg = '1') then
			 SWinteiro <= to_integer(unsigned(NUM)) rem 10;

			 rascSaida7seg <=    "1000000" when SWinteiro=0 AND enable_seg = '1' else ---0
											 "1111001" when SWinteiro=1 AND enable_seg = '1' else ---1
											 "0100100" when SWinteiro=2 AND enable_seg = '1' else ---2
											 "0110000" when SWinteiro=3 AND enable_seg = '1' else ---3
											 "0011001" when SWinteiro=4 AND enable_seg = '1' else ---4
											 "0010010" when SWinteiro=5 AND enable_seg = '1' else ---5
											 "0000010" when SWinteiro=6 AND enable_seg = '1' else ---6
											 "1111000" when SWinteiro=7 AND enable_seg = '1' else ---7
											 "0000000" when SWinteiro=8 AND enable_seg = '1' else ---8
											 "0010000" when SWinteiro=9 AND enable_seg = '1' else  ---9
											 "1111111"; -- Apaga todos segmentos.
											 

		process(clk)
		begin
			if(rising_edge(clk)) then
				if(enable_seg = '1') then
			 HEX0 <= rascSaida7seg;
			 end if;
		 end if;
	 end process;
end architecture;