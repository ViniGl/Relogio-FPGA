library ieee;
use ieee.std_logic_1164.all;

entity FlipFlopD is
	port(
		clock: in std_logic;
		dado: in std_logic;
		WE: in std_logic;
		saida: out std_logic
	);
end entity;

architecture arch of FlipFlopD is
begin
	process (clock) begin
		if (WE = '1') then
			saida<=dado;
		end if;
	end process;
end architecture;