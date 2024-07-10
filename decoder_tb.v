`timescale 1ns/1ns
`include "decoder.v"

module decoder_tb;
    reg sel;
    wire a, b;

    decoder uut (sel, a, b);

    initial begin
        $dumpfile("decoder_tb.vcd");
        $dumpvars(0, decoder_tb);
        $monitor("sel=%b, a=%b, b=%b", sel, a, b);
        sel = 0;
        #15;
        sel = 1;
        #5;
        $finish;
    end
endmodule
