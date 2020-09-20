`timescale 1ns / 1ps

module Automata_logic(input clk, rst, enable, U, L, R, B, init, button, output out);
    typedef enum logic[1:0] {S0 = 2'b00,S1 = 2'b01,S2 = 2'b10} State;
    
    State currentState, nextState;
    
    reg Uc,Lc,Rc,Bc;
    logic once;
    logic adjButton;
    logic pressed = 'b0;
    
    always_ff @(posedge clk)
    begin
        if(enable)begin
            Uc <= U; Lc <= L; Rc <= R; Bc <= B;
            adjButton <= 0;
            if(pressed)begin
                if(~button)begin  
                    pressed <=0;
                end 
            end
            else if( ~pressed)begin
                if(button)begin
                    pressed <= 1; adjButton <=1;
                end
            end
            if(rst)begin currentState <= S0; end
            else currentState <= nextState;
        end
        else
            currentState <= S0;
    end
    
    //Next State Logic
    always_comb
            unique case(currentState)//ULR~B   +    UL~RB    +    U~L~R~B    +    ~UL~R~B    +    ~U~LR~B    +    ~U~L~RB    ((Uc&&Lc&&Rc&&~Bc) || (Uc&&Lc&&~Rc&&Bc) || (Uc&&~Lc&&~Rc&&~Bc) || (~Uc&&Lc&&~Rc&&~Bc) || (~Uc&&~Lc&&Rc&&~Bc) || (~Uc&&~Lc&&~Rc&&Bc))
                S0:     
                        if(init) nextState = S1;
                        else nextState = S2;
                S1: 
                        if(adjButton && ((Uc&&Lc&&Rc&&~Bc) || (Uc&&Lc&&~Rc&&Bc) || (Uc&&~Lc&&~Rc&&~Bc) || (~Uc&&Lc&&~Rc&&~Bc) || (~Uc&&~Lc&&Rc&&~Bc) || (~Uc&&~Lc&&~Rc&&Bc))) nextState = S1;
                        else if( adjButton && ~((Uc&&Lc&&Rc&&~Bc) || (Uc&&Lc&&~Rc&&Bc) || (Uc&&~Lc&&~Rc&&~Bc) || (~Uc&&Lc&&~Rc&&~Bc) || (~Uc&&~Lc&&Rc&&~Bc) || (~Uc&&~Lc&&~Rc&&Bc))) nextState = S2;
                        else nextState = S1;
                S2: 
                        if(adjButton && ~((Uc&&Lc&&Rc&&~Bc) || (Uc&&Lc&&~Rc&&Bc) || (Uc&&~Lc&&~Rc&&~Bc) || (~Uc&&Lc&&~Rc&&~Bc) || (~Uc&&~Lc&&Rc&&~Bc) || (~Uc&&~Lc&&~Rc&&Bc))) nextState = S2;
                        else if( adjButton && ((Uc&&Lc&&Rc&&~Bc) || (Uc&&Lc&&~Rc&&Bc) || (Uc&&~Lc&&~Rc&&~Bc) || (~Uc&&Lc&&~Rc&&~Bc) || (~Uc&&~Lc&&Rc&&~Bc) || (~Uc&&~Lc&&~Rc&&Bc))) nextState = S1;
                        else nextState = S2;
                default: nextState = S0;
            endcase
    assign out = once ? init : (~currentState[1] & currentState[0]);
    assign once = ~currentState[1] & ~currentState[0];
endmodule
