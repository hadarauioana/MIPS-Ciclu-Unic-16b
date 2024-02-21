----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2023 12:59:36 PM
-- Design Name: 
-- Module Name: EXX - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EXX is
    Port ( RD1 : in STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           ALUSrc : in STD_LOGIC;
           EXT_IMM : in STD_LOGIC_VECTOR (15 downto 0);
           SA : in STD_LOGIC;
           FUNC : in STD_LOGIC_VECTOR (2 downto 0);
           ALUOP : in STD_LOGIC_VECTOR( 2 downto 0);
           ZERO : out STD_LOGIC;
           ALURES : out STD_LOGIC_VECTOR (15 downto 0);
           ADRinstr : in STD_LOGIC_VECTOR (15 downto 0);
           ADRsalt : out STD_LOGIC_VECTOR (15 downto 0));
end EXX;

architecture Behavioral of EXX is
signal aluctrl: std_logic_vector(2 downto 0):="000";
signal imm,outMUX, dif:std_logic_vector(15 downto 0);
begin
--imm<=IMM(13 downto 0)&"00";
ADRsalt<=ADRinstr+EXT_IMM;
outMUX<=RD2 when ALUSrc='0' else EXT_IMM;
dif<=RD1-outMUX;
ZERO<='1' when dif=0 else '0';
--process ALUControl
process(ALUOP,FUNC)
begin
case ALUOP is
when "000" => 
    case FUNC is
        when "000"=>aluctrl<="000";--add
        when "001"=>aluctrl<="001";--sub
        when "011"=>aluctrl<="010";--sll
        when "100"=>aluctrl<="011";--srl
        when "010"=>aluctrl<="100";--and 
         when "101"=>aluctrl<="101";--or 
          when "110"=>aluctrl<="110";--xor
           when "111"=>aluctrl<="111";--sllv
           when others=> aluctrl<="000";
    end case;
 when "001"=> aluctrl<="000";--+
  when "010"=> aluctrl<="001";-- -
   when "011"=> aluctrl<="101";
    when "100"=> aluctrl<="110";
    when others=> aluctrl<="000";
    end case;
end process;

--ALU
process(aluctrl,SA)
begin
case aluctrl is
when"000"=> ALURES<=RD1+outMUX;
when"001"=> ALURES<=RD1-outMUX;
when"010"=> 
   if SA='1' then
   ALURES<=RD1(14 downto 0)&'0';
   else
   ALURES<=RD1;
   end if;
  when "011" =>
  if SA='1' then
     ALURES<=RD1(15 downto 1)&'0';
     else
     ALURES<=RD1;
     end if;
     when "100" => ALURES<=RD1 AND outMUX;
       when "101" => ALURES<=RD1 OR outMUX;
          when "110" => ALURES<=RD1 XOR outMUX;
          when"111"=>
          --SLLV -- DEPLASARE CU RF[RT] BITI--maxim 8
            case outMUX is
            when b"0000_0000_0000_0000" => ALURES<=RD1;
            when b"0000_0000_0000_0001" => ALURES<=RD1(14 downto 0)&'0';
            when b"0000_0000_0000_0010" => ALURES<=RD1(13 downto 0)&"00";
            when b"0000_0000_0000_0011" => ALURES<=RD1(12 downto 0)&"000";
            when b"0000_0000_0000_0100" => ALURES<=RD1(11 downto 0)&"0000";
            when b"0000_0000_0000_0101" => ALURES<=RD1(10 downto 0)&"00000";
            when b"0000_0000_0000_0111" => ALURES<=RD1(9 downto 0)&"000000";
            when b"0000_0000_0000_1000" => ALURES<=RD1(8 downto 0)&"0000000";
            when others=> ALURES<=RD1;
          end case;
end case;
end process;
end Behavioral;
