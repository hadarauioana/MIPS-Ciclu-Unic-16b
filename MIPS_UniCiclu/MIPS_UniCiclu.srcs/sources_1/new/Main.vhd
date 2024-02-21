
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

entity Main is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end Main;

architecture Behavioral of Main is
component IFF is
Port ( clk : in STD_LOGIC;
           AdressBranch : in STD_LOGIC_VECTOR (15 downto 0);
           AdressJump : in STD_LOGIC_VECTOR (15 downto 0);
           Jump : in STD_LOGIC;
           PCSrc : in STD_LOGIC;
           enable_c: in STD_LOGIC;
           enable_r: in STD_LOGIC;
           Instruc : out STD_LOGIC_VECTOR (15 downto 0);
           Adresa : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component IDD is
    Port ( clk : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           WriteData : in STD_LOGIC_VECTOR (15 downto 0);
           RegWr : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           vRd1 : out STD_LOGIC_VECTOR (15 downto 0);
           vRd2 : out STD_LOGIC_VECTOR (15 downto 0);
           IMM : out STD_LOGIC_VECTOR (15 downto 0);
           enable_x : in STD_LOGIC;
           Funct: out STD_LOGIC_VECTOR (2 downto 0); --opcode-ul functiei
           SA : out STD_LOGIC); -- shift amount
end component;

component UC is
    Port (
        OpCode: in std_logic_vector(2 downto 0);
        RegDst: out std_logic;
        ExtOp: out std_logic;
        ALUSrc: out std_logic;
        Branch: out std_logic;
        Jump: out std_logic;
        ALUOp: out std_logic_vector( 2 downto 0); --in functie de numarul de operatii
        MemWrite: out std_logic;
        MemToReg: out std_logic;
        RegWrite: out std_logic);
 end component;

component EXX is
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
end component;

component MEM is
     Port ( clk : in STD_LOGIC;
          EN : in STD_LOGIC;
          MEMWR : in STD_LOGIC;
          ALURESIN : in STD_LOGIC_VECTOR (15 downto 0);
          RD2 : in STD_LOGIC_VECTOR (15 downto 0);
          ALURESOUT : out STD_LOGIC_VECTOR (15 downto 0);
          MEMDATA : out STD_LOGIC_VECTOR (15 downto 0));
end component;
component MPG is
            Port ( clk : in STD_LOGIC;
           input : in STD_LOGIC;
           enable : out STD_LOGIC);
end component;

component SSD is
Port ( clk : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
 end component;
 

signal enable_c,enable_r:std_logic;
signal instr, adr_pc,out_iff: std_logic_vector(15 downto 0);
signal sumRD,imm: std_logic_vector(15 downto 0);
signal vrd1,vrd2: std_logic_vector(15 downto 0);
--afisare led
signal regwr,regdst,extop,alusrc,branch,jump,memwr, memtoreg:std_logic;
signal aluop:std_logic_vector( 2 downto 0);
signal ANDBranch,zero_ex: std_logic;
signal aluresoutex, adresa_salt_ex,aluresoutmem, memdataoutmem, MUXFout: std_logic_vector(15 downto 0);
signal funct,opcode: std_logic_vector(2 downto 0);
signal sa: std_logic;
signal adr_jump: std_logic_vector(15 downto 0);

begin
opcode<=out_iff(15 downto 13);
adr_jump<=adr_pc(15 downto 13)&out_iff(12 downto 0);

ciff: IFF port map(clk=>clk,AdressBranch=>adresa_salt_ex,AdressJump=>adr_jump,Jump=>jump,PCSrc=>ANDBranch,Instruc=>out_iff,Adresa=>adr_pc, enable_c=>enable_c, enable_r=>enable_r);
afis:SSD port map(clk=>clk,digit3=>instr(15 downto 12), digit2=>instr(11 downto 8), digit1=>instr(7 downto 4), digit0=>instr(3 downto 0), cat=>cat, an=>an);
clock:MPG port map (clk=>clk, input=>btn(0),enable=>enable_c);
reset:MPG port map (clk=>clk, input=>btn(1),enable=>enable_r);
decode: IDD port map(clk=>clk, Instr=>out_iff, WriteData=>MUXFout, RegWr=>regwr, RegDst=>regdst, ExtOp=>extop, vRd1=>vrd1, vRd2=>vrd2,IMM=>imm,Funct=>funct, SA=>sa,enable_x=>enable_c);
ucc: UC port map(OpCode=>opcode, RegDst=>regdst , ExtOp=>extop , ALUSrc=>alusrc , Branch=>branch , Jump=>jump , ALUOp=>aluop , MemWrite=>memwr , MemToReg=>memtoreg , RegWrite=>regwr );
ex: EXX port map(RD1=> vrd1, RD2=>vrd2 ,ALUSrc=> alusrc, EXT_IMM=>imm , SA=>sa , FUNC=>funct ,ALUOP=> aluop, ZERO=>zero_ex , ALURES=>aluresoutex , ADRinstr=>adr_pc , ADRsalt=> adresa_salt_ex);
memo: MEM port map(clk=>clk, EN=>enable_c , MEMWr=> memwr, ALURESIN=>aluresoutex , RD2=>vrd2 , ALURESOUT=>aluresoutmem , MEMDATA=>memdataoutmem );
--instr<=out_iff when sw(7)='0' else adr_pc;
process(sw(7 downto 5) )
begin
case sw(7 downto 5) is
 when "000" => instr<=out_iff;
   when "001" => instr<=adr_pc;
   when "010"=>instr<=vrd1;
     when "011"=>instr<=vrd2;
      when "100"=>instr<=imm;
      when "101"=>instr<=aluresoutex;
      when "110"=>instr<=memdataoutmem;
      when "111"=>instr<=MUXFout;
end case;
end process;
MUXFout<=aluresoutmem when memtoreg='0' else memdataoutmem;
ANDBranch<= zero_ex AND branch;

led(10)<=aluop(2);
led(9)<=aluop(1);
led(8)<=aluop(0);
led(7)<=regdst;
led(6)<=extop;
led(5)<=alusrc;
led(4)<=branch;
led(3)<=jump;
led(2)<=memwr;
led(1)<=memtoreg;
led(0)<=regwr;
led(15 downto 11)<="00000";


end Behavioral;
