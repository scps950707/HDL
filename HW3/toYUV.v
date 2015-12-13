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
  reg [`WORD_SIZE-1:0] data_memory [0:`MEMORY_SIZE-1];

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
  
  
  // store programs and data in the instruction and memories
  initial begin
	//R*0.299
	instruction_memory[0] = 16'h2700; // MOV r7, #0
	instruction_memory[2] = 16'h2100; // MOV r1, #0 used to wait r7
	instruction_memory[4] = 16'h2100; // MOV r1, #0	used to wait r7
	instruction_memory[6] = 16'h6838; // LDR r0, [r7,#0]
	instruction_memory[8] = 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[10]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[12]= 16'h1083; // r3 = r0 >> 2
	instruction_memory[14]= 16'h1144; // r4 = r0 >> 5
	instruction_memory[16]= 16'h1185; // r5 = r0 >> 6
	instruction_memory[18]= 16'h1206; // r6 = r0 >> 8
	instruction_memory[20]= 16'h18e3; // ADD r3,r3,r4
	instruction_memory[22]= 16'h2100; // MOV r1, #0 used to wait r6
	instruction_memory[24]= 16'h1975; // ADD r5,r5,r6
	instruction_memory[26]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[28]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[30]= 16'h18eb; // ADD r3,r3,r5
	instruction_memory[32]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[34]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[36]= 16'h60fb; // STR r3,[r7,#3*4]
	//G*0.589
	instruction_memory[38]= 16'h2100; // MOV r1, #0 used to avoid structural Hazards
	instruction_memory[40]= 16'h6878; // LDR r0, [r7,#1*4]
	instruction_memory[42]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[44]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[46]= 16'h1043; // r3 = r0 >> 1
	instruction_memory[48]= 16'h1104; // r4 = r0 >> 4
	instruction_memory[50]= 16'h1185; // r5 = r0 >> 6
	instruction_memory[52]= 16'h11c6; // r6 = r0 >> 7
	instruction_memory[54]= 16'h18e3; // ADD r3,r3,r4
	instruction_memory[56]= 16'h2100; // MOV r1, #0 used to wait r6
	instruction_memory[58]= 16'h1975; // ADD r5,r5,r6
	instruction_memory[60]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[62]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[64]= 16'h18eb; // ADD r3,r3,r5
	instruction_memory[66]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[68]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[70]= 16'h613b; // STR r3,[r7,#4*4]
	//B*0.114
	instruction_memory[72]= 16'h2100; // MOV r1, #0 used to avoid structural Hazards
	instruction_memory[74]= 16'h68b8; // LDR r0, [r7,#2*4]
	instruction_memory[76]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[78]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[80]= 16'h1103; // r3 = r0 >> 4
	instruction_memory[82]= 16'h1144; // r4 = r0 >> 5
	instruction_memory[84]= 16'h1185; // r5 = r0 >> 6
	instruction_memory[86]= 16'h11c6; // r6 = r0 >> 7
	instruction_memory[88]= 16'h18e3; // ADD r3,r3,r4
	instruction_memory[90]= 16'h2100; // MOV r1, #0 used to wait r6
	instruction_memory[92]= 16'h1975; // ADD r5,r5,r6
	instruction_memory[94]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[96]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[98]= 16'h18eb; // ADD r3,r3,r5
	instruction_memory[100]= 16'h2100; // MOV r1, #0 used for wait r3
	instruction_memory[102]= 16'h2100; // MOV r1, #0 used for wait r3
	instruction_memory[104]= 16'h617b; // STR r3,[r7,#5*4]
	//Y=R+G+B
	instruction_memory[106]= 16'h2100; // MOV r1, #0 used to avoid structural Hazards
	instruction_memory[108]= 16'h68fb; // LDR r3, [r7,#3*4]
	instruction_memory[110]= 16'h693c; // LDR r4, [r7,#4*4]
	instruction_memory[112]= 16'h697d; // LDR r5, [r7,#5*4]
	instruction_memory[114]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[116]= 16'h18e3; // ADD r3,r3,r4
	instruction_memory[118]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[120]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[122]= 16'h18eb; // ADD r3,r3,r5
	instruction_memory[124]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[126]= 16'h2100; // MOV r1, #0 used to wait r3
	instruction_memory[128]= 16'h61bb; // STR r3, [r7,#6*4]
	instruction_memory[130]= 16'h2100; // MOV r1, #0 force write back
  end
  
  
  integer file_in,file_out ,i, file_index;
  reg [7:0]  bmp_data [0:299];
  //reg [7:0]  bmp_data [0:999999];
  reg [7:0]  bmp_header [0:53];
  integer bmp_width, bmp_height, data_start_index, bmp_size;
  
  initial begin
	file_in = $fopen("Lena_bmp.bmp","rb");
	file_out = $fopen("YUV.bmp","wb");
    
	
	//prase header
	file_index = $fread(bmp_header, file_in);
    bmp_width = {bmp_header[21],bmp_header[20],bmp_header[19],bmp_header[18]};
    bmp_height = {bmp_header[25],bmp_header[24],bmp_header[23],bmp_header[22]};
    data_start_index = {bmp_header[13],bmp_header[12],bmp_header[11],bmp_header[10]};
    bmp_size  = {bmp_header[5],bmp_header[4],bmp_header[3],bmp_header[2]};
	
	//write header
	for(i = 0; i < data_start_index ; i = i + 1)
	begin
		$fwrite(file_out,"%c",bmp_header[i]);
	end
	
	
    for(i = 0; i < bmp_size - data_start_index; i = i + 3)
	begin
		if( i%300 == 0)
		begin
			file_index = $fread(bmp_data, file_in);
		end
		//$display("%d:%h",i,bmp_data[(i+2)%300]);
		//$display("%d:%h",i+1,bmp_data[(i+1)%300]);
		//$display("%d:%h\n",i+2,bmp_data[i%300]);
		data_memory[0] = bmp_data[(i+2)%300];
		data_memory[4] = bmp_data[(i+1)%300];
		data_memory[8] = bmp_data[i%300];
		#8000;
		reset_n = 0;
		#(`PERIOD1 * 2) reset_n = 1;
		//$display("i:%d Y:%d\n",i,data_memory[24]);
		$fwrite(file_out,"%c%c%c",data_memory[24],data_memory[24],data_memory[24]);
    end
	
	
	/*
	file_index = $fread(bmp_data, file_in);//bmp_size=1000000
	for(i = 0; i < bmp_size - data_start_index; i = i + 3)
	begin
		//$display("%d:%h",i,bmp_data[i]);
		//$display("%d:%h",i+1,bmp_data[i+1]);
		//$display("%d:%h\n",i+2,bmp_data[i+2]);
		data_memory[0] = bmp_data[i+2];
		data_memory[4] = bmp_data[i+1];
		data_memory[8] = bmp_data[i];
		#8000;
		reset_n = 0;
		#(`PERIOD1 * 2) reset_n = 1;
		//$display("i:%d Y:%d\n",i,data_memory[24]);
		$fwrite(file_out,"%c%c%c",data_memory[24],data_memory[24],data_memory[24]);
    end
	*/
	
	#1000;
    $fclose(file_in);
	$fclose(file_out);
	$stop;
  end
  
endmodule
/////////////////////////////////////////////////////////////////
