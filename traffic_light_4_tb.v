`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2025 00:36:15
// Design Name: 
// Module Name: traffic_light_4_tb
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


module traffic_light_4_tb(

    );
 // Inputs
    reg CLK;
    reg CLEAR;

    // Outputs
    wire [1:0] NS, SN, EW, WE;

    // Instantiate the Unit Under Test (UUT)
    traffic_light_4 uut (
        .CLK(CLK),
        .CLEAR(CLEAR),
        .NS(NS),
        .SN(SN),
        .EW(EW),
        .WE(WE)
    );

    // Clock generation: 10 ns period
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // Toggle clock every 5ns
    end

    // Reset and stimulus process
    initial begin
        // Display header
        $display("-------------------------------------------------------------");
        $display("Time\tCLEAR\tNS\tSN\tEW\tWE");
        $display("-------------------------------------------------------------");
        $monitor("%0dns\t%b\t%b\t%b\t%b\t%b", $time, CLEAR, NS, SN, EW, WE);

        // Initial values
        CLEAR = 1;
        #20;                    // Hold reset high for 20ns
        CLEAR = 0;

        // Let the system run through several full cycles
        #400;

        // Assert reset again mid-way to check FSM reset behavior
        CLEAR = 1;
        #20;
        CLEAR = 0;

        #400;

        // End simulation
        $display("-------------------------------------------------------------");
        $display("Simulation completed successfully at %0dns", $time);
        $display("-------------------------------------------------------------");
        $finish;
    end
endmodule
