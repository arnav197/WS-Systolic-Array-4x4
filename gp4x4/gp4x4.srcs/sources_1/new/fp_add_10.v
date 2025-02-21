module fp_add_10 #(
	//Parameterized values
	parameter Q = 4,
	parameter N = 20
	)
	(
    input [N-1:0] a,
    input [N-1:0] b,
    output [N-1:0] c
    );
//Here the a and b are 32 bits because it is an accumulating the results
reg [N-1:0] res;

assign c = res;

always @(a,b) begin
	// both negative or both positive
	if(a[N-1] == b[N-1]) begin						
		res[N-2:0] = a[N-2:0] + b[N-2:0];	
		res[N-1] = a[N-1];						
														
		end												
	//	one of them is negative
	else if(a[N-1] == 0 && b[N-1] == 1) begin		
		if( a[N-2:0] > b[N-2:0] ) begin					
			res[N-2:0] = a[N-2:0] - b[N-2:0];			
			res[N-1] = 0;									
			end
		else begin											
			res[N-2:0] = b[N-2:0] - a[N-2:0];			
			if (res[N-2:0] == 0)
				res[N-1] = 0;										
			else
				res[N-1] = 1;									
			end
		end
	else begin											
		if( a[N-2:0] > b[N-2:0] ) begin				
			res[N-2:0] = a[N-2:0] - b[N-2:0];
			if (res[N-2:0] == 0)
				res[N-1] = 0;	
			else
				res[N-1] = 1;
			end
		else begin
			res[N-2:0] = b[N-2:0] - a[N-2:0];
			res[N-1] = 0;
			end
		end
	end
endmodule