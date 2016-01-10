/////////////////////////////////////////////////////////////////
// MODULE: Test bench for pipelined Thumb microproc: tb_thumb.v
// Author: Sunggu Lee
// Created: August 15, 2003
// Last Modified: September 13, 2003
// Description: Tests the module "thumb.v".

// DEFINITIONS
`timescale 1ns/1ns
`define PERIOD1 100      // assume system clock cycle of 10MHz
`define READ_DELAY 80    // delay before memory data is ready
`define WRITE_DELAY 80   // delay in writing to memory
`define STABLE_TIME 10   // time data is stable after end-of-read
`define MEMORY_SIZE 256  // size of reduced memory is 2^8 words
                         // - use only 8 lowest bits of address
`include "thumb_defs.vh" // include common defs

// MODULE DEFINITION
module tb_thumb();

  // SIGNAL DECLARATIONS for chip inputs and outputs
  wire read_instruction_n;  // control read from instruction mem
  wire [`WORD_SIZE-1:0] instruction_address; // address of instr
  wire [`HWORD_SIZE-1:0] instruction; // current instruction
  wire read_data_n;            // control read from data memory
  wire write_data_n;           // control write to data memory
  wire [`WORD_SIZE-1:0] data_address; // address of data
  wire [`WORD_SIZE-1:0] data;         // current data
  reg reset_n;    // active-low RESET signal
  reg clk;        // clock signal

  // SIGNAL DECLARATIONS for signals being used internally
  reg [`WORD_SIZE-1:0] output_instruction; // instr. memory outp.
  reg [`WORD_SIZE-1:0] output_data;        // data memory output
  reg [`WORD_SIZE-1:0] write_data;         // data to be written

  // instantiate the unit under test
  thumb UUT (read_instruction_n, instruction_address, instruction,
            read_data_n, write_data_n, data_address, data,
            reset_n, clk);
  
  // initialize inputs
  initial begin
    clk = 0;           // set initial clock value

    reset_n = 1;       // generate a LOW pulse for reset_n
    #(`PERIOD1/4) reset_n = 0;
    #(`PERIOD1 * 2) reset_n = 1;
  end

  // generate the clock
  always #(`PERIOD1/2)clk = ~clk; // period = `PERIOD1

  // model the instruction and data memory devices
  reg [`HWORD_SIZE-1:0] instruction_memory [0:`MEMORY_SIZE-1];
  reg signed [`WORD_SIZE-1:0] data_memory [0:`MEMORY_SIZE-1];

  // model the read process for the instruction memory device
  assign instruction = read_instruction_n ? 'bz
                                          : output_instruction;
  always begin
    if (read_instruction_n == 0) begin
      #`READ_DELAY;  // assume no spurious address changes
      output_instruction =
        instruction_memory[instruction_address[7:0]];
      wait ((read_instruction_n == 1) ||
            (output_instruction !=
             instruction_memory[instruction_address[7:0]]));
    end
    else begin  // end of read
      #`STABLE_TIME;
      output_instruction = `WORD_SIZE'bz;
      wait (read_instruction_n == 0);
    end
  end  // of always block for instruction memory read

  // model the read process for the data memory device
  assign data = read_data_n ? `WORD_SIZE'bz : output_data;
  always begin
    if (read_data_n == 0) begin
      #`READ_DELAY;  // assume no spurious address changes
      output_data = data_memory[data_address[7:0]];
      wait ((read_data_n == 1) ||
            (output_data != data_memory[data_address[7:0]]));
    end
    else begin  // end of read
      #`STABLE_TIME;
      output_data = `WORD_SIZE'bz;
      wait (read_data_n == 0);
    end
  end  // of always block for data memory read

  // model the write process for the data memory device
  always begin
    wait (write_data_n == 0);
    write_data = data;
    wait ((write_data_n == 1) || (data != write_data));
    if (write_data_n == 1) begin  // wait for write enable = '1'
      #`WRITE_DELAY;
      data_memory[data_address[7:0]] = write_data;
    end
    else  // data != write_data (data has changed)
      write_data = data;
  end  // of always block for data memory write
  
  integer fileId,fileOUT ,i,x,y, cc;
  reg [7:0]  bmp_data [0:1000000];
  reg [7:0]  bmp_header [0:53];
  integer bmp_width, bmp_height, data_start_index, bmp_size;
  // store programs and data in the instruction and memories
  initial begin
	//r0:leftup r1:rightup r2:left r3:right r4:leftdown r5:rightdown
	/*data_memory[0]=32'd10;
	data_memory[4]=32'd13;
	data_memory[8]=32'd15;
	data_memory[12]=32'd11;
	data_memory[16]=32'd8;
	data_memory[20]=32'd17;*/
	//test data:the output above should be 4
	instruction_memory[0] = 16'h2700; // MOV r7, #0
	instruction_memory[2] = 16'h2100; // MOV r1, #0 used to wait r7
	instruction_memory[4] = 16'h2200; // MOV r2, #0	used to wait r7
	instruction_memory[6] = 16'h6838; // LDR r0, [r7,#0]
	instruction_memory[8] = 16'h6879; // LDR r1, [r7,#1*4]
	instruction_memory[10]= 16'h68ba; // LDR r2, [r7,#2*4]
	instruction_memory[12]= 16'h68fb; // LDR r3, [r7,#3*4]
	instruction_memory[14]= 16'h693c; // LDR r4, [r7,#4*4]
	instruction_memory[16]= 16'h697d; // LDR r5, [r7,#5*4]
	instruction_memory[18]= 16'h1a9a; // SUB r2,r3,r2;
	instruction_memory[20]= 16'h1a08; // SUB r0,r1,r0;
	instruction_memory[22]= 16'h1b2c; // SUB r4,r5,r4;
	instruction_memory[24]= 16'h0052; // LSL r2,#2
	instruction_memory[26]= 16'h2600; // MOV r6, #0
	instruction_memory[28]= 16'h1820; // ADD r0,r0,r4
	instruction_memory[30]= 16'h2600; // MOV r6, #0	//wait r0
	instruction_memory[32]= 16'h2600; // MOV r6, #0 //wait r0
	instruction_memory[34]= 16'h1810; // ADD r0,r0,r2
	instruction_memory[36]= 16'h2600; // MOV r6, #0	//wait r0
	instruction_memory[38]= 16'h2600; // MOV r6, #0 //wait r0
	instruction_memory[40]= 16'h61b8; // STR r0,[r7,#6*4]
	instruction_memory[42]= 16'h2600; // MOV r6, #0 force write back
	//instruction_memory[42]= 16'hdf00; // SWI(to halt the program)
	
	fileId = $fopen("YUV.bmp","rb");
	fileOUT = $fopen("edge.bmp","wb");
    cc = $fread(bmp_header, fileId);
    bmp_width = {bmp_header[21],bmp_header[20],bmp_header[19],bmp_header[18]};
    bmp_height = {bmp_header[25],bmp_header[24],bmp_header[23],bmp_header[22]};
    data_start_index = {bmp_header[13],bmp_header[12],bmp_header[11],bmp_header[10]};
    bmp_size  = {bmp_header[5],bmp_header[4],bmp_header[3],bmp_header[2]};
	cc = $fread(bmp_data, fileId);
	for(i = 0; i < data_start_index ; i = i + 1)
	begin
		$fwrite(fileOUT,"%c",bmp_header[i]);
	end
	
	for(y = 0;y != bmp_height;y = y+1)
	begin
		for(x = 0;x != bmp_width;x = x+1)
		begin
			if ( ( x > 0 && x < bmp_width - 1 ) && ( y > 0 && y < bmp_height - 1) )
				begin
					//$display("X:%d Y:%d B:%x\n",x,y,bmp_data[3*(bmp_width*y+x)]);
					//r0:leftup r1:rightup r2:left r3:right r4:leftdown r5:rightdown
					data_memory[0] = bmp_data[3*(bmp_width*(y-1)+(x-1))];
					data_memory[4] = bmp_data[3*(bmp_width*(y-1)+(x+1))];
					data_memory[8] = bmp_data[3*(bmp_width*y+(x-1))];
					data_memory[12]= bmp_data[3*(bmp_width*y+(x+1))];
					data_memory[16]= bmp_data[3*(bmp_width*(y+1)+(x-1))];
					data_memory[20]= bmp_data[3*(bmp_width*(y+1)+(x+1))];
					reset_n = 0;
					#(`PERIOD1 * 2) reset_n = 1;
					#3000;
					if(data_memory[24]<0)
						begin
							data_memory[24]=0-data_memory[24];
						end
					//$display("X:%d Y:%d B:%d\n",x,y,data_memory[24]);
					if(data_memory[24]>64)
						begin
							$fwrite(fileOUT,"%c%c%c",255,255,255);//white
						end
					else
						begin
							$fwrite(fileOUT,"%c%c%c",0,0,0);//black
						end
					//$fwrite(fileOUT,"%c%c%c",data_memory[24],data_memory[24],data_memory[24]);
				end
			else
				begin
					$fwrite(fileOUT,"%c%c%c",0,0,0);//black
				end
		end
	end
	#3000;
	$fclose(fileId);
	$fclose(fileOUT);
	$stop;
  end
  
endmodule
/////////////////////////////////////////////////////////////////