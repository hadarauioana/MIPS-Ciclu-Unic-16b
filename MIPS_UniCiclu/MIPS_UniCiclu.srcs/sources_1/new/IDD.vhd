----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2023 12:19:19 PM
-- Design Name: 
-- Module Name: IDD - Behavioral
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

entity IDD is
    Port ( clk : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           RegWr : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           vRd1 : out STD_LOGIC_VECTOR (15 downto 0);
           vRd2 : out STD_LOGIC_VECTOR (15 downto 0);
           IMM : out STD_LOGIC_VECTOR (15 downto 0);
           Funct: out STD_LOGIC_VECTOR (2 downto 0); --opcode-ul functiei
           SA : out STD_LOGIC;
           enable_x : in STD_LOGIC);
end IDD;

architecture Behavioral of IDD is
--register file
    component RF is
    Port ( RA1 : in STD_LOGIC_VECTOR (2 downto 0);
              RA2 : in STD_LOGIC_VECTOR (2 downto 0);
              WA : in STD_LOGIC_VECTOR (2 downto 0);
              WD : in STD_LOGIC_VECTOR (15 downto 0);
              clk : in STD_LOGIC;
              RD1 : out STD_LOGIC_VECTOR (15 downto 0);
              RD2 : out STD_LOGIC_VECTOR (15 downto 0);
              enable_x: in std_logic;
              RegWr : in STD_LOGIC); 
    end component;
 --MPG, acelasi enable de la pc controleaza scrierea   
   
signal muxRd: std_logic_vector(2 downto 0);

begin


RegFile: RF port map(RA1=>Instr(12 downto 10), RA2=>Instr(9 downto 7), WA=>muxRD,WD=>WriteData, clk=>clk, RD1=>vRd1, RD2=>vRd2, RegWr=>RegWr,enable_x=>enable_x);

--mux pt write adress
muxRd<=Instr(6 downto 4 ) when RegDst='1' else Instr(9 downto 7); --rgdst sw()
--unitatea de extensie => extensie cu semn
process(ExtOp)
begin
if ExtOp='0' then
--extind cu 0
IMM<="000000000"&Instr(6 downto 0);
else if ExtOp='1' then
--extind cu semn
if Instr(6)='1' then
IMM<="111111111"&Instr(6 downto 0);
else 
IMM<="000000000"&Instr(6 downto 0);
end if;
end if;
end if;
end process;
--iesirile
SA<=Instr(3);
Funct<=Instr(2 downto 0);

end Behavioral;
