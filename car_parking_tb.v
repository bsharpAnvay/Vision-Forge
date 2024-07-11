`timescale 1ns/1ns
`include "car_parking.v"

module car_system_tb;
    reg clk;
    reg rstn;
    reg front_sensor;
    reg back_sensor;
    reg [1:0] password;

    wire green_LED;
    wire red_LED;
    wire [3:0] display_screen;

    initial begin
        begin
            clk=0;
            forever begin
                #10;
                clk= ~clk;
            end
        end
    end

    system uut(front_sensor, back_sensor, clk, rstn, password, green_LED, red_LED, display_screen);

    initial begin
        $dumpfile("car_system.vcd");
        $dumpvars(0, car_system_tb);

        rstn=0;
        front_sensor=0;
        back_sensor=0;
        password=0;

        #100;
        rstn=1;
        #20;
        front_sensor=1;
        #200;
        front_sensor=0;
        password=2;
        #200;
        back_sensor=1;
        #100;
        front_sensor=1;

        $display("done successfully!");
        $finish;
    end
endmodule