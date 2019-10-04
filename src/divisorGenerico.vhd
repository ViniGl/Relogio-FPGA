LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity divisorGenerico is
  generic (
    divisor : natural := 50000000
  );
  port(
    clk      :   in std_logic;
	 divisorB :   in std_logic_vector(7 downto 0);
    divisorA :   out std_logic_vector(7 downto 0)
  );
end entity;

-- O valor "n" do divisor, define a divisao por "2n".
-- Ou seja, n é metade do período da frequência de saída.

architecture divInteiro of divisorGenerico is
  signal tick : std_logic := '0';
  signal contador : integer range 0 to divisor+1 := 0;
begin
  process(clk)
  begin
    if rising_edge(clk) then
		if (divisorB = "00000001") then
			divisorA <= "00000000";
		end if;
      if contador = divisor then
        contador <= 0;
        tick <= not tick;
		  divisorA <= "00000001";
      else
        contador <= contador + 1;
      end if;
    end if;
  end process;
end architecture divInteiro;