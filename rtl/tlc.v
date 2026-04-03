module traffic_light_controller(
 input clk,
 input rst,
 output reg [7:0] duration,
 output reg [2:0] n, e, s, w,
 output reg [2:0] pst, nst
);

parameter S0 = 3'd0;
parameter S1 = 3'd1;
parameter S2 = 3'd2;
parameter S3 = 3'd3;
parameter S4 = 3'd4;
parameter S5 = 3'd5;

localparam integer CYCLES_PER_SEC = 3;
localparam integer T_ONE_SEC = 1 * CYCLES_PER_SEC;
localparam integer T_FIVE_SEC = 5 * CYCLES_PER_SEC;

reg next_flag;

always @(posedge clk or posedge rst) begin
 if (rst) begin
  pst <= S0;
  nst <= S1;
  duration <= T_FIVE_SEC;
  next_flag <= 1'b0;
  n <= 3'b001;
  s <= 3'b001;
  e <= 3'b100;
  w <= 3'b100;
 end else begin
  next_flag <= 1'b0;

  case (pst)
   S0: begin
    nst <= S1;
    n <= 3'b001; s <= 3'b001;
    e <= 3'b100; w <= 3'b100;
    if (duration == 0) begin
     next_flag <= 1'b1;
     duration <= T_ONE_SEC;
    end else duration <= duration - 1;
   end

   S1: begin
    nst <= S2;
    n <= 3'b010; s <= 3'b010;
    e <= 3'b100; w <= 3'b100;
    if (duration == 0) begin
     next_flag <= 1'b1;
     duration <= T_ONE_SEC;
    end else duration <= duration - 1;
   end

   S2: begin
    nst <= S3;
    n <= 3'b100; s <= 3'b100;
    e <= 3'b100; w <= 3'b100;
    if (duration == 0) begin
     next_flag <= 1'b1;
     duration <= T_FIVE_SEC;
    end else duration <= duration - 1;
   end

   S3: begin
    nst <= S4;
    n <= 3'b100; s <= 3'b100;
    e <= 3'b001; w <= 3'b001;
    if (duration == 0) begin
     next_flag <= 1'b1;
     duration <= T_ONE_SEC;
    end else duration <= duration - 1;
   end

   S4: begin
    nst <= S5;
    n <= 3'b100; s <= 3'b100;
    e <= 3'b010; w <= 3'b010;
    if (duration == 0) begin
     next_flag <= 1'b1;
     duration <= T_ONE_SEC;
    end else duration <= duration - 1;
   end

   S5: begin
    nst <= S0;
    n <= 3'b100; s <= 3'b100;
    e <= 3'b100; w <= 3'b100;
    if (duration == 0) begin
     next_flag <= 1'b1;
     duration <= T_FIVE_SEC;
    end else duration <= duration - 1;
   end

   default: begin
    nst <= S0;
    n <= 3'b100; s <= 3'b100;
    e <= 3'b100; w <= 3'b100;
   end
  endcase

  if (next_flag)
   pst <= nst;
 end
end

endmodule
