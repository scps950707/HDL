-----------------------------------------------------------------
-- MODULE: Test bench for pipelined Thumb microproc: tb_thumb.vhd
-- Author: Sunggu Lee
-- Created: September 7, 2003
-- Last Modified: September 15, 2003
-- Description: Tests the module "thumb.vhd".

-- Libary and package statements
library std;
use std.textio.all;

library IEEE;  
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_textio.all;
use IEEE.std_logic_unsigned.all;
use work.THUMB_CONSTANTS.all;



-- Entity definition
entity tb_thumb is       -- a test bench has no I/O ports
end entity tb_thumb;

-- Architecture definition
architecture tb_thumb of tb_thumb is
  -- definitions of constants used in test bench description
  constant PERIOD1: time := 100 ns; -- system clock cycle: 10MHz
  constant READ_DELAY: time := 80 ns;  -- memory read delay
  constant WRITE_DELAY: time := 80 ns; -- memory write delay
  constant STABLE_TIME: time := 10 ns; -- data stable after read
  constant MEMORY_SIZE: integer := 256;
           -- size of memory is 2^8 words (reduced size)
           -- - use only 8 lowest bits of address word

  -- SIGNAL DECLARATIONS for UUT (unit under test) I/O ports
  signal read_instruction_n: std_logic;  -- control instr. read
  signal instruction_address: unsigned(WORD_SIZE-1 downto 0);
  signal instruction: unsigned(HWORD_SIZE-1 downto 0);
  signal read_data_n: std_logic;  -- control data memory read
  signal write_data_n: std_logic; -- control data memory write
  signal data_address: unsigned(WORD_SIZE-1 downto 0);
  signal data: unsigned(WORD_SIZE-1 downto 0);
  signal reset_n: std_logic;      -- active-low reset and clock
  signal clk: std_logic := '0';   -- clock with period PERIOD1

  -- SIGNAL DECLARATIONS for signals being used internally
  -- outputs from instruction and data memories
  signal output_instruction: unsigned(HWORD_SIZE-1 downto 0);
  signal output_data: unsigned(WORD_SIZE-1 downto 0);
  type hword_array is array (0 to MEMORY_SIZE-1) of
                      unsigned (HWORD_SIZE-1 downto 0);
  type word_array is array (0 to MEMORY_SIZE-1) of
                      unsigned (WORD_SIZE-1 downto 0);
  signal instruction_memory: hword_array; -- reduced size memory
  signal data_memory: word_array;    -- reduced size data memory

  -- Component Declarations
  component thumb is
    port (read_instruction_n: out std_logic;
          instruction_address: out unsigned(WORD_SIZE-1 downto 0);
          instruction: in unsigned(HWORD_SIZE-1 downto 0);
          read_data_n, write_data_n: out std_logic;
          data_address: out unsigned(WORD_SIZE-1 downto 0);
          data: inout unsigned(WORD_SIZE-1 downto 0);
          reset_n, clk: in std_logic);
  end component thumb;

begin  -- of body of architecture tb_thumb

  -- Instantiate the unit under test
  uut: component thumb port map (read_instruction_n,
    instruction_address, instruction, read_data_n, write_data_n,
    data_address, data, reset_n, clk);
  
  -- Generate a low pulse on the reset_n signal
  reset_n <= '1', '0' after PERIOD1/4, '1' after PERIOD1*2.25;

  -- Generate the clock
  -- Note: assumes clock has been initialized to '0' above
  clock: process is begin
    wait for (PERIOD1/2);
    clk <= not clk;
  end process clock;

  -- model the read process for the instruction memory device
  instruction <= output_instruction when
    (read_instruction_n = '0') else (others => 'Z');
  instruction_memory_read: process is
    variable addr: unsigned(WORD_SIZE-1 downto 0);
  begin
    if (read_instruction_n = '0') then
      wait for READ_DELAY;
      addr := instruction_address;
      output_instruction <= instruction_memory(
        TO_INTEGER(instruction_address(7 downto 0)));
      wait until ((read_instruction_n = '1') or
                  (addr /= instruction_address));
    else  -- read_instruction_n = '1'
      wait for STABLE_TIME;
      output_instruction <= (others => 'Z');
      wait until (read_instruction_n = '0');
    end if;
  end process instruction_memory_read;

  -- model the read process for the data memory device
  data <= output_data when (read_data_n = '0')
    else (others => 'Z');  -- tri-state data output
  data_memory_read: process is
    variable addr: unsigned(WORD_SIZE-1 downto 0);
  begin
    if (read_data_n = '0') then
      wait for READ_DELAY;
      addr := data_address;
      output_data <=
        data_memory(TO_INTEGER(data_address(7 downto 0)));
      wait until ((read_data_n = '1') or
                  (addr /= data_address));
    else  -- read_data_n = '1'
      wait for STABLE_TIME;
      output_data <= (others => 'Z');
      wait until (read_data_n = '0');
    end if;
  end process data_memory_read;

  -- model the write process for the data memory device
  data_memory_write: process is
    variable write_data: unsigned(WORD_SIZE-1 downto 0);
  begin
    wait until (write_data_n = '0');
      write_data := data;
    wait until ((write_data_n = '1') or (data /= write_data));
    if (write_data_n = '1') then
      wait for WRITE_DELAY;
      data_memory(TO_INTEGER(data_address(7 downto 0)))
        <= write_data;
    else  -- data != write_data (data has changed)
      write_data := data;
    end if;
  end process data_memory_write;
      
  -- store programs and data in the instruction and memories
   
  stored_program: process is
	variable byte:character;
	variable output:character;
	type char_file is file of character;
	FILE file_in: char_file is "Lena_bmp.bmp";
	file file_out : char_file open WRITE_MODE is "YUV.bmp";
	type unsigned_arr is array (0 to 299999) of unsigned(7 downto 0);
	variable b_arr:unsigned_arr;
	variable g_arr:unsigned_arr;
	variable r_arr:unsigned_arr;
  begin
	
	for i in 0 to 53 loop
		read(file_in,byte);
		write(file_out,byte);
	end loop;
	
	for i in 0 to 262143 loop
		read(file_in, byte);
		b_arr(i):=to_unsigned(character'pos(byte),8);
		read(file_in, byte);
		g_arr(i):=to_unsigned(character'pos(byte),8);
		read(file_in, byte);
		r_arr(i):=to_unsigned(character'pos(byte),8);
	end loop;
	
	for i in 0 to 262143 loop
	--R*0.299
	instruction_memory(0) <= X"2700"; -- MOV r7, #0
	instruction_memory(2) <= X"2100"; -- MOV r1, #0 used to wait r7
	instruction_memory(4) <= X"2100"; -- MOV r1, #0	used to wait r7
	instruction_memory(6) <= X"20"&r_arr(i); -- MOV r0, r
	instruction_memory(8) <= X"2100"; -- MOV r1, #0 used to wait r0
	instruction_memory(10)<= X"2100"; -- MOV r1, #0 used to wait r0
	instruction_memory(12)<= X"1083"; -- r3 <= r0 >> 2
	instruction_memory(14)<= X"1144"; -- r4 <= r0 >> 5
	instruction_memory(16)<= X"1185"; -- r5 <= r0 >> 6
	instruction_memory(18)<= X"1206"; -- r6 <= r0 >> 8
	instruction_memory(20)<= X"18e3"; -- ADD r3,r3,r4
	instruction_memory(22)<= X"2100"; -- MOV r1, #0 used to wait r6
	instruction_memory(24)<= X"1975"; -- ADD r5,r5,r6
	instruction_memory(26)<= X"2100"; -- MOV r1, #0 used to wait r5
	instruction_memory(28)<= X"2100"; -- MOV r1, #0 used to wait r5
	instruction_memory(30)<= X"18eb"; -- ADD r3,r3,r5
	instruction_memory(32)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(34)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(36)<= X"60fb"; -- STR r3,(r7,#3*4)
	--G*0.589
	instruction_memory(38)<= X"2100"; -- MOV r1, #0 used to avoid structural Hazards
	instruction_memory(40)<= X"20"&g_arr(i); -- MOV r0, g
	instruction_memory(42)<= X"2100"; -- MOV r1, #0 used to wait r0
	instruction_memory(44)<= X"2100"; -- MOV r1, #0 used to wait r0
	instruction_memory(46)<= X"1043"; -- r3 <= r0 >> 1
	instruction_memory(48)<= X"1104"; -- r4 <= r0 >> 4
	instruction_memory(50)<= X"1185"; -- r5 <= r0 >> 6
	instruction_memory(52)<= X"11c6"; -- r6 <= r0 >> 7
	instruction_memory(54)<= X"18e3"; -- ADD r3,r3,r4
	instruction_memory(56)<= X"2100"; -- MOV r1, #0 used to wait r6
	instruction_memory(58)<= X"1975"; -- ADD r5,r5,r6
	instruction_memory(60)<= X"2100"; -- MOV r1, #0 used to wait r5
	instruction_memory(62)<= X"2100"; -- MOV r1, #0 used to wait r5
	instruction_memory(64)<= X"18eb"; -- ADD r3,r3,r5
	instruction_memory(66)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(68)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(70)<= X"613b"; -- STR r3,(r7,#4*4)
	--B*0.114
	instruction_memory(72)<= X"2100"; -- MOV r1, #0 used to avoid structural Hazards
	instruction_memory(74)<= X"20"&b_arr(i); -- MOV r0, b
	instruction_memory(76)<= X"2100"; -- MOV r1, #0 used to wait r0
	instruction_memory(78)<= X"2100"; -- MOV r1, #0 used to wait r0
	instruction_memory(80)<= X"1103"; -- r3 <= r0 >> 4
	instruction_memory(82)<= X"1144"; -- r4 <= r0 >> 5
	instruction_memory(84)<= X"1185"; -- r5 <= r0 >> 6
	instruction_memory(86)<= X"11c6"; -- r6 <= r0 >> 7
	instruction_memory(88)<= X"18e3"; -- ADD r3,r3,r4
	instruction_memory(90)<= X"2100"; -- MOV r1, #0 used to wait r6
	instruction_memory(92)<= X"1975"; -- ADD r5,r5,r6
	instruction_memory(94)<= X"2100"; -- MOV r1, #0 used to wait r5
	instruction_memory(96)<= X"2100"; -- MOV r1, #0 used to wait r5
	instruction_memory(98)<= X"18eb"; -- ADD r3,r3,r5
	instruction_memory(100)<= X"2100"; -- MOV r1, #0 used for wait r3
	instruction_memory(102)<= X"2100"; -- MOV r1, #0 used for wait r3
	instruction_memory(104)<= X"617b"; -- STR r3,(r7,#5*4)
	--Y<=R+G+B
	instruction_memory(106)<= X"2100"; -- MOV r1, #0 used to avoid structural Hazards
	instruction_memory(108)<= X"68fb"; -- LDR r3, (r7,#3*4)
	instruction_memory(110)<= X"693c"; -- LDR r4, (r7,#4*4)
	instruction_memory(112)<= X"697d"; -- LDR r5, (r7,#5*4)
	instruction_memory(114)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(116)<= X"18e3"; -- ADD r3,r3,r4
	instruction_memory(118)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(120)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(122)<= X"18eb"; -- ADD r3,r3,r5
	instruction_memory(124)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(126)<= X"2100"; -- MOV r1, #0 used to wait r3
	instruction_memory(128)<= X"61bb"; -- STR r3, (r7,#6*4)
	instruction_memory(130)<= X"2100"; -- MOV r1, #0 force write back
	instruction_memory(132)<= X"e7bc"; -- jump to 0
	instruction_memory(134)<= X"2100"; -- MOV r1, #0 force write back
	instruction_memory(136)<= X"2100"; -- MOV r1, #0 force write back
	wait for 7050 ns; -- need to be 7000~7200
	output:=character'val(TO_INTEGER(data_memory(24)));
	write(file_out,output);
	write(file_out,output);
	write(file_out,output);
	wait for 50 ns;
	end loop;
	wait for 7200 ns;
	file_close(file_in);
	file_close(file_out);
    report "Simulation completed at time " & time'image(now);
	assert false
	report "simulation ended"
	severity failure;
    wait;  -- end of process
  end process stored_program;

end architecture tb_thumb;
-----------------------------------------------------------------
