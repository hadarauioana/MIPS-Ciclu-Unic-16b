

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

entity MPG is
    Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC;
           enable : out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is
    signal cnt:std_logic_vector(15 downto 0):=x"0000";
    signal Q1:std_logic;
    signal Q2:std_logic;
    signal Q3:std_logic;
begin
enable<= Q2 AND(not Q3);

process(clk)
begin
if rising_edge(clk) then 
cnt<=cnt+1;
end if;
end process;

process(clk)
begin
if rising_edge(clk) then 
if cnt="1111111111111111" then --activare 
Q1<=input;
end if;
end if;
end process;

process(clk)
begin
if rising_edge(clk) then 
Q2<=Q1;
Q3<=Q2;
end if;
end process;
end Behavioral;

