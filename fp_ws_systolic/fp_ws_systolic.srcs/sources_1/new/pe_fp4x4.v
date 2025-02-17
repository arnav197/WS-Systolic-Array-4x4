`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 16:49:47
// Design Name: 
// Module Name: pe_fp4x4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ns

module pe_fp4x4 #(parameter bit_width=8, acc_width=32)(
    clk,
    control,
    acc_in,    //a
    acc_out,   //a+b*c
    data_in,   //b
    wt_path_in,      //c
    data_out,
    wt_path_out 
  //  wt_path_out      
 );
   input clk;
   input control; // control signal used to indidate if it is weight loading or not
   
   input [acc_width-1:0] acc_in; // accumulation in
   input [bit_width-1:0] data_in;  // data input or activation in
   input [bit_width-1:0] wt_path_in;   // weight data in
   output reg [acc_width-1:0] acc_out;  // accumulation out
   output reg [bit_width-1:0] data_out;    // activation out
   output reg [bit_width-1:0] wt_path_out;      // weight data out
   
   // A register to store the stationary weights
   reg [bit_width-1:0] mac_weight;
   
   wire [acc_width-1:0] mult;
   wire [acc_width-1:0] accum_out;
   
   // Fixed Point Multiplier
   fp_mul inst_mul (.a({{8'b0},data_in}), .b({{8'b0},mac_weight}), .result(mult));
   
   
   
   // Fixed Point Adder 
   fp_add inst_add (.a(acc_in), .b(mult), .c(accum_out));
   
   // implement your MAC Unit below
   always@(posedge clk) begin
      if (control) begin
         data_out    <= 'h0;
         acc_out     <= 'h0;
         mac_weight  <= wt_path_in;
         wt_path_out <= wt_path_in;
      end else begin
         data_out    <= data_in;
         acc_out     <= accum_out;
      end
   end

endmodule
