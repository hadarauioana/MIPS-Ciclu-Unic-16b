----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2023 05:58:43 PM
-- Design Name: 
-- Module Name: RF - Behavioral
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

entity RF is
    Port ( RA1 : in STD_LOGIC_VECTOR (2 downto 0);
           RA2 : in STD_LOGIC_VECTOR (2 downto 0);
           WA : in STD_LOGIC_VECTOR (2 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           enable_x: in std_logic;
           RegWr : in STD_LOGIC);
end RF;

architecture Behavioral of RF is

type RF16_16 is array (0 to 15) of std_logic_vector(15 downto 0);
signal myRF: RF16_16 :=(x"0000", others=>x"0000");

begin
process(clk,RA1,RA2,WA,WD,RegWr)
begin
RD1<=myRF(conv_integer(RA1));
RD2<=myRf(conv_integer(RA2));
if rising_edge(clk) then --sincron
if enable_x='1' then
if RegWr='1' then -- daca se,nalul de scriere e activat
myRF(conv_integer(Wa))<= WD;
end if;
end if;
end if;
end process;
end Behavioral;
