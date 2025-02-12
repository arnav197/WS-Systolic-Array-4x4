`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2025 13:42:56
// Design Name: 
// Module Name: tb_top4x4
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




module tb_top4x4;

    // **Parameters**
    parameter BIT_WIDTH = 8;
    parameter ACC_WIDTH = 32;
    parameter SIZE = 4;
    parameter DEPTH = 4;

    // **Testbench Signals**
    reg clk;
    reg control;
    reg [(BIT_WIDTH * DEPTH) - 1:0] data_arr;
    reg [31:0] wt_arr;  // Assuming 4x4 weights are loaded row-wise
    wire [(ACC_WIDTH * SIZE) - 1:0] acc_out;

    // **Instantiate the 4x4 Systolic Array**
    top_4x4 #(.depth(DEPTH), .bit_width(BIT_WIDTH), .acc_width(ACC_WIDTH), .size(SIZE)) DUT (
        .clk(clk),
        .control(control),
        .data_arr(data_arr),
        .wt_arr(wt_arr),
        .acc_out(acc_out)
    );

    // **Clock Generation (100MHz -> 10ns period)**
    always #5 clk = ~clk;

    // **Test Sequence**
    initial begin
        // **Initialize Signals**
        clk = 1;
        control = 1;  // Load weights first
        data_arr = 0;
        wt_arr = {16{8'b1}}; // Loading weights (example row-wise) //32'h01020304

        // **Wait for Weights to Load**
        #10;
        control = 0;  // Begin computation phase

        // **Provide Data Inputs Over Time**
        #10 data_arr = {8'h01, 8'h02, 8'h03, 8'h04};  // First row
   //     #10 data_arr = {8'h05, 8'h06, 8'h07, 8'h08};  // Second row
   //     #10 data_arr = {8'h09, 8'h0A, 8'h0B, 8'h0C};  // Third row
   //     #10 data_arr = {8'h0D, 8'h0E, 8'h0F, 8'h10};  // Fourth row
        
        // **Wait for Computation to Finish**
        #50;
        
        // **End Simulation**
        $finish;
    end

    // **Monitor Outputs for Debugging**
    initial begin
        $monitor("Time = %t | control = %b | data_arr = %h | wt_arr = %h | acc_out = %h",
                 $time, control, data_arr, wt_arr, acc_out);
    end

endmodule
