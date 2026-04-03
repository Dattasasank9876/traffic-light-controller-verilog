module traffic_light_controller_tb;

reg clk, rst;
wire [7:0] duration;
wire [2:0] n, e, s, w, pst, nst;

traffic_light_controller uut (
 .clk(clk),
 .rst(rst),
 .duration(duration),
 .n(n), .e(e), .s(s), .w(w),
 .pst(pst), .nst(nst)
);

initial clk = 0;
always #5 clk = ~clk;

initial begin
 $display("Starting Simulation...");
 $display("Red=100, Yellow=010, Green=001");

 rst = 1;
 #20;
 rst = 0;

 $monitor("Time=%0t | pst=%0d -> nst=%0d | duration=%0d | N=%b E=%b S=%b W=%b",
  $time, pst, nst, duration, n, e, s, w);

 #2000;
 $finish;
end

endmodule
