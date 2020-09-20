`timescale 1ns / 1ps

//http://referencedesigner.com/blog/key-debounce-implementation-in-verilog/2649/
module  DeBounce 
    ( input   clk, button_in,output reg btn_out
    );
    
    parameter N = 22 ;      
 
    reg  [N-1 : 0]  count;                     
    reg  [N-1 : 0]  count_next;
     
    reg flip; 
    reg flop;                                 
    
    wire q_add;                                     
    wire q_reset;
 
    initial begin
        flip <= 1'b0;
        flop <= 1'b0;
        count <= count_next;
    end
    
        always @ ( posedge clk )
        begin
                flip <= button_in;
                flop <= flip;
                count <= count_next;
        end
     
    assign q_reset = (flip ^ flop);
    assign  q_add = ~(count[N-1]);
     
 
    always @ ( q_reset, q_add, count)
        begin
            case( {q_reset , q_add})
                2'b00 :
                        count_next <= count;
                2'b01 :
                        count_next <= count + 1;
                default :
                        count_next <= { N {1'b0} };
            endcase    
        end
     
     
    always @ ( posedge clk )
        begin
            if(count[N-1] == 1'b1) btn_out <= flop ;
            else btn_out <= btn_out;
        end
         
endmodule