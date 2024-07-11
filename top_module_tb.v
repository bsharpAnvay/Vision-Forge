`timescale 1ns/1ns
`include "top_module.v"

module top_module_tb;
reg J, K, clk=0;
wire Q;

top_module utt (J, K, clk, Q);

always begin
    clk= ~clk;
    #5;
end

initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);
    $monitor("J=%b, K=%b, Q=%b", J, K, Q);

    {J,K}= 2'b01;
    #7;
    {J,K}= 2'b10;
    #7;
    {J,K}= 2'b11;
    #7;
    {J,K}= 2'b00;
    #7;
    {J,K}= 2'b01;
    #7;
    $finish;
end
endmodule