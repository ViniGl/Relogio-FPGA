library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  --Soma (esta biblioteca =ieee)

entity soma1 is
    generic
    (
        datawidth : natural := 8;
        incremento : natural := 1
    );
    port
    (
        entrada: in  STD_LOGIC_VECTOR((datawidth-1) downto 0);
        saida:   out STD_LOGIC_VECTOR((datawidth-1) downto 0)
    );
end entity;

architecture comportamento of soma1 is
    begin
        saida <= std_logic_vector(unsigned(entrada) + incremento);
end architecture;