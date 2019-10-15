library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity PC is
	 
	 generic(
		datawidth : natural := 8
	);

    port(
        clock     : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        input     : in  STD_LOGIC_VECTOR(datawidth-1 DOWNTO 0);
        output    : out STD_LOGIC_VECTOR(datawidth-1 DOWNTO 0)
    );
end entity;

architecture arch of PC is
  signal toout : STD_LOGIC_VECTOR(datawidth-1 DOWNTO 0) := (others => '0');

begin
  process (reset,clock) begin
		if (reset = '1') then
          toout <= (others => '0');
		  
		elsif rising_edge(clock) then
        
		toout <= input;
		end if;
  end process;

  output <= toout;

end architecture;