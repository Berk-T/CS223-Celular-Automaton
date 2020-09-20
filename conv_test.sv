`timescale 1ns / 1ps
module conv_test(
input clk, output logic[7:0] rowsOut, output logic shcp, stcp, mr, oe, ds
    );
    converter dut(clk, {64'b1111111111111111111111111111111111111111111111111111111111111111}, rowsOut, shcp, stcp, mr, oe, ds);
endmodule
