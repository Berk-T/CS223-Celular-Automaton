`timescale 1ns / 1ps

module Automata_Game(input logic clk, en, restart, reset, b1, b2, b3, b4, input logic[1:0] digSelect, hexSelect, input logic[3:0] inputValue, output logic[15:0] ledOut, output logic a,b,c,d,e,f,g,dp, output logic[3:0] an, output logic[7:0] rowsOut, output logic shcp, stcp, mr, oe, ds);
    logic enableGame;
    
    typedef enum logic[1:0] {S0 = 2'b00,S1 = 2'b01,S2 = 2'b10, S3 = 2'b11} State;
    State currentState, nextState;
    
    reg[15:0] score;
    reg won;
    reg blink;
    reg enableSelect;
    reg pressed;
    reg clk_adj;
    reg[15:0] valueLED;
    reg[63:0] matrixNext;
    reg[63:0] curMatrix;
    reg[3:0] sev0, sev1,sev2,sev3;
    reg[3:0] in0,in1,in2,in3;
    reg[63:0] initialValue;
    reg[63:0] pickedValue;
    reg deB1, deB2, deB3, deB4;
    
    
    SevSeg_4digit display(clk,blink,in0,in1,in2,in3,a, b, c, d, e, f, g, dp, an);
    Initial_Value_Entry value_entry(.clk(clk),.en(en),.enable(enableSelect),.digSelect(digSelect),.hexSelect(hexSelect),.inputValue(inputValue), .sevOut0(sev0), .sevOut1(sev1), .sevOut2(sev2), .sevOut3(sev3), .ledOut(valueLED), .initialValue(initialValue));
    Automata game( pickedValue, clk, restart, enableGame, deB1, deB2, deB3, deB4, won, matrixNext);
    converter conv( clk, curMatrix, rowsOut, shcp, stcp, mr, oe, ds );
    
    
    DeBounce debouncer1( clk, b1, deB1);
    DeBounce debouncer2( clk, b2, deB2);
    DeBounce debouncer3( clk, b3, deB3);
    DeBounce debouncer4( clk, b4, deB4);
    
    always_ff @(posedge clk)begin
            if((~currentState[1] & currentState[0])) score <= 0;
            if(enableSelect) pickedValue <= initialValue;
            if(enableGame)begin
                curMatrix <= matrixNext;
                if(pressed)begin
                    if( ~deB1 & ~deB2 & ~deB3 & ~deB4 )begin pressed <= 0;end
                end 
                else if(~pressed)begin
                    if( deB1 | deB2 | deB3 | deB4) begin
                        score <= score + 'h1;
                        pressed <= 1;
                end
            end
        end
        else begin curMatrix <= 0; end
        currentState <= nextState;
    end
    
    //Next State Logic
    always_comb
            unique case(currentState)//(~UL~R~B) + (U~L~R~B) + (UL~RB) + (~U~LRB) + (ULR~B)
                S0:     
                        if(reset) nextState = S1;
                        else nextState = S0;
                S1: 
                        nextState = S2;
                S2: 
                        if(restart) nextState = S1;
                        else if(~won & reset) nextState = S2;
                        else if(~reset) nextState = S0;
                        else if(won & reset) nextState = S3;
                S3:
                        if(restart) nextState = S1;
                        else if(~reset) nextState = S0;
                        else nextState = S3;
                default: nextState = S0;
            endcase
    
    assign enableGame =  (~currentState[1] & currentState[0]) | (currentState[1] & ~currentState[0]);
    assign enableSelect = (~currentState[1] & ~currentState[0]);
    assign ledOut = (~currentState[1] & ~currentState[0]) ? valueLED : 0;
    assign in0 = (~currentState[1] & ~currentState[0]) ? sev0 : score[3:0];
    assign in1 = (~currentState[1] & ~currentState[0]) ? sev1 : score[7:4];
    assign in2 = (~currentState[1] & ~currentState[0]) ? sev2 : score[11:8];
    assign in3 = (~currentState[1] & ~currentState[0]) ? sev3 : score[15:12];
    assign blink = (currentState[1] & currentState[0]);
endmodule
