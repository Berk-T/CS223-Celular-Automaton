`timescale 1ns / 1ps
module Initial_Value_Entry( input logic clk, en, enable, input logic[1:0] digSelect, hexSelect, input logic [3:0] inputValue, output logic[3:0] sevOut0, sevOut1, sevOut2, sevOut3, output logic[15:0] ledOut, output logic[63:0] initialValue);
    reg[63:0] value;
    
    logic en0, en1, en2, en3;
    logic[3:0] out00,out01,out02,out03,out10,out11,out12,out13,out20,out21,out22,out23,out30,out31,out32,out33;
    logic[3:0] sevOut0, sevOut1, sevOut2, sevOut3;
    
    Value_Picker picker0( clk,  en0, digSelect, inputValue, out00, out01, out02, out03);
    Value_Picker picker1( clk,  en1, digSelect, inputValue, out10, out11, out12, out13);
    Value_Picker picker2( clk,  en2, digSelect, inputValue, out20, out21, out22, out23);
    Value_Picker picker3( clk,  en3, digSelect, inputValue, out30, out31, out32, out33);
    
    always_ff @(posedge clk)begin
        if(enable)begin
            if( hexSelect[1] && hexSelect[0])begin
                en0 <= 0;
                en1 <= 0;
                en2 <= 0;
                en3 <= en;
                sevOut0 <= out30;
                sevOut1 <= out31;
                sevOut2 <= out32;
                sevOut3 <= out33;
                ledOut <= value[63:48];
            end
            else if( hexSelect[1] && ~hexSelect[0])begin
                en0 <= 0;
                en1 <= 0;
                en2 <= en;
                en3 <= 0;
                sevOut0 <= out20;
                sevOut1 <= out21;
                sevOut2 <= out22;
                sevOut3 <= out23;
                ledOut <= value[47:32];
            end
            else if( ~hexSelect[1] && hexSelect[0])begin
                en0 <= 0;
                en1 <= en;
                en2 <= 0;
                en3 <= 0;
                sevOut0 <= out10;
                sevOut1 <= out11;
                sevOut2 <= out12;
                sevOut3 <= out13;
                ledOut <= value[31:16];
            end
            else if( ~hexSelect[1] && ~hexSelect[0])begin
                en0 <= en;
                en1 <= 0;
                en2 <= 0;
                en3 <= 0;
                sevOut0 <= out00;
                sevOut1 <= out01;
                sevOut2 <= out02;
                sevOut3 <= out03;
                ledOut <= value[15:0];
            end
        end
    end
    
    assign value[63:60] = out33;
    assign value[59:56] = out32;
    assign value[55:52] = out31;
    assign value[51:48] = out30;
    assign value[47:44] = out23;
    assign value[43:40] = out22;
    assign value[39:36] = out21;
    assign value[35:32] = out20;
    assign value[31:28] = out13;
    assign value[27:24] = out12;
    assign value[23:20] = out11;
    assign value[19:16] = out10;
    assign value[15:12] = out03;
    assign value[11:8] = out02;
    assign value[7:4] = out01;
    assign value[3:0] = out00;
    
    assign initialValue = value;
endmodule
