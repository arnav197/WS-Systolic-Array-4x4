`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.02.2025 14:25:48
// Design Name: 
// Module Name: tb_gp4x4
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


`timescale 1ns / 1ps

module tb_gp4x4;

    // **Parameters**
    parameter BIT_WIDTH = 16;
    parameter ACC_WIDTH = 32;
    parameter SIZE = 4;
    parameter DEPTH = 4;

    // **Testbench Signals**
    reg clk;
    reg control;
    reg [(BIT_WIDTH * DEPTH) - 1:0] data_arr;
    reg [63:0] wt_arr;  // Assuming 4x4 weights are loaded row-wise
    wire [ACC_WIDTH  - 1:0] acc_out;

    // **Instantiate the 4x4 Systolic Array**
    top #(.depth(DEPTH), .bit_width(BIT_WIDTH), .acc_width(ACC_WIDTH), .size(SIZE)) DUT (
        .clk(clk),
        .control(control),
        .data_arr(data_arr),
        .wt_arr(wt_arr),
        .acc_out(acc_out)
    );

    // **Clock Generation (100MHz -> 10ns period)**
    initial clk = 0;
    always #5 clk = ~clk;

    // **Test Sequence**
    initial begin
        // **Initialize Signals**
        control = 1;  // Load weights first
        data_arr = 0;
        wt_arr = 64'h01020304;
        //wt_arr = {16{4'b0001}};
       // wt_arr = 'd1010304;
       
        
        // **Wait for Weights to Load, ensuring control is active when clk is high**
        @(posedge clk);
        #500;
        @(posedge clk);
        control = 0;  // Begin computation phase
        #500
        // **Provide Data Inputs Over Time at Clock High Edges**
        @(posedge clk); #5 data_arr = {16'h01, 16'h02, 16'h03, 16'h04};
     //   @(posedge clk); #5 data_arr = {16'h05, 16'h06, 16'h07, 16'h08};
     //   @(posedge clk); #5 data_arr = {16'h09, 16'h0A, 16'h0B, 16'h0C};
     //   @(posedge clk); #5 data_arr = {16'h0D, 16'h0E, 16'h0F, 16'h10};
        
        // **Wait for Computation to Finish**
        @(posedge clk);
        #50;
        
        // **End Simulation**
        $finish;
    end

    // **Monitor Outputs for Debugging**
    initial begin
        $monitor("Time = %t | clk = %b | control = %b | data_arr = %h | wt_arr = %h | acc_out = %h", 
                 $time, clk, control, data_arr, wt_arr, acc_out);
    end

endmodule

