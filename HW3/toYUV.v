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
  
  integer fileId,fileOUT ,i, cc;
  reg [7:0]  bmp_data [0:1000000];
  integer bmp_width, bmp_hight, data_start_index, bmp_size;
  // store programs and data in the instruction and memories
  initial begin
    /*instruction_memory[0] = 16'h2100; // MOV r1, #0 (R[1] <- 0)
    instruction_memory[2] = 16'h2200; // MOV r2, #0 (R[2] <- 0)
    instruction_memory[4] = 16'h20fc; // MOV r0, #fc (R[0] <- fc)
    instruction_memory[6] = 16'h2909; // CMP r1, #9 (R[1] == 9)?
    instruction_memory[8] = 16'hda04; // BGE 0x14(if >=, goto 20)
    instruction_memory[10] = 16'he001;// B   0x10(goto 0x10 = 16)
    instruction_memory[12] = 16'h3101;// ADD r1, #1 (R[1] += 1)
    instruction_memory[14] = 16'he7fa;// B   0x6  (goto 0x4 = 6)
    instruction_memory[16] = 16'h1852;// ADD r2, r2, r1
    instruction_memory[18] = 16'he7fb;// B   0xc  (goto 0xc = 12)
    instruction_memory[20] = 16'h6042;// STR R2,R0+1*4(data:0x24)
    instruction_memory[22] = 16'hdf00;// SWI(to halt the program)
    // instruction_memory[22] = 16'h4770;// BX  r14  (goto R[14])
    // last instruction in original assembly is a return to main*/
	
	

	
	//R*0.299
	instruction_memory[0] = 16'h2100; // MOV r1, #0
	instruction_memory[2] = 16'h2600; // MOV r6, #0 used to wait r1
	instruction_memory[4] = 16'h2703; // MOV r7, #3	used to wait r1
	instruction_memory[6] = 16'h6808; // LDR r0, r1,#0
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
	instruction_memory[32]= 16'h2100; // MOV r1, #0 used for wait hazard
	instruction_memory[34]= 16'h2100; // MOV r1, #0 used for wait hazard
	instruction_memory[36]= 16'h603b; // STR r3,[r7,#0]
	//G*0.589
	instruction_memory[38]= 16'h2101; // MOV r1, #1
	instruction_memory[40]= 16'h2600; // MOV r6, #0 used to wait r1
	instruction_memory[42]= 16'h2704; // MOV r7, #4	used to wait r1
	instruction_memory[44]= 16'h6808; // LDR r0, r1,#0
	instruction_memory[46]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[48]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[50]= 16'h1043; // r3 = r0 >> 1
	instruction_memory[52]= 16'h1104; // r4 = r0 >> 4
	instruction_memory[54]= 16'h1185; // r5 = r0 >> 6
	instruction_memory[56]= 16'h11c6; // r6 = r0 >> 7
	instruction_memory[58]= 16'h18e3; // ADD r3,r3,r4
	instruction_memory[60]= 16'h2100; // MOV r1, #0 used to wait r6
	instruction_memory[62]= 16'h1975; // ADD r5,r5,r6
	instruction_memory[64]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[66]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[68]= 16'h18eb; // ADD r3,r3,r5
	instruction_memory[70]= 16'h2100; // MOV r1, #0 used for wait hazard
	instruction_memory[72]= 16'h2100; // MOV r1, #0 used for wait hazard
	instruction_memory[74]= 16'h603b; // STR r3,[r7,#0]
	//B*0.114
	instruction_memory[76]= 16'h2102; // MOV r1, #2
	instruction_memory[78]= 16'h2600; // MOV r6, #0 used to wait r1
	instruction_memory[80]= 16'h2705; // MOV r7, #5	used to wait r1
	instruction_memory[82]= 16'h6808; // LDR r0, r1,#0
	instruction_memory[84]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[86]= 16'h2100; // MOV r1, #0 used to wait r0
	instruction_memory[88]= 16'h1103; // r3 = r0 >> 4
	instruction_memory[90]= 16'h1144; // r4 = r0 >> 5
	instruction_memory[92]= 16'h1185; // r5 = r0 >> 6
	instruction_memory[94]= 16'h11c6; // r6 = r0 >> 7
	instruction_memory[96]= 16'h18e3; // ADD r3,r3,r4
	instruction_memory[98]= 16'h2100; // MOV r1, #0 used to wait r6
	instruction_memory[100]= 16'h1975; // ADD r5,r5,r6
	instruction_memory[102]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[104]= 16'h2100; // MOV r1, #0 used to wait r5
	instruction_memory[106]= 16'h18eb; // ADD r3,r3,r5
	instruction_memory[108]= 16'h2100; // MOV r1, #0 used for wait hazard
	instruction_memory[110]= 16'h2100; // MOV r1, #0 used for wait hazard
	instruction_memory[112]= 16'h603b; // STR r3,[r7,#0]
	//Y=R+G+B
	instruction_memory[114]= 16'h2003; // MOV r0, #3
	instruction_memory[116]= 16'h2104; // MOV r1, #4 used to wait r0
	instruction_memory[118]= 16'h2205; // MOV r2, #5 used to wait r0
	instruction_memory[120]= 16'h6803; // LDR r3, r0,#0
	instruction_memory[122]= 16'h680c; // LDR r4, r1,#0
	instruction_memory[124]= 16'h6815; // LDR r5, r2,#0
	instruction_memory[126]= 16'h2706; // MOV r7, #6 used to wait r4
	instruction_memory[128]= 16'h18e3; // ADD r3,r3,r4
	instruction_memory[130]= 16'h2104; // MOV r1, #4 used to wait r3
	instruction_memory[132]= 16'h2205; // MOV r2, #5 used to wait r3
	instruction_memory[134]= 16'h18eb; // ADD r3,r3,r5
	instruction_memory[136]= 16'h2104; // MOV r1, #4 used to wait r3
	instruction_memory[138]= 16'h2205; // MOV r2, #5 used to wait r3
	instruction_memory[140]= 16'h603b; // STR r3,[r7,#0]
	

	


    fileId = $fopen("Lena_bmp.bmp","rb");
	fileOUT = $fopen("YUV.bmp","wb");
    cc = $fread(bmp_data, fileId);
    bmp_width = {bmp_data[21],bmp_data[20],bmp_data[19],bmp_data[18]};
    bmp_hight = {bmp_data[25],bmp_data[24],bmp_data[23],bmp_data[22]};
    data_start_index = {bmp_data[13],bmp_data[12],bmp_data[11],bmp_data[10]};
    bmp_size  = {bmp_data[5],bmp_data[4],bmp_data[3],bmp_data[2]};
	
	for(i = 0; i < data_start_index ; i = i + 1)
	begin
		$fwrite(fileOUT,"%c",bmp_data[i]);
	end
	
    for(i = data_start_index; i < bmp_size; i = i + 3)
	begin
		//$display("%d:%h",i,bmp_data[i]);
		//$display("%d:%h",i+1,bmp_data[i+1]);
		//$display("%d:%h\n",i+2,bmp_data[i+2]);
		data_memory[0] = bmp_data[i+2];
		data_memory[1] = bmp_data[i+1];
		data_memory[2] = bmp_data[i];
		/*if(i == 9)
		begin
			instruction_memory[142] = 16'hdf00;// SWI(to halt the program)
		end*/
		reset_n = 1;       // generate a LOW pulse for reset_n
		#(`PERIOD1/4) reset_n = 0;
		#(`PERIOD1 * 2) reset_n = 1;
		#8500;
		if(i!=data_start_index)
		begin
			//$display("i:%d Y:%d\n",i,data_memory[6]);
			$fwrite(fileOUT,"%c",data_memory[6]);
			$fwrite(fileOUT,"%c",data_memory[6]);
			$fwrite(fileOUT,"%c",data_memory[6]);
		end
    end
	#8500;
	//$display("i:%d Y:%d\n",i,data_memory[6]);
	$fwrite(fileOUT,"%c",data_memory[6]);
	$fwrite(fileOUT,"%c",data_memory[6]);
	$fwrite(fileOUT,"%c",data_memory[6]);
    $fclose(fileId);
	$fclose(fileOUT);
	

	
	/*data_memory[0] = 32'd147;
	data_memory[1] = 32'd88;
	data_memory[2] = 32'd116;*/
	
		
	/*#8100;
	data_memory[0] = 32'd183;
	data_memory[1] = 32'd129;
	data_memory[2] = 32'd128;
	instruction_memory[142] = 16'hdf00;// SWI(to halt the program)
	reset_n = 1;       // generate a LOW pulse for reset_n
	#(`PERIOD1/4) reset_n = 0;
	#(`PERIOD1 * 2) reset_n = 1;
	#8100;*/
	
	/*for( i= 1;i<3;i=i+1)
	begin
		data_memory[0] = 60*i;
		#2500;
		reset_n = 1;       // generate a LOW pulse for reset_n
		#(`PERIOD1/4) reset_n = 0;
		#(`PERIOD1 * 2) reset_n = 1;
	end*/
	$stop;
  end
  
  

  
  // test output of program to verify proper operation of circuit
  /*initial begin
    //#15700; // this is the time when the program output is avail.
	if ( (data_address === 32'h00000100) &&
         (data === 32'h00000024) )
      $display("Data address (0x100) and data (0x24) correct.");sim:/tb_thumb/UUT/PC
    else
      $display("ERROR: data address = %0x and data = %0x.",
               data_address, data);
    #500;  $display("Simulation completed at time %0t.", $time);
    $stop;  // terminate simulation after 16.2 microseconds
  end*/
  
  
endmodule
/////////////////////////////////////////////////////////////////


module test;
  integer fileId, i, cc;
  reg [7:0]  bmp_data [0:1000000];
  integer bmp_width, bmp_hight, data_start_index, bmp_size;

  initial begin
    fileId = $fopen("Lena_bmp.bmp","rb");
    cc = $fread(bmp_data, fileId);
    bmp_width = {bmp_data[21],bmp_data[20],bmp_data[19],bmp_data[18]};
    bmp_hight = {bmp_data[25],bmp_data[24],bmp_data[23],bmp_data[22]};
    data_start_index = {bmp_data[13],bmp_data[12],bmp_data[11],bmp_data[10]};
    bmp_size  = {bmp_data[5],bmp_data[4],bmp_data[3],bmp_data[2]};
    for(i = data_start_index; i < 64; i = i + 3) begin
      $display("%d:%h",i,bmp_data[i]);
	  $display("%d:%h",i+1,bmp_data[i+1]);
	  $display("%d:%h\n",i+2,bmp_data[i+2]);
    end
    $fclose(fileId);
  end
endmodule
