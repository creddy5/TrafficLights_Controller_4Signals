# TrafficLights_Controller_4Signals

This Verilog module traffic_light_4 simulates a 4-way traffic light controller using a Finite State Machine (FSM).

Each direction (North-South, South-North, East-West, and West-East) is assigned a traffic light that cycles through Green → Yellow → Red with specific time delays.

The design ensures that only one direction (or its opposite) is Green or Yellow at a time, while others remain Red, mimicking a real-world traffic signal system.

====================================================================================================================================================================


Inputs: 
| Signal    | Type  | Description                                                                      |
| --------- | ----- | -------------------------------------------------------------------------------- |
| **CLK**   | input | System clock signal. Controls the timing of state transitions.                   |
| **CLEAR** | input | Asynchronous reset signal (active high). Resets the system to the initial state. |


Outputs:
| Signal | Type             | Description                                      |
| ------ | ---------------- | ------------------------------------------------ |
| **NS** | output reg [1:0] | North-South traffic light (2-bit encoded color). |
| **SN** | output reg [1:0] | South-North traffic light (2-bit encoded color). |
| **EW** | output reg [1:0] | East-West traffic light (2-bit encoded color).   |
| **WE** | output reg [1:0] | West-East traffic light (2-bit encoded color).   |


Light Color Encoding:
| Color      | Binary Code |
| ---------- | ----------- |
| **RED**    | 2'b00       |
| **YELLOW** | 2'b01       |
| **GREEN**  | 2'b10       |



FSM States:
| State  | Code | Description        |
| ------ | ---- | ------------------ |
| **S0** | 3'd0 | North-South Green  |
| **S1** | 3'd1 | North-South Yellow |
| **S2** | 3'd2 | East-West Green    |
| **S3** | 3'd3 | East-West Yellow   |
| **S4** | 3'd4 | South-North Green  |
| **S5** | 3'd5 | South-North Yellow |
| **S6** | 3'd6 | West-East Green    |
| **S7** | 3'd7 | West-East Yellow   |


Timing Parameters
| Parameter     | Description                                    | Value |
| ------------- | ---------------------------------------------- | ----- |
| **G2Y_DELAY** | Duration of the Green light (in clock cycles)  | 5     |
| **Y2R_DELAY** | Duration of the Yellow light (in clock cycles) | 2     |


===================================================================================================================================================================

Working Principle:
1. The FSM starts at S0 (North-South Green) after reset.
2. A counter keeps track of clock cycles.
3. Once G2Y_DELAY or Y2R_DELAY is reached:
    The FSM moves to the next state.
    Counter resets to zero.
4. This sequence repeats cyclically through all eight states.
5. When CLEAR = 1, all signals reset:
    FSM returns to S0.
    Counter resets to 0.
    All lights go to RED before restarting the cycle


