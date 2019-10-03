library library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity TopLevel is
    
    generic (
        dataWidth : natural := 20
        addrWidth : natural := 20
    )

    port (
        clock : In std_logic;
        baseTempo : In std_logic_vector(dataWidth - 1 downto 0);
        pcReset : in std_logic;
        addr : Out std_logic_vector(addrWidth - 1 downto 0);
        data : Out std_logic_vector(dataWidth - 1 downto 0)
    );
end entity TopLevel;


architecture rtl of TopLevel is
    
    signal PC_ROM : unsigned(addrWidth - 1 downto 0);
    signal DATA_FLOW : unsigned(dataWidth - 1 downto 0);
    signal ROM_INC : unsigned(dataWidth - 1 downto 0);
    signal INC_MUX : unsigned(addrWidth - 1 downto 0);
    signal MUX_PC : unsigned(addrWidth - 1 downto 0);
    signal JMPAND_MUX : unsigned(addrWidth - 1 downto 0);
    signal MUX_ULA : unsigned(dataWidth - 1 downto 0);
    signal ULA_MUX : unsigned(dataWidth - 1 downto 0);
    signal MUX_ACUMULADOR : unsigned(dataWidth - 1 downto 0);
    signal ACUMULADOR_OUT : unsigned(dataWidth - 1 downto 0);
    signal DATA_IN : unsigned(dataWidth - 1 downto 0);

begin

    ROM : entity work.ROM
    port map (
        Endereco => PC_ROM,
        Dado => DATA_FLOW 
    )

    INC : entity work.soma1
    port map (
        entrada => ROM_INC,
        saida => INC_MUX 
    )

    Mux2x1_1 : entity work.MuxGenerico2
    port map (
        A_MUX => INC_MUX,
        B_MUX  => DATA_FLOW(X),
        Sel_MUX => JMPAND_MUX,
        Y_MUX => MUX_PC
    )

    PC : entity work.PC
    port map (
        clock => clock,
        addr => MUX_PC,
        out_addr => PC_ROM,
        reset => pcReset,
    )
    
    AND_1 : entity work.AND
    port map (
        A => DATA_FLOW(X),
        B => ULA_JMPAND,
        Y => JMPAND_MUX
    )

    Mux2x1_ULA : entity work.MuxGenerico2
    port map (
        A_MUX => DATA_IN,
        B_MUX => DATA_FLOW(X),
        Sel_MUX => DATA_FLOW(SEL_MUX_ULA),
        Y_MUX => MUX_ULA
    )

    Mux2x1_Acumulador : entity work.MuxGenerico2
    port map (
        A_MUX => DATA_IN ,
        B_MUX => ULA_MUX,
        Sel_MUX => DATA_FLOW(SEL_MUX_ACUMULADOR),
        Y_MUX => MUX_ACUMULADOR
    )

    Acumulador : entity work.Acumulador
    port map (
        DIN => MUX_ACUMULADOR,
        DOUT => ACUMULADOR_OUT,
        ENABLE => DATA_FLOW(X),
        CLK => clock
    )

    
end architecture rtl;