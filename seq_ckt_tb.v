`timescale 1ns/1ns
`include "seq.v"

module seq_ckt_tb;
    reg in, clk;
    wire out;

    // Instantiate the seq_ckt module
    seq uut (
        .in(in),
        .clk(clk),
        .out(out)
    );

    // Clock generation
    initial begin
        clk=1;
       forever #5 clk = ~clk;
    end

    // Testbench logic
    initial begin
        $dumpfile("seq_ckt_tb.vcd");
        $dumpvars(0, seq_ckt_tb);
        $monitor("in=%b, out=%b", in, out);
        
        in = 0;
        #6;
        in = 1;
        #3;
        in = 0;
        #2;
        in=1;
        #15
        $finish;
    end
endmodule
