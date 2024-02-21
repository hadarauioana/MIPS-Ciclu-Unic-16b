
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

entity IFF is
    Port ( clk : in STD_LOGIC;
           AdressBranch : in STD_LOGIC_VECTOR (15 downto 0);
           AdressJump : in STD_LOGIC_VECTOR (15 downto 0);
           Jump : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           enable_c : in STD_LOGIC;
           enable_r : in STD_LOGIC;
           Instruc : out STD_LOGIC_VECTOR (15 downto 0);
           Adresa : out STD_LOGIC_VECTOR (15 downto 0));
end IFF;

architecture Behavioral of IFF is

type MEM_ROM is array (0 to 255) of std_logic_vector(15 downto 0);
signal rom:MEM_ROM:=(b"111_000_001_000_1001", --adi r1,r0,9
b"111_000_100_001_1000",--adi r4,r0,24
b"111_000_101_000_0000",--adi r5,r0,0
--begin loop
b"110_100_001_000_0011",--beq r1,r4,2 (sar peste 2 instructiuni)
b"111_001_001_000_0011",--addi r1.r.3
b"000_101_001_101_0000",--add r5,r5,r1 -
b"011_000_000_000_0011",--j ->offset 3
b"001_000_101_000_1010",
others=>x"0000");


signal muxBranch: std_logic_vector(15 downto 0);
signal muxJump,out_sum: std_logic_vector(15 downto 0);


signal pc:std_logic_vector(15 downto 0):=x"0000";
signal d:std_logic_vector(15 downto 0);

begin

muxBranch<=out_sum when PCSrc='0' else AdressBranch; --sw(15)=pcSrc
muxJump<=muxBranch when Jump='0' else AdressJump; --sw(14)=jump
--proces bistabil d sincron ->val Pc
process(clk)
begin
if rising_edge(clk) then
if enable_r='1' then
pc<=x"0000";
else if enable_c='1' then 
pc<=d;
end if;
end if;
end if;
end process;
--increment valoarea lui pc
d<=muxJump;
out_sum<=pc+1;
Adresa<=out_sum;
--Adresa<=pc;
Instruc<=rom(conv_integer(pc(7 downto 0)));

end Behavioral;