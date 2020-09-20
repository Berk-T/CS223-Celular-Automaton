`timescale 1ns / 1ps

module clk_adjuster( input clk, en, input[31:0] adjTo ,output logic clk_adj);
    reg[31:0] count;
    always_ff@ (posedge clk)
    begin
        if( ~en) begin
            clk_adj <= 0;
            count <= 0;
        end
        else begin
            count <= count + 1;
            if( count == adjTo) begin
                clk_adj <= ~clk_adj;
                count <= 0;
            end
        end
    end
endmodule
