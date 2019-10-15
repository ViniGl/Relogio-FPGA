library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder is

    generic
    (
        addrWidth : natural := 8;
		  decoded : natural := 3
    );

    port
    (
        -- Input ports
        enable_dec : in STD_LOGIC;
        R_W : in STD_LOGIC; --(R/!W)
        addr : in std_logic_vector(addrWidth-1 downto 0);
        -- Output ports
		  Y : out std_logic_vector(decoded-1 downto 0);
		  selector : out std_logic
		
    );
end entity;

architecture comportamento of decoder is
	 
begin	
	 
		 Y <= "001" when (addr(7) = '0' and enable_dec = '1') else --RAM
		 "111" when (addr = "10000010" and enable_dec = '1') else --SEL TRI STATE
		 "010" when (addr = "10000001" and enable_dec = '1') else --RESET FLIPFLOP
		 "011" when (addr = "10001100" and enable_dec = '1') else --DISPLAY SEG
		 "101" when (addr = "10010100" and enable_dec = '1') else --DISPLAY MIN
		 "110" when (addr = "10011000" and enable_dec = '1') else --DISPLAY HOUR
		 "000" when (addr = "10001000" and enable_dec = '1') else
		 "000";	 
		 
		 selector <= '1' when (addr = "10000010" and enable_dec = '1') else
						'0';
end architecture;

