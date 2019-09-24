library ieee;
use ieee.std_logic_1164.all;

entity muxGenerico2 is
    generic (
        -- Total de bits das entradas e saidas
        datawidth    : natural  :=   8
    );
    port (
        A_MUX    : in  std_logic_vector(datawidth-1 downto 0);
        B_MUX    : in  std_logic_vector(datawidth-1 downto 0);
        Sel_MUX   : in  std_logic;

        Y_MUX   : out std_logic_vector(datawidth-1 downto 0)
    );
end entity;

architecture comportamento of muxGenerico2 is
begin
  -- Para sintetizar lógica combinacional usando um processo,
  --  todas as entradas do modulo devem aparecer na lista de sensibilidade.
    process(A_MUX, B_MUX, Sel_MUX) is
    begin
     -- If é uma instrução sequencial que não pode ser usada
     --  na seção de instruções concorrentes da arquitetura.
        if(Sel_MUX='0') then
            Y_MUX <= A_MUX;
        else
            Y_MUX <= B_MUX;
        end if;
    end process;
end architecture;