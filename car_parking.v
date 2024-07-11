module system(
    input front_sensor,
    input back_sensor,
    input clk,
    input rstn,
    input [1:0] password,
    output wire green_LED,
    output wire red_LED,
    output reg[3:0] display_screen
);

parameter IDLE=3'b000;
parameter WAIT=3'b001;
parameter RIGHT=3'b011;
parameter WRONG=3'b010;
parameter STOP=3'b100;

reg [2:0] present, next;
reg [31:0] counter_wait;
reg r_temp, g_temp;

always @(posedge clk or negedge rstn) begin
    if(~rstn)
        present= IDLE;
    else
        present= next;
end

always @(posedge clk or negedge rstn) begin
    if(~rstn)
        counter_wait<=0;
    else if(present==WAIT)
        counter_wait<= counter_wait+1;
    else
        counter_wait<=0;
end

always @(*) begin
    case (present)

        IDLE:
        begin
            if(front_sensor==1)
                next= WAIT;
            else
                next= present;
        end    

        WAIT:
        begin
            if(counter_wait<=3)
                next= WAIT;
            else
                begin
                    if(password==2'b10)
                        next= RIGHT;
                    else
                        next= WRONG;
                end
        end

        WRONG:
        begin
            if(password==2'b10)
                next= RIGHT;
            else
                next= present; 
        end 

        RIGHT:
        begin
            if(front_sensor==1 && back_sensor==1)
                next= STOP;
            else if(back_sensor==1)
                next= IDLE;
            else
                next= present;
        end

        STOP:
        begin
            if(password==2'b10)
                next= RIGHT;
            else
                next= STOP;
        end

        default: 
            next= IDLE;
    endcase
end

always @(posedge clk) begin
    case (present)

        IDLE:
        begin
            g_temp= 1'b0;
            r_temp= 1'b0;
            display_screen= 4'b0000;
        end

        WAIT:
        begin
            g_temp=1'b0;
            r_temp=1'b1;
            display_screen=4'b0001;
        end

        WRONG:
        begin
            g_temp= 1'b0;
            r_temp= ~r_temp;
            display_screen= 4'b0011;
        end

        RIGHT:
        begin
            g_temp= ~g_temp;
            r_temp= 1'b0;
            display_screen= 4'b0100;
        end

        STOP:
        begin
            g_temp= 1'b0;
            r_temp= ~r_temp;
            display_screen= 4'b0111;
        end
    endcase
end

assign red_LED= r_temp;
assign green_LED =g_temp;

endmodule