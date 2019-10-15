-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity ULA is

	generic(
		datawidth : natural := 8
	);

	port
	(
		-- Input ports
		A	: in  std_logic_vector(datawidth-1 DOWNTO 0);
		B	: in   std_logic_vector(datawidth-1 DOWNTO 0);
		FUNC	: in std_logic_vector(1 DOWNTO 0);

		-- Output ports
		Y	: out std_logic_vector(datawidth-1 DOWNTO 0);
		Igual	: out std_logic
	);
end entity;


architecture functions of ULA is

begin
	Y <= 	std_logic_vector(to_unsigned(to_integer(unsigned(A)) + to_integer(unsigned(B))  , Y'length)) when (FUNC = "01") else 
			(A XOR B) when (FUNC = "10") else
			A when (FUNC = "00") else A;
			
	Igual <= '1' when ((A = B) and (FUNC = "11")) else '0';
end architecture;


