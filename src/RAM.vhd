library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
   generic (
         dataWidth: natural := 8;
         addrWidth: natural := 8
    );
    port
    (
        addr     : in std_logic_vector(addrWidth-1 downto 0);
        R_W       : in std_logic;
        clk      : in std_logic;
        dado_in  : in std_logic_vector(dataWidth-1 downto 0);
		  divA : in std_logic_vector(dataWidth-1 downto 0);
		  divB : out std_logic_vector(dataWidth-1 downto 0);
		  seg : out std_logic_vector(dataWidth-1 downto 0);
--		  min : out std_logic_vector(dataWidth-1 downto 0);
--		  divB : out std_logic_vector(dataWidth-1 downto 0);
		  dibB_data : out std_logic_vector(dataWidth-1 downto 0);
        dado_out : out std_logic_vector(dataWidth-1 downto 0)

    );
end entity;

architecture rtl of RAM is
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
            if(R_W = '0') then
                ram(to_integer(unsigned(addr))) <= dado_in;
            end if;
				if(divA = "00000001") then
					ram(10) <= divA;
				end if;
            -- Register the address for reading during one clock cycle.
            addr_reg <= addr;
        end if;
    end process;
    dado_out <= ram(to_integer(unsigned(addr_reg)));
	 --dado_out <= "00000011";
	 divB <= ram(15);

	 seg <= ram(3);
end architecture;