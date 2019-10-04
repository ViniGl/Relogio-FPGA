library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RelougiouTopper is
    
    generic (
        dataWidth : natural := 8;
		  instrucWidth : natural := 19;
		  ENABLE_DEC : natural := 18;
		  R_W_DISP : natural := 17;
		  R_Wram : natural := 10
    );

    port (
        CLOCK_50 : In std_logic;
        KEY : in std_logic_vector(3 downto 0);
		  HEX0 : out std_logic_vector(6 downto 0);
		  HEX1 : out std_logic_vector(6 downto 0);
		  HEX2 : out std_logic_vector(6 downto 0);
		  HEX3 : out std_logic_vector(6 downto 0);
		  HEX4 : out std_logic_vector(6 downto 0);
		  HEX5 : out std_logic_vector(6 downto 0)
    );
end entity;


architecture JuntosEshallowNow of RelougiouTopper is
    
	 signal DIV_A : std_logic_vector(7 downto 0);
	 signal DIV_B : std_logic_vector(7 downto 0);
	 signal RamData : std_logic_vector(dataWidth-1 downto 0);
	 signal butter : std_logic;
	 signal procdata : std_logic_vector(dataWidth-1 downto 0);
	 signal procall : std_logic_vector(instrucWidth - 1 downto 0);
	 signal realclock: std_logic;
	 signal DISP0 : std_logic_vector(6 downto 0);
	 signal SegDisp: std_logic;
	 signal MinDisp: std_logic;
	 signal HorDisp: std_logic;
	 --signal RamOutDisp : std_logic_vector(7 downto 0);

begin
	 
	 BASETEMP : entity work.divisorGenerico
	 port map (
			clk => CLOCK_50,
			divisorA => DIV_A,
			divisorB => DIV_B
	 );

	 butter <= not KEY(3);
	 
    PROC : entity work.Processador
    port map (
        clock => realclock,
        data_In => RamData,
        pcReset => butter,
        addr_Out => procall,
        data_Out => procdata
    );
	 
	 RAMMUS : entity work.RAM
	 port map (
	     addr => procall(dataWidth-1 downto 0),
		  R_W => procall(R_Wram),
		  clk => realclock,
		  dado_in => procdata,
		  divA => DIV_A,
		  divB => DIV_B,
		  dado_out => RamData
	 );
	 
	 ConvSegU : entity work.conversorHex7SegU
	 port map (
		  SW => RamData,
		  enable_seg => SegDisp,
		  HEX0 => HEX0
	 );
	 
	 
	 ConvSegD : entity work.conversorHex7SegD
	 port map (
		  SW => RamData,
		  enable_seg => SegDisp,
		  HEX1 => HEX1
	 );
	 
	 ConvMinU : entity work.conversorHex7SegU_Min
	 port map (
		  SW => RamData,
		  enable_min => MinDisp,
		  HEX2 => HEX2
	 );
	 
	 ConvMinD : entity work.conversorHex7SegD_Min
	 port map (
		  SW => RamData,
		  enable_min => MinDisp,
		  HEX3 => HEX3
	 );
	 
	 ConvHorU : entity work.conversorHex7SegU_Hor
	 port map (
		  SW => RamData,
		  enable_hor => HorDisp,
		  HEX4 => HEX4
	 );
	 
	 ConvHorD : entity work.conversorHex7SegD_Hor
	 port map (
		  SW => RamData,
		  enable_hor => HorDisp,
		  HEX5 => HEX5
	 );
	 
	
	 DECOD : entity work.decoder 
	 port map (
		  enable_dec => procall(ENABLE_DEC),
		  R_W => procall(R_W_DISP),
		  enable_disp => procall(dataWidth-1 downto 0),
		  enable_seg => SegDisp,
		  enable_min => MinDisp,
		  enable_hor => HorDisp  
	 );
	 
	 
	 
end architecture JuntosEshallowNow;