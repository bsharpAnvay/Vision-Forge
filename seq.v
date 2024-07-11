module seq(in, clk, out);
input in, clk;
output reg out;

    always @(posedge clk) begin
    out=1;
    out <= in^out;
    end

endmodule