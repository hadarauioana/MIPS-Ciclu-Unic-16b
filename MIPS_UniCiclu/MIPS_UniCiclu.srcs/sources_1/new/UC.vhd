----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2023 01:30:42 PM
-- Design Name: 
-- Module Name: UC - Behavioral
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

entity UC is
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
end UC;

architecture Behavioral of UC is

begin
process(OpCode)
    begin
    --le pun pe 0
        RegDst <= '0';
        ExtOp <= '0';
        ALUSrc <= '0';
        Branch <= '0';
        Jump <= '0';
        ALUOp <= "000";
        MemWrite <= '0';
        MemToReg <= '0';
        RegWrite <= '0';
        --intr-un process se face doar ultima atrivuire
        case OpCode(2 downto 0) is
            -- Instructiuni de tip R
            when "000" => RegDst <= '1'; RegWrite <= '1'; 
            -- Instructiunea ADDI
            when "111" => ExtOp <= '1'; ALUSrc <= '1'; RegWrite <= '1'; ALUOp(2 downto 0)<="001";
            -- Instructiunea LW
            when "100" => ExtOp <= '1'; ALUSrc <= '1'; RegWrite <= '1'; MemToReg<='1';ALUOp(2 downto 0)<="001";
            -- Instructiunea SW
            when "001" => MemWrite <= '1'; ALUSrc <= '1'; ExtOp <= '1'; MemWrite<='1';ALUOp(2 downto 0)<="001";
            -- Instructiunea BEQ (Branch)
            when "110" => ExtOp <= '1'; Branch <= '1';ALUOp(2 downto 0)<="010";
            -- Instructiunea ORI
            when "101" => ExtOp <= '1';ALUSrc <= '1'; RegWrite <= '1';ALUOp(2 downto 0)<="011";
            -- Instructiuena XORI
            when "010" => ExtOp <= '1'; ALUSrc <= '1'; RegWrite <= '1'; ALUOp(2 downto 0)<="100";
            -- Instructiunea Jump
            when "011" => Jump <= '1';
        end case;
    end process;

end Behavioral;
