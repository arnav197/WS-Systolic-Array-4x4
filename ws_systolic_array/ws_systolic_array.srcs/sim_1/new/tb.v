`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2025 18:06:37
// Design Name: 
// Module Name: tb
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

//////////////////////////////////////////////////////////////////////////////////
// Testbench for systolic_array module
//////////////////////////////////////////////////////////////////////////////////

module systolic_array_tb;

    // Testbench signals
    reg clk;
    reg reset;
    reg control;
    reg [7:0] data_in_row_0;
    reg [7:0] data_in_row_1;
    reg [7:0] data_in_row_2;
    reg [7:0] weight_in_col_0;
    reg [7:0] weight_in_col_1;
    reg [7:0] weight_in_col_2;
    
    wire [15:0] acc_out_0;
    wire [15:0] acc_out_1;
    wire [15:0] acc_out_2;

    // Instantiate the systolic array module
    systolic_array uut (
        .clk(clk),
        .reset(reset),
        .control(control),
        .data_in_row_0(data_in_row_0),
        .data_in_row_1(data_in_row_1),
        .data_in_row_2(data_in_row_2),
        .weight_in_col_0(weight_in_col_0),
        .weight_in_col_1(weight_in_col_1),
        .weight_in_col_2(weight_in_col_2),
        .acc_out_0(acc_out_0),
        .acc_out_1(acc_out_1),
        .acc_out_2(acc_out_2)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Generate clock with 10ns period (100MHz)
    end

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        control = 1;
        data_in_row_0 = 8'd0;
        data_in_row_1 = 8'd0;
        data_in_row_2 = 8'd0;
        weight_in_col_0 = 8'd0;
        weight_in_col_1 = 8'd0;
        weight_in_col_2 = 8'd0;
        
        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        
        // Load weights and apply data for testing
        control = 1;
        
        // Load weights for all columns
        weight_in_col_0 = 8'd7; // Weight for column 0
        weight_in_col_1 = 8'd8; // Weight for column 1
        weight_in_col_2 = 8'd9; // Weight for column 2
        
        #10;
        weight_in_col_0 = 8'd4; // Weight for column 0
        weight_in_col_1 = 8'd5; // Weight for column 1
        weight_in_col_2 = 8'd6; // Weight for column 2
        
        #10;
        weight_in_col_0 = 8'd1; // Weight for column 0
        weight_in_col_1 = 8'd2; // Weight for column 1
        weight_in_col_2 = 8'd3; // Weight for column 2
        
        #10;
        // Test data processing without changing weights
        control = 0; // Switch to data flow mode
        
        data_in_row_0 = 8'd1; // New data for row 0
        data_in_row_1 = 8'd0; // New data for row 1
        data_in_row_2 = 8'd0; // New data for row 2
        
        #10;
        // Apply new data for row 0 and row 1 after a few cycles
        data_in_row_0 = 8'd2; // New data for row 0
        data_in_row_1 = 8'd2; // New data for row 1
        data_in_row_2 = 8'd0; // New data for row 2
        
        #10;
        // Continue with data processing
        data_in_row_0 = 8'd3;
        data_in_row_1 = 8'd3;
        data_in_row_2 = 8'd3;
        
        #10;
        // Continue with data processing
        data_in_row_0 = 8'd0;
        data_in_row_1 = 8'd4;
        data_in_row_2 = 8'd4;
        
        #10
        // Continue with data processing
        data_in_row_0 = 8'd0;
        data_in_row_1 = 8'd0;
        data_in_row_2 = 8'd5;
        
        #10
        // Continue with data processing
        data_in_row_0 = 8'd0;
        data_in_row_1 = 8'd0;
        data_in_row_2 = 8'd0;
        
        #55;
        
        // End simulation
        $stop;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time = %t, acc_out_0 = %d, acc_out_1 = %d, acc_out_2 = %d", 
                 $time, acc_out_0, acc_out_1, acc_out_2);
    end

endmodule

