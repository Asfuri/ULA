module ULA(A, B, reset, mode, op, O, overflow, zero);
input [5:0] A;
input [5:0] B;
input [2:0] op;
input reset, mode;
output [5:0] O;
output overflow, zero;
always @(*)
	begin
	overflow <= 1'b0;
	if (reset == 1'b1) begin
	O <= 6'b000000;
	end else begin
		case({mode,op})
			4'b0000: begin 
			if(A + B >= 7'b1000000) begin
				overflow <= 1'b1; end
			O <= A + B; 
			end
			4'b0001: begin 
			if(A < B) begin
				overflow <= 1'b1; end
			O <= A - B; 
			end
			4'b0010: begin
			if({1'b0, A} + {1'b0, ~B} >= 7'b1000000) begin
			overflow <= 1'b1; 
			end
			O <= A + ~B;
			end
			4'b0011: begin 
			if(A < ~B) begin
			overflow <= 1'b1; 
			end
			O <= A - ~B; 
			end
			4'b0100: begin 
			if(A + 1 >= 7'b1000000) begin
				overflow <= 1'b1; end
			O <= A + 1; 
			end
			4'b0101: begin
			if(A == 7'b0000000) begin
				overflow <= 1'b1; end
			O <= A - 1; 
			end
			4'b0110: begin 
			if(B + 1 >= 7'b1000000) begin
				overflow <= 1'b1; end
			O <= B + 1; 
			end
			4'b0111: begin 
			if(B == 7'b0000000) begin
				overflow <= 1'b1; end
			O <= B - 1; 
			end
			4'b1000: begin 
			overflow <= 1'b0;
			O <= A & B; 
			end
			4'b1001: begin 
				overflow <= 1'b0;
			O <= ~A; 
			end
			4'b1010: begin 
			overflow <= 1'b0;
			O <= ~B; 
			end
			4'b1011: begin
			overflow <= 1'b0;
			O <= A | B; 
			end
			4'b1100: begin 
			overflow <= 1'b0;
			O <= A ^ B; 
			end
			4'b1101: begin 
			overflow <= 1'b0;
			O <= ~(A  & B); 
			end
			4'b1110: begin 
			overflow <= 1'b0;
			O <= A; 
			end
			4'b1111: begin 
			overflow <= 1'b0;
			O <= B; 
			end
		endcase
	end
	case({O})
	6'b000000: begin
		zero <= 1;
	end
	default: begin
	zero <= 0;
	end
	endcase
	end
endmodule