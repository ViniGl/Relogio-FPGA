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
		HEX5 : out std_logic_vector(6 downto 0);
		HEX6 : out std_logic_vector(6 downto 0);
		LEDG  : out STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
		LEDR  : out STD_LOGIC_VECTOR(17 DOWNTO 0) := (others => '0');
		SW  : in STD_LOGIC_VECTOR(17 DOWNTO 0) := (others => '0')
    );
end entity;


architecture JuntosEshallowNow of RelougiouTopper is
    
	 signal RamData : std_logic_vector(dataWidth-1 downto 0);
	 signal butter : std_logic;
	 signal procdata : std_logic_vector(dataWidth-1	 downto 0);
	 signal procall : std_logic_vector(instrucWidth - 1 downto 0);
	 signal decoderOut : std_logic_vector(2 downto 0);
	 signal baseTempoOut: std_logic;
	 signal TriStateIn : std_logic;
	 signal TriStateOut : std_logic_vector(7 downto 0);
	 signal data_in_proc : std_logic_vector(7 downto 0);
	 signal Sel_ram_flip : std_logic;
	 


	 signal testesigAcumulador : std_logic_vector(dataWidth-1 downto 0);
	  signal testeinAula : std_logic_vector(dataWidth-1 downto 0);
	   signal testeinBula : std_logic_vector(dataWidth-1 downto 0);
		 signal testeOutULA : std_logic_vector(dataWidth-1 downto 0);
			signal tick : std_logic ;
				signal contador : integer range 0 to 50000000 := 0;


	 
begin

  LEDR(2 downto 0) <= decoderOut(2 downto 0);
  
--  LEDR(17 downto 0) <= procall(18 downto 1); 
	--LEDR(17 downto 0)<= procall(18 downto 1);

	 
	 edge : entity work.edgeDetector
	 port map (
			clk => CLOCK_50,
			entrada => not KEY(0),
			saida => tick
	 );
	 
	 rstPC: entity work.edgeDetector
	 port map (
			clk => CLOCK_50,
			entrada => not KEY(3),
			saida => butter
	 );
	 

	 BASETEMP : entity work.divisorGenerico
	 port map (
			clk => CLOCK_50,
			Y => baseTempoOut,
			rst => decoderOut,
			SW => SW
	 );

	 
    PROC : entity work.Processador
    port map (
			--Marco
			LEDG => LEDG,
				sigAcumulador =>  testesigAcumulador, inAula => testeinAula, inBula => testeinBula, outULA => testeOutULA,  
			--==

        clock => CLOCK_50,
        data_In => data_in_proc,
        pcReset => butter,
        addr_Out => procall,
        data_Out => procdata
    );
	 
	 RAMMUS : entity work.RAM
	 port map (
	    addr => procall(dataWidth-1 downto 0),
		 R_W => procall(R_Wram),
		 clk => CLOCK_50,
		 enable => decoderOut,
		 dado_in => procdata,
		 dado_out => RamData
	 );
	 
	 ConvSegU : entity work.conversorHex7SegU
	 port map (
		  clk => CLOCK_50,
		  NUM => procdata,
		  enable => decoderOut,
		  HEXSeg => HEX0,
		  HEXMin => HEX2,
		  HEXHour => HEX4 
	 );
	 
--	 ConvAMPM : entity work.conversorHex7AMPM
--	 port map (
--		  clk => CLOCK_50,
--		  flag => procdata,
--		  enable => decoderOut,
--		  HEXAM => HEX6
--	 );
	 
	 
	 ConvSegD : entity work.conversorHex7SegD
	 port map (
		  clk => CLOCK_50,
		  NUM => procdata,
		  enable => decoderOut,
		  HEXSeg => HEX1,
		  HEXMin => HEX3,
		  HEXHour => HEX5

	 );
	 
	
	 DECOD : entity work.decoder 
	 port map (
		  enable_dec => procall(ENABLE_DEC),
		  R_W => procall(R_W_DISP),
		  addr => procall(dataWidth-1 downto 0),
		  selector => Sel_ram_flip,
		  Y => decoderOut
	 );
	 
	 flip : entity work.FlipFlopDivisor
	 port map (
		 Entrada => baseTempoOut,
		 D => '1',
		 Q => TriStateIn, -- teste RamData
		 RST => decoderOut
	 );
	 
	 tristate : entity work.triState
	 port map (
			E => TriStateIn,
			Switch => SW(0),
			Sel => decoderOut,
			Y => TriStateOut
	 );
	 
	 Mux2x1_RAM_FLIP : entity work.Mux2x1
    port map (
        A_MUX => Ramdata,
        B_MUX => TriStateOut,
        Sel_MUX => Sel_ram_flip,
        Y_MUX => data_in_proc
    );
	 
	 
end architecture JuntosEshallowNow;