
library IEEE;
use ieee.std_logic_1164.all;

entity conversorHex7SegU is
    port
    (
        -- Input ports
        NUM : in  std_logic_vector(7 downto 0);
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

	 SWinteiro <= to_integer(unsigned(SW)) rem 10;

    rascSaida7seg <=    "1000000" when SWinteiro=0 else ---0
                            "1111001" when SWinteiro=1 else ---1
                            "0100100" when SWinteiro=2 else ---2
                            "0110000" when SWinteiro=3 else ---3
                            "0011001" when SWinteiro=4 else ---4
                            "0010010" when SWinteiro=5 else ---5
                            "0000010" when SWinteiro=6 else ---6
                            "1111000" when SWinteiro=7 else ---7
                            "0000000" when SWinteiro=8 else ---8
                            "0010000" when SWinteiro=9 else ---9
                            "1111111"; -- Apaga todos segmentos.

    HEX0 <= rascSaida7seg;
end architecture;