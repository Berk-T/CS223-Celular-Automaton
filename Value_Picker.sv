`timescale 1ns / 1ps

module Value_Picker(input logic clk, en, input logic[1:0] select, input logic [3:0] inputValue, output logic[3:0] in0, in1, in2, in3);
    always_ff @(posedge clk)begin
        if(en)begin
            if( select[1] && select[0])
                in3 <= inputValue;
            else if( select[1] && ~select[0])
                in2 <= inputValue;
            else if( ~select[1] && select[0])
                in1 <= inputValue;
            else if( ~select[1] && ~select[0])
                in0 <= inputValue;
        end
    end
endmodule
