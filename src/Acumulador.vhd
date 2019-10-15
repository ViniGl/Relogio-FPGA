library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Acumulador is
    generic (
        dataWidth : natural := 8
    );
    port (
		 DIN : in std_logic_vector(dataWidth-1 downto 0);
       DOUT : out std_logic_vector(dataWidth-1 downto 0);
       ENABLE : in std_logic;
       CLK : in std_logic
    );
end entity;

architecture comportamento of Acumulador is

signal hold : std_logic_vector(dataWidth-1 downto 0);

begin
    -- In Altera devices, register signals have a set priority.
    -- The HDL design should reflect this priority.
    process(CLK)
    begin
        -- At a clock edge, if asynchronous signals have not taken priority,
        -- respond to the appropriate synchronous signal.
        -- Check for synchronous reset, then synchronous load.
        -- If none of these takes precedence, update the register output
        -- to be the register input.
        if (ENABLE = '1') then
            if (rising_edge(CLK)) then
                    DOUT <= DIN;
            end if;
        end if;
    end process;
end architecture;