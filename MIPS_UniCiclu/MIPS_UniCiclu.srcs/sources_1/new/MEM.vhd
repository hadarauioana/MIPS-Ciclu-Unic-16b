----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/19/2023 05:59:32 PM
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
    Port ( clk : in STD_LOGIC;
           EN : in STD_LOGIC;
           MEMWR : in STD_LOGIC;
           ALURESIN : in STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           ALURESOUT : out STD_LOGIC_VECTOR (15 downto 0);
           MEMDATA : out STD_LOGIC_VECTOR (15 downto 0));
end MEM;

architecture Behavioral of MEM is
type MEM_ram is array (0 to 15) of std_logic_vector(15 downto 0);
signal RAM:MEM_ram:=(x"0000",others =>"0000");
begin
ALURESOUT<=ALURESIN;
  process(clk)
  begin
  if rising_edge(clk) then
  if EN='1' and MEMWR='1' then
  RAM( conv_integer(ALURESIN) )<= RD2;
  end if;
  end if;
  end process;
MEMDATA<=RAM(conv_integer(ALURESIN) );
end Behavioral;