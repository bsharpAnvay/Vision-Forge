`timescale 1ns / 1ns
`include "half_adder.v"

module half_adder_tb;
    reg A, B;
    wire S, C;

    half_adder uut (A, B, S, C);

    initial begin
        $dumpfile("half_adder_tb.vcd");
        $dumpvars(0, half_adder_tb);
        $monitor("A=%b, B=%b, S=%b, C=%b", A, B, S, C);  // Corrected $monitor statement

        A = 0; B = 0;
        #10;
        A = 0; B = 1;
        #10;
        A = 1; B = 0;
        #10;
        A = 1; B = 1;
        #10;
        $finish;  // Added $finish to end the simulation
    end
endmodule
