module top_module (
    input J, K, clk,
    output reg Q
);

always @(posedge clk)
begin
     Q <= (~K & Q) | (J & ~Q);
end

endmodule
