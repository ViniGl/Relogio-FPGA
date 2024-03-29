LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity divisorGenerico is
  generic (
    divisor : natural := 50000000;
	 divisor2 : natural := 5000000;
	 divisor3 : natural := 1000000;
	 divisor4 : natural := 10000
  );
  port(
    clk      :   in std_logic;
	 Y : out std_logic;
	 rst : in std_logic_vector(2 downto 0);
	 SW  : in STD_LOGIC_VECTOR(17 DOWNTO 0) := (others => '0')
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
		if (SW(17) = '0' and SW(16) = '0') then
				if (rst = "010") then
					contador <= 0;
					Y <= '0';
				
				elsif (contador >= divisor) then
					Y <= '1';	
				else
					contador <= contador + 1;
				end if;
		elsif (SW(17) = '0' and SW(16) = '1') then
				if (rst = "010") then
					contador <= 0;
					Y <= '0';
				
				elsif (contador >= divisor2) then
					Y <= '1';	
				else
					contador <= contador + 1;
				end if;
		elsif (SW(17) = '1' and SW(16) = '0') then
				if (rst = "010") then
					contador <= 0;
					Y <= '0';
				
				elsif (contador >= divisor3) then
					Y <= '1';	
				else
					contador <= contador + 1;
				end if;
		elsif (SW(17) = '1' and SW(16) = '1') then
				if (rst = "010") then
					contador <= 0;
					Y <= '0';
				
				elsif (contador >= divisor4) then
					Y <= '1';	
				else
					contador <= contador + 1;
				end if;
		end if;
	 end if;

  end process;
end architecture divInteiro;