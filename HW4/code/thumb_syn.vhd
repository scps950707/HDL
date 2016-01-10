-----------------------------------------------------------------
-- Package Definition for Global Constants for Pipelined Thumb
library IEEE;  use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
package THUMB_CONSTANTS is
  -- general global constants
  constant WORD_SIZE: integer := 32;   -- for data reg. and addr.
  constant HWORD_SIZE: integer := 16;  -- instruction word size
  constant REG_FILE_SIZE: integer := 8;-- general purpose regs.

  -- Undefined instruction encoding in Thumb Instruction Set
  constant UNDEFINED_INSTRUCTION: unsigned(HWORD_SIZE-1
           downto 0) := B"1101_1110_0000_0000";
  -- internal encoding for thumb instructions
  constant ADC: unsigned(5 downto 0) := "000000";
  constant ADD_1: unsigned(5 downto 0) := "000001";
  constant ADD_2: unsigned(5 downto 0) := "000010";
  constant ADD_3: unsigned(5 downto 0) := "000011";
  constant ADD_5: unsigned(5 downto 0) := "000100";
  constant ADD_6: unsigned(5 downto 0) := "000101";
  constant ADD_7: unsigned(5 downto 0) := "000110";
  constant AND_OP: unsigned(5 downto 0) := "000111";
  constant ASR_1: unsigned(5 downto 0) := "001000";
  constant ASR_2: unsigned(5 downto 0) := "001001";
  constant B_1: unsigned(5 downto 0) := "001010";
  constant B_2: unsigned(5 downto 0) := "001011";
  constant BIC: unsigned(5 downto 0) := "001100";
  constant BL_BLX_H10: unsigned(5 downto 0) := "001101";
  constant BL_BLX_H11: unsigned(5 downto 0) := "001110";
  constant CMN: unsigned(5 downto 0) := "001111";
  constant CMP_1: unsigned(5 downto 0) := "010000";
  constant CMP_2: unsigned(5 downto 0) := "010001";
  constant EOR: unsigned(5 downto 0) := "010010";
  constant LDMIA: unsigned(5 downto 0) := "010011";
  constant LDR_1: unsigned(5 downto 0) := "010100";
  constant LDR_2: unsigned(5 downto 0) := "010101";
  constant LDR_3: unsigned(5 downto 0) := "010110";
  constant LDR_4: unsigned(5 downto 0) := "010111";
  constant LDRB_1: unsigned(5 downto 0) := "011000";
  constant LDRB_2: unsigned(5 downto 0) := "011001";
  constant LDRH_1: unsigned(5 downto 0) := "011010";
  constant LDRH_2: unsigned(5 downto 0) := "011011";
  constant LDRSB: unsigned(5 downto 0) := "011100";
  constant LDRSH: unsigned(5 downto 0) := "011101";
  constant LSL_1: unsigned(5 downto 0) := "011110";
  constant LSL_2: unsigned(5 downto 0) := "011111";
  constant LSR_1: unsigned(5 downto 0) := "100000";
  constant LSR_2: unsigned(5 downto 0) := "100001";
  constant MOV_1: unsigned(5 downto 0) := "100010";
  constant MUL: unsigned(5 downto 0) := "100011";
  constant MVN: unsigned(5 downto 0) := "100100";
  constant NEG: unsigned(5 downto 0) := "100101";
  constant ORR: unsigned(5 downto 0) := "100110";
  constant POP_R0: unsigned(5 downto 0) := "100111";
  constant POP_R1: unsigned(5 downto 0) := "101000";
  constant PUSH_R0: unsigned(5 downto 0) := "101001";
  constant PUSH_R1: unsigned(5 downto 0) := "101010";
  constant ROR_OP: unsigned(5 downto 0) := "101011";
  constant SBC: unsigned(5 downto 0) := "101100";
  constant STMIA: unsigned(5 downto 0) := "101101";
  constant STR_1: unsigned(5 downto 0) := "101110";
  constant STR_2: unsigned(5 downto 0) := "101111";
  constant STR_3: unsigned(5 downto 0) := "110000";
  constant STRB_1: unsigned(5 downto 0) := "110001";
  constant STRB_2: unsigned(5 downto 0) := "110010";
  constant STRH_1: unsigned(5 downto 0) := "110011";
  constant STRH_2: unsigned(5 downto 0) := "110100";
  constant SUB_1: unsigned(5 downto 0) := "110101";
  constant SUB_2: unsigned(5 downto 0) := "110110";
  constant SUB_3: unsigned(5 downto 0) := "110111";
  constant SUB_4: unsigned(5 downto 0) := "111000";
  constant SWI: unsigned(5 downto 0) := "111001";
  constant TST: unsigned(5 downto 0) := "111010";
  constant UNDEF: unsigned(5 downto 0) := "111111";

end package;
-----------------------------------------------------------------

-----------------------------------------------------------------
-- MODULE: Pipelined CPU for THUMB microprocessor: thumb.vhd
-- Author: Sunggu Lee
-- Created: August 22, 2003
-- Last Modified: August 26, 2003
-- Description: Implements the instruction set for the THUMB
--   microprocessor described in the "ARM Architecture Reference
--   Manual" ((ARM 2000)).  The SWI (software interrupt) instr.
--   is reimplemented as a HALT.  Currently, a few instructions
--   are not implemented due to a desire to keep the design
--   relatively simple.  Unimplemented instructions are ARM
--   Version 5 Thumb instructions, instructions using the high
--   (R8-R15) registers, LDMIA, STMIA, and PUSH and POP with the
--   PC register or multiple registers.  The specific
--   unimplemented instructions, as listed in (ARM 2000), are
--   ADD(4), BKPT, BLX(H=01), BLX(2), BX, CMP(3), LDMIA, MOV(3),
--   POP(>1 register), POP(PC), PUSH(>1 register), PUSH(PC),
--   STMIA, and SWI (implemented as HALT only).

-- Library Statements
library IEEE;  use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.THUMB_CONSTANTS.all;

-- Entity Definition
entity thumb is
  port (read_instruction_n: out std_logic;
        instruction_address: out unsigned (WORD_SIZE-1 downto 0);
        instruction: in unsigned (HWORD_SIZE-1 downto 0);
        read_data_n, write_data_n: out std_logic;
        data_address: out unsigned (WORD_SIZE-1 downto 0);
        data: inout unsigned (WORD_SIZE-1 downto 0);
        reset_n, clk: in std_logic);
end entity thumb;

architecture thumb of thumb is
  -- type and subtype definitions
  subtype word_range is unsigned (WORD_SIZE-1 downto 0);
  type word_array is array
    (REG_FILE_SIZE-1 downto 0) of word_range;

  -- SIGNAL DECLARATIONS for internal registers and wires
  -- PC = program counter (R15), LR = link register (R14),
  -- SP = stack pointer (R13), and IR = instruction register
  signal PC: unsigned (WORD_SIZE-1 downto 0);
  signal LR: unsigned (WORD_SIZE-1 downto 0);
  signal SP: unsigned (WORD_SIZE-1 downto 0);
  signal IR: unsigned (HWORD_SIZE-1 downto 0);
  signal R: word_array; -- general regs
  signal N_Flag: std_logic;  -- condition flags (N = negative)
  signal Z_Flag: std_logic;  -- (Z = zero)
  signal C_Flag: std_logic;  -- (C = carry)
  signal V_Flag: std_logic;  -- (V = overflow)

  -- SIGNAL DECLARATIONS used to aid in the Verilog description
  signal branch_taken: std_logic;      -- indicates taken branch
  signal branch_target: unsigned
               (WORD_SIZE-1 downto 0); -- branch target address
  signal ALU_out: unsigned (WORD_SIZE-1 downto 0); -- ALU output
  signal DR: unsigned (WORD_SIZE-1 downto 0); -- output data
  signal enable_write_data_n: std_logic; -- to enable data output

  -- Pipeline Registers (names prefixed w/ pipeline stage names)
  -- Format used for names is <stage>_<identifier>.
  signal IF_IR: unsigned (HWORD_SIZE-1 downto 0);
  signal IF_PC, ID_PC: unsigned (WORD_SIZE-1 downto 0);
  signal ID_Rd, ID_Rn, ID_Rm_Rs: unsigned (WORD_SIZE-1 downto 0);
  signal EX_ALU_out: unsigned (WORD_SIZE-1 downto 0);
  -- Fields of the instruction stored in separate locations
  signal ID_opcode, EX_opcode: unsigned (5 downto 0);
  signal ID_imm_offset: unsigned (10 downto 0);
  signal EX_imm_offset: unsigned (7 downto 0);
  signal ID_cond: unsigned (3 downto 0);
  signal ID_Rd_code, EX_Rd_code: unsigned (2 downto 0);

  -- Function and Procedure Definitions
  -- add function returning a 33-bit addition result
  function add33 (l: unsigned; r: unsigned) return unsigned is
  begin
    return ( (l(WORD_SIZE-1) & l) + r );
  end function add33;
  
  -- subtract function returning a 33-bit subtraction result
  function sub33 (l: unsigned; r: unsigned) return unsigned is
  begin
    return ( (l(WORD_SIZE-1) & l) - r );
  end function sub33;
  
  -- Function to check condition codes
  function condition_passed (cond_code: unsigned(3 downto 0);
    N_Flag, Z_Flag, C_Flag, V_Flag: std_logic) return boolean is
  begin
    case cond_code is  -- codes in Table 3-1 of (ARM 2000)
      when "0000" => return (Z_Flag = '1'); -- EQ (equal)
      when "0001" => return (Z_Flag = '0'); -- NE (not equal)
      when "0010" => return (C_Flag = '1'); -- CS/HS (carry)
      when "0011" => return (C_Flag = '0'); -- CC (no carry)
      when "0100" => return (N_Flag = '1'); -- MI (minus)
      when "0101" => return (N_Flag = '0'); -- PL (plus)
      when "0110" => return (V_Flag = '1'); -- VS (overflow)
      when "0111" => return (V_Flag = '0'); -- VC (no overflow)
      when "1000" => return ((C_Flag = '1') and (Z_Flag = '0'));
                                            -- HI
      when "1001" => return ((C_Flag = '0') and (Z_Flag = '1'));
                                            -- LS
      when "1010" => return (N_Flag = V_Flag);  -- GE
      when "1011" => return (N_Flag /= V_Flag); -- LT
      when "1100" => return ((Z_Flag='0') and (N_Flag=V_Flag));
                                            -- GT (greater than)
      when "1101" => return ((Z_Flag='1') and (N_Flag/=V_Flag));
                                            -- LE (less or eq)
      when "1110" => return true; -- AL (always)
      when others => return true; -- "1111" invalid
    end case; -- end of case cond_code is
  end function condition_passed;

begin  -- main body of architecture thumb
  -- continuous assignment statements
  instruction_address <= PC;  -- set instr. address to PC
  write_data_n <= enable_write_data_n;
  data <= DR when (enable_write_data_n = '0')
    else (others => 'Z');
  
  -- segments of the pipeline are modeled using process blocks
  IF_seg: process(reset_n, clk) is  -- instruction fetch segment
  begin
    if (reset_n = '0') then
      PC <= (others => '0');     -- start fetching at address 0
      read_instruction_n <= '0'; -- and enable read from memory
    elsif rising_edge(clk) then  -- on positive clock edge
      read_instruction_n <= '0'; -- enable read from memory
      if (branch_taken = '1') then
        PC <= branch_target;   -- main operation for IF stage
        IF_IR <= UNDEFINED_INSTRUCTION; -- to create a pipeline
        IF_PC <= branch_target;         -- stall (bubble)
      else  -- no branch taken
        PC <= PC + 2;          -- main operation for IF stage
        IF_IR <= instruction;  -- store instruction in IF_IR
        IF_PC <= PC + 2;       -- store updated PC value in IF_PC
      end if;
    end if; -- of elsif rising_edge(clk)
  end process IF_seg;

  ID: process(clk) is          -- ID: instruction decode segment
  begin
    if rising_edge(clk) then  -- on positive clock edge
    case IF_IR(HWORD_SIZE-1 downto 13) is
      when "000" =>            -- shift by immediate or add/sub
        case IF_IR(12 downto 11) is
          when "11" =>
            case IF_IR(10 downto 9) is
              when "10" =>     -- if imm = 000, same as MOV_2
                ID_opcode <= ADD_1;
                ID_imm_offset(2 downto 0) <= IF_IR(8 downto 6);
                ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
                ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
                ID_Rd_code <= IF_IR(2 downto 0);
              when "00" =>
                ID_opcode <= ADD_3;
                ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
                ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
                ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
                ID_Rd_code <= IF_IR(2 downto 0);
              when "11" =>
                ID_opcode <= SUB_1;
                ID_imm_offset(2 downto 0) <= IF_IR(8 downto 6);
                ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
                ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
                ID_Rd_code <= IF_IR(2 downto 0);
              when others => -- = case "01"
                ID_opcode <= SUB_3;
                ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
                ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
                ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
                ID_Rd_code <= IF_IR(2 downto 0);
            end case;
          -- end of case IF_IR(12 downto 11) = "11"
          when "10" =>
            ID_opcode <= ASR_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "00" =>
            ID_opcode <= LSL_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when others => -- = case "01"
            ID_opcode <= LSR_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
        end case;
      -- end of case IF_IR(HWORD-1 downto 13) = "000"
      when "001" => -- add/sub/compare/move immediate
        case IF_IR(12 downto 11) is
          when "10" =>
            ID_opcode <= ADD_2;
            ID_Rd <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_Rd_code <= IF_IR(10 downto 8);
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when "01" =>
            ID_opcode <= CMP_1;
            ID_Rn <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when "00" =>
            ID_opcode <= MOV_1;
            ID_Rd <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_Rd_code <= IF_IR(10 downto 8);
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when others => -- = case "11"
            ID_opcode <= SUB_2;
            ID_Rd <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_Rd_code <= IF_IR(10 downto 8);
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
        end case;
      -- end of case IF_IR(HWORD-1 downto 13) = "001"
      when "010" => -- data processing
        case IF_IR(12 downto 6) is
          when B"000_0101" =>
            ID_opcode <= ADC;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_0000" =>
            ID_opcode <= AND_OP;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_0100" =>
            ID_opcode <= ASR_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_1110" =>
            ID_opcode <= BIC;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_1011" =>
            ID_opcode <= CMN;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rn <= R(TO_INTEGER(IF_IR(2 downto 0)));
          when B"000_1010" =>
            ID_opcode <= CMP_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rn <= R(TO_INTEGER(IF_IR(2 downto 0)));
          when B"000_0001" =>
            ID_opcode <= EOR;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_0010" =>
            ID_opcode <= LSL_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_0011" =>
            ID_opcode <= LSR_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_0111" =>
            ID_opcode <= ROR_OP;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_0110" =>
            ID_opcode <= SBC;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_1101" =>
            ID_opcode <= MUL;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_1111" =>
            ID_opcode <= MVN;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_1001" =>
            ID_opcode <= NEG;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_1100" =>
            ID_opcode <= ORR;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when B"000_1000" =>
            ID_opcode <= TST;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rn <= R(TO_INTEGER(IF_IR(2 downto 0)));
          when others =>
            if (IF_IR(12 downto 11) = "01") then
              ID_opcode <= LDR_3;
              ID_Rd <= R(TO_INTEGER(IF_IR(10 downto 8)));
              ID_Rd_code <= IF_IR(10 downto 8);
              ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
            else
              case IF_IR(12 downto 9) is
                when "1100" =>
            ID_opcode <= LDR_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "1110" =>
            ID_opcode <= LDRB_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "1101" =>
            ID_opcode <= LDRH_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "1011" =>
            ID_opcode <= LDRSB;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "1111" =>
            ID_opcode <= LDRSH;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "1000" =>
            ID_opcode <= STR_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "1010" =>
            ID_opcode <= STRB_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "1001" =>
            ID_opcode <= STRH_2;
            ID_Rm_Rs <= R(TO_INTEGER(IF_IR(8 downto 6)));
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when others => ID_opcode <= UNDEF;
          end case;
          end if;
        end case;
      -- end of case IF_IR(HWORD-1 downto 13) = "010"
      when "011" => -- load/store word/byte immediate offset
        case IF_IR(12 downto 11) is
          when "01" =>
            ID_opcode <= LDR_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "11" =>
            ID_opcode <= LDRB_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "00" =>
            ID_opcode <= STR_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when others => -- = case "10"
            ID_opcode <= STRB_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
        end case;
      -- end of case IF_IR(HWORD-1 downto 13) = when "011"
      when "100" => -- other load/store
        case IF_IR(12 downto 11) is
          when "11" =>
            ID_opcode <= LDR_4;
            ID_Rd <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_Rd_code <= IF_IR(10 downto 8);
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when "01" =>
            ID_opcode <= LDRH_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
          when "10" =>
            ID_opcode <= STR_3;
            ID_Rd <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_Rd_code <= IF_IR(10 downto 8);
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when others => -- = case "00"
            ID_opcode <= STRH_1;
            ID_imm_offset(4 downto 0) <= IF_IR(10 downto 6);
            ID_Rn <= R(TO_INTEGER(IF_IR(5 downto 3)));
            ID_Rd <= R(TO_INTEGER(IF_IR(2 downto 0)));
            ID_Rd_code <= IF_IR(2 downto 0);
        end case;
      -- end of case IF_IR(HWORD-1 downto 13) = "100"
      when "101" => -- add to SP/PC or Miscellaneous
        case IF_IR(12 downto 11) is
          when "00" => -- add to PC and store in Rd
            ID_opcode <= ADD_5;
            ID_Rd <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_Rd_code <= IF_IR(10 downto 8);
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when "01" => -- add to SP and store in Rd
            ID_opcode <= ADD_6;
            ID_Rd <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_Rd_code <= IF_IR(10 downto 8);
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when "10" => -- add imm_7 to SP
            case IF_IR(10 downto 8) is
              when "000" =>
                if (IF_IR(7) = '0') then
                  ID_opcode <= ADD_7;
                  ID_imm_offset(6 downto 0) <= IF_IR(6 downto 0);
                else -- IF_IR(7) = '1'
                  ID_opcode <= SUB_4;
                  ID_imm_offset(6 downto 0) <= IF_IR(6 downto 0);
                end if;
              when "100" =>
                ID_opcode <= PUSH_R0;
                ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
              when "101" =>
                ID_opcode <= PUSH_R1;
                ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
              when others => ID_opcode <= UNDEF;
            end case;
          -- end of case IF_IR(12 downto 11) = "10"
          when others => -- = case "11"
            case IF_IR(10 downto 8) is
              when "100" =>
                ID_opcode <= POP_R0;
                ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
              when "101" =>
                ID_opcode <= POP_R1;
                ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
              when others => ID_opcode <= UNDEF;
            end case;
          -- end of case IF_IR(12 downto 11) = "11" (default)
        end case;
      -- end of case IF_IR(HWORD-1 downto 13) = "101"
      when "110" => -- load/store multiple, branch, interrupt
        case IF_IR(12 downto 11) is
          when "01" =>
            ID_opcode <= LDMIA;
            ID_Rn <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when "00" =>
            ID_opcode <= STMIA;
            ID_Rn <= R(TO_INTEGER(IF_IR(10 downto 8)));
            ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
          when others => -- has (IF_IR(12) = '1')
            if (IF_IR(11 downto 8) = "1110") then
              ID_opcode <= UNDEF;
            elsif (IF_IR(11 downto 8) = "1111") then
              ID_opcode <= SWI; -- SWI used as HALT instruction
              ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
            else -- others are valid conditional branch
              ID_opcode <= B_1;
              ID_cond <= IF_IR(11 downto 8);
              ID_imm_offset(7 downto 0) <= IF_IR(7 downto 0);
            end if;
          -- end of case IF_IR(12) = '1' (default)
        end case;
      -- end of case IF_IR(HWORD-1 downto 13) = "110"
      when "111" => -- uncond. branch or subroutine call (BL)
        case IF_IR(12 downto 11) is
          when "00" =>
            ID_opcode <= B_2;
            ID_imm_offset <= IF_IR(10 downto 0);
          when "10" =>
            ID_opcode <= BL_BLX_H10;
            ID_imm_offset <= IF_IR(10 downto 0);
          when "11" =>
            ID_opcode <= BL_BLX_H11;
            ID_imm_offset <= IF_IR(10 downto 0);
          -- note: H=01 is not supported in T Variant 4
          when others => ID_opcode <= UNDEF;
        end case;
      -- end of case IF_IR(HWORD-1 downto 13) = "111"
      when others => ID_opcode <= UNDEF; -- for completeness
    end case;
    -- check for branch, and insert bubble if branch
    if (branch_taken = '1') then
      ID_opcode <= UNDEF;
    end if;
    -- save other pipeline register values
    ID_PC <= IF_PC;
    end if;  -- of outermost if
  end process ID;  -- end of ID stage

  EX: process(reset_n, clk) is -- EX: Instruction Execution Stage
    variable ALU_out: unsigned (WORD_SIZE downto 0);
    alias ALU_short: unsigned (WORD_SIZE-1 downto 0) is
      ALU_out(WORD_SIZE-1 downto 0);
    variable ALU_double: unsigned (WORD_SIZE*2-1 downto 0);
    variable found_i: integer;  -- used for searching
  begin
    if (reset_n = '0') then
      branch_taken <= '0';  -- initialize to branch not taken
      read_data_n <= '1';   -- disable data memory
      enable_write_data_n <= '1';
    elsif rising_edge(clk) then  -- on positive clock edge
      read_data_n <= '1';   -- set default values for data mem.
      enable_write_data_n <= '1';
      if (branch_taken = '1') then
        EX_opcode <= UNDEF;
        branch_taken <= '0';
      else
        case (ID_opcode) is  -- 1st part of EX operations
          when ADC => ALU_out := add33(ID_Rd,
            add33(ID_Rm_Rs, ('0' & C_Flag)));
          when ADD_1 => ALU_out := add33(ID_Rn,
            ID_imm_offset(2 downto 0));
          when ADD_2 => ALU_out := add33(ID_Rd,
            ID_imm_offset(7 downto 0));
          when ADD_3 => ALU_out := add33(ID_Rn, ID_Rm_Rs);
          when ADD_5 => EX_ALU_out <= (ID_PC and X"FFFF_FFFC")
                            + (ID_imm_offset(7 downto 0) & "00");
          when ADD_6 => EX_ALU_out <= SP +
                          (ID_imm_offset(7 downto 0) & "00");
          when ADD_7 => SP <= SP +
            (ID_imm_offset(7 downto 0) & "00");
          when AND_OP => ALU_short := ID_Rd and ID_Rm_Rs;
          when ASR_1 =>
            if (ID_imm_offset(4 downto 0) = B"00000") then
              if (ID_Rm_Rs(WORD_SIZE-1) = '0') then
                ALU_out := '0' & X"0000_0000";
              else
                ALU_out := '1' & X"FFFF_FFFF"; --(WORD_SIZE+1):33
              end if;
            else  -- imm /= 0
              ALU_short := ID_Rm_Rs;
              for i in 0 to WORD_SIZE-1 loop
                if (i < ID_imm_offset(4 downto 0)) then
                  ALU_short := SHIFT_RIGHT(ALU_short, 1);
                  ALU_out(WORD_SIZE-1) := ID_Rm_Rs(WORD_SIZE-1);
                end if;
              end loop;
              --ALU_out(WORD_SIZE-1 downto 0) := SHIFT_RIGHT(
              --  ID_Rm_Rs, TO_INTEGER(ID_imm_offset(4 downto 0)));
              --for i in 0 to
              --  TO_INTEGER(ID_imm_offset(4 downto 0)) - 1 loop
              --  ALU_out(WORD_SIZE-1-i) := ID_Rm_Rs(WORD_SIZE-1);
              --end loop;
              ALU_out(WORD_SIZE) := ID_Rm_Rs(TO_INTEGER
                (ID_imm_offset(4 downto 0))-1);
            end if; -- of elsif imm /= 0
          -- end of case ASR_1
          when ASR_2 =>
            if (ID_Rm_Rs(7 downto 0) < WORD_SIZE) then
              ALU_short := ID_Rd;
              for i in 0 to WORD_SIZE-1 loop
                if (i < ID_Rm_Rs(7 downto 0)) then
                  ALU_short := SHIFT_RIGHT(ALU_short, 1);
                  ALU_out(WORD_SIZE-1) := ID_Rd(WORD_SIZE-1);
                end if;
              end loop;
              --ALU_out(WORD_SIZE-1 downto 0) := SHIFT_RIGHT(
              --  ID_Rd, TO_INTEGER(ID_Rm_Rs(7 downto 0)));
              --for i in 0 to
              --  TO_INTEGER(ID_Rm_Rs(7 downto 0)) - 1 loop
              --  ALU_out(WORD_SIZE-1-i) := ID_Rd(WORD_SIZE-1);
              --end loop;
              ALU_out(WORD_SIZE) := ID_Rd(TO_INTEGER
                (ID_Rm_Rs(7 downto 0))-1);
            else -- Rs(7 downto 0) >= WORD_SIZE
              if (ID_Rd(WORD_SIZE-1) = '0') then
                ALU_out := '0' & X"0000_0000";
              else -- Rd((WORD_SIZE-1) = 1
                ALU_out := '1' & X"FFFF_FFFF"; -- WORD_SIZE+1: 33
              end if;
            end if; -- of elsif Rs(7 downto 0) >= WORD_SIZE
          -- end of case ASR_2
          when B_1 =>  -- conditional branch
            if (condition_passed(ID_cond, N_Flag, Z_Flag,
              C_Flag, V_Flag)) then
              for i in WORD_SIZE-1 downto 9 loop
                ALU_out(i) := ID_imm_offset(7); -- sign-extension
              end loop;
              ALU_out(8 downto 1) := ID_imm_offset(7 downto 0);
              ALU_out(0) := '0';
              branch_taken <= '1';
              branch_target <=
                ID_PC+2 + ALU_out(WORD_SIZE-1 downto 0);
            end if;
          -- end of case B_1
          when B_2 =>  -- unconditional branch
            for i in WORD_SIZE-1 downto 12 loop
              ALU_out(i) := ID_imm_offset(10); -- sign-extension
            end loop;
            ALU_out(11 downto 1) := ID_imm_offset(10 downto 0);
            ALU_out(0) := '0';
            branch_taken <= '1';
            branch_target <=
              (ID_PC+2) + ALU_out(WORD_SIZE-1 downto 0);
          -- end of case B_2
          when BIC => ALU_out(WORD_SIZE-1 downto 0) :=
                        ID_Rd and (not ID_Rm_Rs);
          when BL_BLX_H10 =>
            for i in WORD_SIZE-1 downto 23 loop
              ALU_out(i) := ID_imm_offset(10);
            end loop;
            ALU_out(22 downto 12) := ID_imm_offset(10 downto 0);
            for i in 11 downto 0 loop
              ALU_out(i) := '0';
            end loop;
            LR <= ID_PC + ALU_out(WORD_SIZE-1 downto 0);
          -- end of case BL_BLX_H10
          when BL_BLX_H11 =>
            ALU_short := LR + (ID_imm_offset(10 downto 0) & '0');
            branch_taken <= '1';
            branch_target <= ALU_out(WORD_SIZE-1 downto 0);
            LR <= ALU_short or X"0000_0001";
          -- end of case BL_BLX_H11
          when CMN => ALU_out := add33(ID_Rn, ID_Rm_Rs);
          when CMP_1 => ALU_out :=
            sub33(ID_Rn, ID_imm_offset(7 downto 0));
          when CMP_2 => ALU_out := sub33(ID_Rn, ID_Rm_Rs);
          when EOR => ALU_short := ID_Rd xor ID_Rm_Rs;
          --when LDMIA => null; -- currently unimplemented
          when LDR_1 => ALU_short := ID_Rn +
                          (ID_imm_offset(4 downto 0) & "00");
          when LDR_2 | LDRB_2 | LDRH_2 | LDRSB | LDRSH =>
                  ALU_short := ID_Rn + ID_Rm_Rs;
          when LDR_3 => ALU_short := (ID_PC(WORD_SIZE-1 downto 2)
                 & "00")+ (ID_imm_offset(7 downto 0) & "00");
          when LDR_4 => ALU_short := SP +
                          (ID_imm_offset(7 downto 0) & "00");
          when LDRB_1 => ALU_short := ID_Rn +
                           ID_imm_offset(4 downto 0);
          when LDRH_1 => ALU_short := ID_Rn +
                           (ID_imm_offset(4 downto 0) & '0');
          when LSL_1 => ALU_out := SHIFT_LEFT(('0' & ID_Rm_Rs),
                          TO_INTEGER(ID_imm_offset(4 downto 0)));
          when LSL_2 => if (ID_Rm_Rs(7 downto 0) <= WORD_SIZE)
                        then ALU_out := SHIFT_LEFT(('0' & ID_Rd),
                            TO_INTEGER(ID_Rm_Rs(7 downto 0)));
                        else
                          ALU_out := '0' & X"0000_0000";
                        end if;
          when LSR_1 =>
            ALU_out(WORD_SIZE-1 downto 0) :=SHIFT_RIGHT(ID_Rm_Rs,
              TO_INTEGER(ID_imm_offset(4 downto 0)));
            ALU_out(WORD_SIZE) := ID_Rm_Rs(TO_INTEGER(
              ID_imm_offset(4 downto 0)) - 1);
          when LSR_2 => if (ID_Rm_Rs(7 downto 0) <= WORD_SIZE)
              then ALU_out(WORD_SIZE-1 downto 0) := SHIFT_RIGHT(
                  ID_Rd, TO_INTEGER(ID_Rm_Rs(7 downto 0)));         
                ALU_out(WORD_SIZE) := ID_Rd(TO_INTEGER(
                      ID_Rm_Rs(7 downto 0)) - 1);
              else
                ALU_out := '0' & X"0000_0000";
              end if;
          when MOV_1 => ALU_out(WORD_SIZE-1 downto 0) :=
                    (X"00_0000" & ID_imm_offset(7 downto 0));
          when MUL => ALU_double := ID_Rd * ID_Rm_Rs;
                      ALU_short :=
                        ALU_double(WORD_SIZE-1 downto 0);
          when MVN => ALU_out(WORD_SIZE-1 downto 0) :=
                        not ID_Rm_Rs;
          when NEG => ALU_out :=
                        0 - (ID_Rm_Rs(WORD_SIZE-1) & ID_Rm_Rs);
          when ORR => ALU_out(WORD_SIZE-1 downto 0) :=
                        ID_Rd or ID_Rm_Rs;
          when POP_R0 => -- only POP of 1 register supported
            data_address <= SP;
            read_data_n <= '0';
            SP <= SP + 4;
            EX_imm_offset(7 downto 0) <=
              ID_imm_offset(7 downto 0);
          -- end of case POP_R0
          --POP_R1 => null; -- POP(PC) not supported yet
          when PUSH_R0 => -- only PUSH of 1 register supported
            ALU_out(WORD_SIZE-1 downto 0) := SP - 4;
            found_i := 0;
            for i in 0 to 7 loop -- at least one bit must = 1
              if (ID_imm_offset(i) = '1') then
                found_i := i;
              end if;
            end loop;
            DR <= R(found_i);
            enable_write_data_n <= '0';
            data_address <= ALU_out(WORD_SIZE-1 downto 0);
            SP <= ALU_out(WORD_SIZE-1 downto 0);
            EX_imm_offset(7 downto 0) <=
              ID_imm_offset(7 downto 0);
          -- end of case PUSH_R0
          --PUSH_R1 => null; -- PUSH(PC) not supported yet
          when ROR_OP => ALU_out(WORD_SIZE-1 downto 0) :=
            SHIFT_RIGHT(ID_Rd, TO_INTEGER(ID_Rm_Rs(4 downto 0)));
            ALU_out(WORD_SIZE) := ID_Rd(TO_INTEGER(
              ID_Rm_Rs(4 downto 0)) - 1);
          when SBC => ALU_out := sub33(ID_Rd,
            sub33(ID_Rm_Rs, ('0' & (not C_Flag))));
          --STMIA => null; -- not supported yet
          when STR_1 => ALU_short := ID_Rn +
                          (ID_imm_offset(4 downto 0) & "00");
          when STR_2 | STRB_2 | STRH_2 =>
                  ALU_short := ID_Rn + ID_Rm_Rs;
          when STR_3 => ALU_short := SP +
                          (ID_imm_offset(7 downto 0) & "00");
          when STRB_1 => ALU_short :=
            ID_Rn + ID_imm_offset(4 downto 0);
          when STRH_1 => ALU_short := ID_Rn +
                           (ID_imm_offset(4 downto 0) & '0');
          when SUB_1 => ALU_out := sub33(ID_Rn,
            ID_imm_offset(2 downto 0));
          when SUB_2 => ALU_out := sub33(ID_Rn,
            ID_imm_offset(7 downto 0));
          when SUB_3 => ALU_out := sub33(ID_Rn, ID_Rm_Rs);
          when SUB_4 => SP <= SP -
            (ID_imm_offset(6 downto 0) & "00");
          when SWI => -- currently implemented as a HALT instr.
            branch_taken <= '1';
            branch_target <= ID_PC - 2; -- repeat SWI forever
          when TST => ALU_short := ID_Rn and ID_Rm_Rs;
          when others => ALU_out := (others => 'X');
        end case;
        case ID_opcode is -- 2nd part of EX operations
          when ADD_1 => -- note: (imm = 000) implies MOV_2
            EX_ALU_out(WORD_SIZE-1 downto 0) <=
              ALU_out(WORD_SIZE-1 downto 0);
            if (ID_imm_offset(2 downto 0) /= "000") then
              C_Flag <= ALU_out(WORD_SIZE); -- not MOV_2
              if (ALU_out(WORD_SIZE) /= ALU_out(WORD_SIZE-1))
                then V_Flag <= '1';
                else V_Flag <= '0';
              end if;
            end if;
          when ADC | ADD_2 | ADD_3 | CMN | CMP_1 | CMP_2 |
               NEG | SBC | SUB_1 | SUB_2 | SUB_3 | SUB_4 =>
            EX_ALU_out(WORD_SIZE-1 downto 0) <=
              ALU_out(WORD_SIZE-1 downto 0);
            C_Flag <= ALU_out(WORD_SIZE);
            if (ALU_out(WORD_SIZE) /= ALU_out(WORD_SIZE-1)) then
              V_Flag <= '1';
            else
              V_Flag <= '0';
            end if;
          when ASR_1 | ASR_2 | LSL_1 | LSL_2 | LSR_2 =>
            EX_ALU_out(WORD_SIZE-1 downto 0) <=
              ALU_out(WORD_SIZE-1 downto 0);
            C_Flag <= ALU_out(WORD_SIZE);
          when LDR_1 | LDR_2 | LDR_3 | LDR_4 | LDRB_1 | LDRB_2 |
               LDRH_1 | LDRH_2 | LDRSB | LDRSH =>
            data_address <= ALU_out(WORD_SIZE-1 downto 0);
            read_data_n <= '0';
          when LSR_1 =>
            if (ID_imm_offset(4 downto 0) = B"00000") then
              C_Flag <= ALU_out(WORD_SIZE-1);
              EX_ALU_out(WORD_SIZE-1 downto 0) <= (others => '0');
            else
              C_Flag <= ALU_out(WORD_SIZE);
              EX_ALU_out(WORD_SIZE-1 downto 0) <=
                ALU_out(WORD_SIZE-1 downto 0);
            end if;
          -- end of case LSR_1
          when AND_OP | BIC | EOR | MOV_1 | MUL | MVN | ORR =>
            EX_ALU_out(WORD_SIZE-1 downto 0) <=
              ALU_out(WORD_SIZE-1 downto 0);
          when ROR_OP =>
            if (ID_Rm_Rs(7 downto 0) = X"00") then
              EX_ALU_out(WORD_SIZE-1 downto 0) <= ID_Rd;
            elsif (ID_Rm_Rs(4 downto 0) = B"00000") then
              C_Flag <= ALU_out(WORD_SIZE-1);
              EX_ALU_out(WORD_SIZE-1 downto 0) <= ID_Rd;
            else -- Rs(4 downto 0) > 0
              C_Flag <= ALU_out(WORD_SIZE);
              EX_ALU_out(WORD_SIZE-1 downto 0) <=
                ALU_out(WORD_SIZE-1 downto 0);
            end if;
          -- end of case ROR_OP
          when STR_1 | STR_2 | STR_3 | STRB_1 | STRB_2 | STRH_1 |
               STRH_2 =>
            data_address <= ALU_out(WORD_SIZE-1 downto 0);
            DR <= ID_Rd;
            enable_write_data_n <= '0';
          when others => EX_ALU_out <= (others => 'X');
        end case; -- of second case
        case ID_opcode is -- third part of EX operations
          when ADD_1 | ADC | ADD_2 | ADD_3 | CMN | CMP_1 | CMP_2 |
            NEG | SBC | SUB_1 | SUB_2 | SUB_3 | SUB_4 | ASR_1 |
            ASR_2 | LSL_1 | LSL_2 | LSR_2 | LSR_1 | AND_OP |
            BIC | EOR | MOV_1 | MUL | MVN | ORR | ROR_OP | TST =>
              N_Flag <= ALU_out(WORD_SIZE-1);
              if (ALU_out(WORD_SIZE-1 downto 0) = X"0000_0000")
                then Z_Flag <= '1';
                else Z_Flag <= '0';
              end if;
          when others =>  null;  -- null operation
        end case; -- of third case
        -- then save values into pipeline registers
        EX_opcode <= ID_opcode;
        EX_Rd_code <= ID_Rd_code;
      end if; -- of else (branch not taken)
    end if; -- of else (posedge clk)
  end process EX; -- of EX stage

  WB: process(reset_n, clk) is  -- WB: Write Back Stage
    variable ex_i: integer;        -- loop index
    variable found_ex_i: integer;  -- used for searching
  begin
    if (reset_n = '0') then
      for i in 0 to REG_FILE_SIZE-1 loop
        R(i) <= (others => '1');  -- initialize registers
      end loop;
    elsif rising_edge(clk) then  -- on positive clock edge
    case EX_opcode is
      when ADC | ADD_1 | ADD_2 | ADD_3 | ADD_5 | ADD_6 | AND_OP |
      ASR_1 | ASR_2 | BIC | EOR | LSL_1 | LSL_2 | LSR_1 |
      LSR_2 | MOV_1 | ROR_OP |
      SBC | SUB_1 | SUB_2 | SUB_3 | SUB_4 =>
        R(TO_INTEGER(EX_Rd_code)) <= EX_ALU_out;  -- write to Rd
      when LDR_1 | LDR_2 | LDR_3 | LDR_4 =>
        R(TO_INTEGER(EX_Rd_code)) <= data;  -- load from data mem.
      when LDRB_1 | LDRB_2 => R(TO_INTEGER(EX_Rd_code)) <=
                    (X"00_0000" & data(7 downto 0));
      when LDRH_1 | LDRH_2 => R(TO_INTEGER(EX_Rd_code)) <=
                    (X"0000" & data(HWORD_SIZE-1 downto 0));
      when LDRSB => if (data(7) = '1') then
                R(TO_INTEGER(EX_Rd_code)) <=
                  (X"FF_FFFF" & data(7 downto 0));
              else
                R(TO_INTEGER(EX_Rd_code)) <=
                  (X"00_0000" & data(7 downto 0));
              end if;
      when LDRSH => if (data(HWORD_SIZE-1) = '1') then
                R(TO_INTEGER(EX_Rd_code)) <=
                  (X"FFFF" & data(HWORD_SIZE-1 downto 0));
              else
                R(TO_INTEGER(EX_Rd_code)) <=
                 (X"0000" & data(HWORD_SIZE-1 downto 0));
              end if;
      when POP_R0 =>  -- currently, only POP of 1 reg supported
        found_ex_i := 0;
        for ex_i in 0 to 7 loop -- at least one bit must = 1
          if (EX_imm_offset(ex_i) = '1') then
            found_ex_i := ex_i;
          end if;
        end loop;
        R(found_ex_i) <= data;
      -- end of case POP_R0
      when UNDEF => null;
      when others => null;
    end case;
    end if;  -- of outermost if
  end process WB; -- end of WB stage

end architecture thumb;
-----------------------------------------------------------------
