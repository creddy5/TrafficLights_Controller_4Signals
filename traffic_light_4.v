`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2025 00:30:26
// Design Name: 
// Module Name: traffic_light_4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module traffic_light_4(CLK, CLEAR,NS,SN,EW,WE


    );
  input CLK, CLEAR;
  output reg [1:0] NS,SN,EW,WE;
  
 // Light colors
    parameter RED     = 2'b00;
    parameter YELLOW  = 2'b01;
    parameter GREEN   = 2'b10;

    // FSM states
    parameter S0 = 3'd0;   // NS Green
    parameter S1 = 3'd1;   // NS Yellow
    parameter S2 = 3'd2;   // EW Green
    parameter S3 = 3'd3;   // EW Yellow
    parameter S4 = 3'd4;   // SN Green
    parameter S5 = 3'd5;   // SN Yellow
    parameter S6 = 3'd6;   // WE Green
    parameter S7 = 3'd7;   // WE Yellow

    // Timing delays (in clock cycles)
    parameter G2Y_DELAY = 5;   // Green duration
    parameter Y2R_DELAY = 2;   // Yellow duration

    reg [2:0] STATE, NEXT_STATE;
    reg [3:0] counter;   // 4-bit counter for timing

    // Initialization
    initial begin
        STATE = S0;
        NEXT_STATE = S0;
        counter = 0;
    end

    // State transition with counter-based delay
    always @(posedge CLK or posedge CLEAR) begin
        if (CLEAR) begin
            STATE <= S0;
            counter <= 0;
        end
        else begin
            counter <= counter + 1;
            case (STATE)
                S0: if (counter == G2Y_DELAY) begin STATE <= S1; counter <= 0; end
                S1: if (counter == Y2R_DELAY) begin STATE <= S2; counter <= 0; end
                S2: if (counter == G2Y_DELAY) begin STATE <= S3; counter <= 0; end
                S3: if (counter == Y2R_DELAY) begin STATE <= S4; counter <= 0; end
                S4: if (counter == G2Y_DELAY) begin STATE <= S5; counter <= 0; end
                S5: if (counter == Y2R_DELAY) begin STATE <= S6; counter <= 0; end
                S6: if (counter == G2Y_DELAY) begin STATE <= S7; counter <= 0; end
                S7: if (counter == Y2R_DELAY) begin STATE <= S0; counter <= 0; end
                default: STATE <= S0;
            endcase
        end
    end

    // Output logic for each state
    always @(*) begin
        NS = RED; SN = RED; EW = RED; WE = RED;
        case (STATE)
            S0: NS = GREEN;
            S1: NS = YELLOW;
            S2: EW = GREEN;
            S3: EW = YELLOW;
            S4: SN = GREEN;
            S5: SN = YELLOW;
            S6: WE = GREEN;
            S7: WE = YELLOW;
            default: begin
                NS = RED; SN = RED; EW = RED; WE = RED;
            end
        endcase
    end



endmodule
