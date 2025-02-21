`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2025 16:45:47
// Design Name: 
// Module Name: fp_mul
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

module fp_mul #(parameter Q = 8,parameter N = 16)
	(
	 input [N-1:0]	a,
	 input [N-1:0]	b,
	 output [2*N-1:0] result
	 );
	 
    reg [2*N-1:0] temp;  // Store full 64-bit multiplication
    assign result = temp;  // Directly assign full result

    always @(a, b) begin
        temp <= a[N-2:0] * b[N-2:0]; // Multiply full
    end

endmodule

