library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity OR_comp is
    port(
        A     : in  STD_LOGIC;
        B     : in  STD_LOGIC;

        Y    : out STD_LOGIC
    );
end entity;

architecture arch of OR_comp is

begin
    Y <= A OR B;
end architecture;