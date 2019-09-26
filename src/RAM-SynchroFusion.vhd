library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity single_port_ram is
   generic (
         dataWidth: natural := 8;
         addrWidth: natural := 8
    );
    port
    (
        addr     : in std_logic_vector(addrWidth-1 downto 0);
        we       : in std_logic := '1';
        clk      : in std_logic;
        dado_in  : in std_logic_vector(dataWidth-1 downto 0);
        dado_out : out std_logic_vector(dataWidth-1 downto 0)
    );
end entity;

architecture rtl of single_port_ram is
    -- Build a 2-D array type for the RAM
    subtype word_t is std_logic_vector(dataWidth-1 downto 0);
    type memory_t is array((2**addrWidth-1) downto 0) of word_t;

    -- Declare the RAM signal.
    signal ram : memory_t;

    -- Register to hold the address during one clock cycle.
    signal addr_reg : std_logic_vector(addrWidth-1 downto 0);

begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if(we = '1') then
                ram(to_integer(unsigned(addr))) <= dado_in;
            end if;
            -- Register the address for reading during one clock cycle.
            addr_reg <= addr;
        end if;
    end process;
    dado_out <= ram(to_integer(unsigned(addr_reg)));
end architecture;