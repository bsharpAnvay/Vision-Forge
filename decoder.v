module decoder (sel, A, B);
input sel;
output A, B;

assign A= ~sel;
assign B= sel;

endmodule