`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2025 16:49:26
// Design Name: 
// Module Name: PE
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


module PE (
    input wire clk,          // Clock signal
    input wire reset,        // Reset signal
    input wire control,      // Control signal (1: load weights, 0: data flow)
    input wire [7:0] data_in,  // Data input
    input wire [7:0] weight_in_top, // Left weight input (from previous PE)
    input wire [15:0] acc_in,
    output reg [7:0] data_out, // Data output
    output reg [15:0] acc_out,
    output reg [7:0] weight_out // Weight output
);

    reg [7:0] weight;  // Stored weight value in the PE
    reg [15:0] data_reg;  // Stored data value in the PE
    reg [15:0] temp;

    // Process for handling weight loading and data flow
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset the PE registers
            weight <= 8'd0;
            data_reg <= 8'd0;
            data_out <= 8'd0;
            weight_out <= 8'd0;
            acc_out <= 16'd0;
        end else begin
            if (control) begin
                // Load weights when control signal is 1
                weight <= weight_in_top;
                weight_out <= weight_in_top;  // Pass weight to the next PE
                data_out <= 8'd0;     // No data processing, just load weight
            end else begin
                // Data flow when control signal is 0
                acc_out <= acc_in + data_in * weight;  // Perform multiplication (data * weight)
                //acc_in <= acc_out;               
                data_out <= data_in;  // Pass result to the next PE
                //weight_out <= weight;  // Pass weight to the next PE
            end
        end
    end

endmodule

