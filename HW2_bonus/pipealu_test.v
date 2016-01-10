module pipealu_test;
	//input
	reg [15:0] instr;
	reg clk;
	reg rst;
	//output
	wire [31:0] AluOut;
	wire Zero;
	wire Carryout;
	wire Overflow;
	wire read_data_n;            // control read from data memory
    wire write_data_n;           // control write to data memory
    wire [31:0] data_address; // address of data
    wire [31:0] data;         // current data
	reg [31:0] output_data;        // data memory output
    reg [31:0] write_data;         // data to be written
	reg [31:0] data_memory [0:15];
	assign data = read_data_n ? 32'bz : output_data;
	
	pipealu test
	(
		.instr(instr),
		.clk(clk),
		.rst(rst),
		.AluOut(AluOut),
		.Zero(Zero),
		.Carryout(Carryout),
		.Overflow(Overflow),
		.data(data),
		.data_address(data_address),
		.read_data_n(read_data_n),
		.write_data_n(write_data_n)
	);
	
	always begin
    if (read_data_n == 0) begin
      output_data = data_memory[data_address[7:0]];
      wait ((read_data_n == 1) ||
            (output_data != data_memory[data_address[7:0]]));
    end
    else begin  // end of read
      output_data = 32'bz;
      wait (read_data_n == 0);
    end
  end  // of always block for data memory read

  // model the write process for the data memory device
  always begin
    wait (write_data_n == 0);
    write_data = data;
    wait ((write_data_n == 1) || (data != write_data));
    if (write_data_n == 1) begin  // wait for write enable = '1'
      data_memory[data_address[7:0]] = write_data;
    end
    else  // data != write_data (data has changed)
      write_data = data;
  end  // of always block for data memory write
	
initial begin
clk = 1'b0;
forever #20 clk = ~clk ;
end
	
initial begin
	data_memory[0]<=32'd1;
	data_memory[1]<=32'd2;
	data_memory[2]<=32'd3;
	data_memory[3]<=32'd4;
	data_memory[4]<=32'd5;
	data_memory[5]<=32'd6;
	data_memory[6]<=32'd7;
	data_memory[7]<=32'd8;
	data_memory[8]<=32'd9;
	data_memory[9]<=32'd10;
	data_memory[10]<=32'd11;
	data_memory[11]<=32'd12;
	data_memory[12]<=32'd13;
	data_memory[13]<=32'd14;
	data_memory[14]<=32'd15;
	data_memory[15]<=32'd16;
	rst = 0;
	#10;
	rst = 1;
	#10;
	instr = 16'hd000;//ldr reg[0]<-data_memory[0]
	#40;
	instr = 16'hd001;//ldr reg[1]<-data_memory[1]
	#40;
	instr = 16'hd002;//ldr
	#40;
	instr = 16'hd003;//ldr
	#40;
	instr = 16'hd004;//ldr
	#40;
	instr = 16'hd005;//ldr
	#40;
	instr = 16'hd006;//ldr
	#40;
	instr = 16'hd007;//ldr
	#40;
	instr = 16'hd008;//ldr
	#40;
	instr = 16'hd009;//ldr
	#40;
	instr = 16'hd00a;//ldr
	#40;
	instr = 16'hd00b;//ldr
	#40;
	instr = 16'hd00c;//ldr
	#40;
	instr = 16'hd00d;//ldr
	#40;
	instr = 16'hd00e;//ldr
	#40;
	instr = 16'hd00f;//ldr
	#40;
	instr = 16'h0562;//R2 = R5 & R6
	#40;
	instr = 16'h1345;//R5 = R4 | R3
	#40;
	instr = 16'h2678;//R8 = R6 + R7
	#40;
	instr = 16'h69ab;//R11 = R10 -R9
	#40;
	instr = 16'h7cde;//R14 = a(R12)<b(R13) ? 1 : 0
	#40;
	instr = 16'hccef;//R15 = R12 nor R14
	#40;
	instr = 16'h654d;//R13 = R4 - R5 = 0
	#40;
	instr = 16'he020;//str reg[2]->data_memory[0]
	#40;
	instr = 16'hf000;//nop
	#40;
	instr = 16'he081;//str reg[8]->data_memory[1]
	#40;
	instr = 16'hf000;//nop
	#120;
	$stop;
end		

endmodule