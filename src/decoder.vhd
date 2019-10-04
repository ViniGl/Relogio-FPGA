library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is

    generic
    (
        addrWidth : natural := 8
    );

    port
    (
        -- Input ports
        enable_dec : in STD_LOGIC;
        R_W : in STD_LOGIC; --(R/!W)
        enable_disp : std_logic_vector(addrWidth-1 downto 0);
        -- Output ports
        enable_seg : out STD_LOGIC;
        enable_min : out STD_LOGIC;
        enable_hor : out STD_LOGIC
    );
end entity;

architecture comportamento of decoder is
	 
begin
    process(all)
    begin
    if (enable_dec = '1') then 
        if (R_W = '0') then
            if (enable_disp = "00000011") then
                enable_seg <= '1';
                enable_min <= '0';
                enable_hor <= '0';
            elsif (enable_disp = "00000100") then
                enable_seg <= '0';
                enable_min <= '1';
                enable_hor <= '0';
            elsif (enable_disp = "00000101") then
                enable_seg <= '0';
                enable_min <= '0';
                enable_hor <= '1';
            end if;
        end if;
    end if;
    end process;
end architecture;

