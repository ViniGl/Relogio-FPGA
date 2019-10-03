library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity AND is
    port(
        A     : in  STD_LOGIC_VECTOR(15 downto 0);
        B     : in  STD_LOGIC_VECTOR(15 downto 0);

        Y    : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;

architecture arch of PC is

begin
    Y <= A AND B;
end architecture;