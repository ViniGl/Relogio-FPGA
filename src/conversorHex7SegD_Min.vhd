
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity conversorHex7SegD_Min is
    port
    (
        -- Input ports
        SW : in  std_logic_vector(7 downto 0);
		  enable_min : in std_logic;
        -- Output ports
        HEX3 : out std_logic_vector(6 downto 0)  -- := (others => '1')
    );
end entity;

architecture comportamento of conversorHex7SegD_Min is
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
	 process(all)
	 begin
		 if(enable_min = '1') then
			 SWinteiro <= to_integer(unsigned(SW)) rem 10;

--			 rascSaida7seg <=    "1000000" when SWinteiro=0 else ---0
--											 "1111001" when SWinteiro=1 else ---1
--											 "0100100" when SWinteiro=2 else ---2
--											 "0110000" when SWinteiro=3 else ---3
--											 "0011001" when SWinteiro=4 else ---4
--											 "0010010" when SWinteiro=5 else ---5
--											 "0000010" when SWinteiro=6 else ---6
--											 "1111000" when SWinteiro=7 else ---7
--											 "0000000" when SWinteiro=8 else ---8
--											 "0010000" when SWinteiro=9 else ---9
--											 "1111111"; -- Apaga todos segmentos.
											 
			 if(SWinteiro=0) then
				 rascSaida7seg <= "1000000";
				 
			 elsif (SWinteiro=1) then
				 rascSaida7seg <= "1111001";
				 
			 elsif (SWinteiro=2) then
				 rascSaida7seg <= "0100100";
				 
			 elsif (SWinteiro=3) then
				 rascSaida7seg <= "0110000";
				 
			 elsif (SWinteiro=4) then
				 rascSaida7seg <= "0011001";
				 
			 elsif (SWinteiro=5) then
				 rascSaida7seg <= "0010010";
				 
			 elsif (SWinteiro=6) then
				 rascSaida7seg <= "0000010";
				 
			 elsif (SWinteiro=7) then
				 rascSaida7seg <= "1111000";
				 
			 elsif (SWinteiro=8) then
				 rascSaida7seg <= "0000000";
				 
			 elsif (SWinteiro=9) then
				 rascSaida7seg <= "0010000";
			 
			 else
				 rascSaida7seg <= "1111111";
			 end if;

			 HEX3 <= rascSaida7seg;
		 end if;
	 end process;
end architecture;