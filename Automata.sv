`timescale 1ns / 1ps

module Automata( input logic[63:0] initialState, input logic clk, rst, start, b1, b2, b3, b4, output logic won, output logic[63:0] matrix);
    
    //y,x// 1,0 //
    localparam int buttons[63:0] = {'d3,'d4,'d3,'d4,     'd1,'d2,'d1,'d2,      'd2,'d1,'d2,'d1,      'd3,'d4,'d3,'d4,     'd3,'d4,'d3,'d4,   'd1,'d2,'d1,'d2,   'd2,'d1,'d2,'d1,   'd3,'d4,'d3,'d4, 'd4,'d3,'d4,'d3,    'd3,'d4,'d3,'d4,     'd1,'d2,'d1,'d2,   'd2,'d1,'d2,'d1,   'd4,'d3,'d4,'d3,    'd3,'d4,'d3,'d4, 'd1,'d2,'d1,'d2,   'd2,'d1,'d2,'d1};
    
    
    genvar i;
    generate
    for( i = 63; i != -1; i--)begin
        if( i == 63)begin
            Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ 7 ]), .L(matrix[56]), .R(matrix[62]), .B(matrix[ 55 ]), .init(initialState[i]), .button(b3), .out(matrix[i]));
        end
        else if( i == 56 )begin
            Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ 0 ]), .L(matrix[57]), .R(matrix[63]), .B(matrix[ 48 ]), .init(initialState[i]), .button(b2), .out(matrix[i]));
        end
        else if( i == 7)begin
            Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ 15 ]), .L(matrix[0]), .R(matrix[6]), .B(matrix[ 63 ]), .init(initialState[i]), .button(b1), .out(matrix[i]));
        end
        else if( i == 0 )begin
            Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ 8 ]), .L(matrix[1]), .R(matrix[7]), .B(matrix[ 56 ]), .init(initialState[i]), .button(b1), .out(matrix[i]));
        end
        else if( i > 55 )begin
            if( buttons[i] == 'd1)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i - 56) ]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) ]), .init(initialState[i]), .button(b1), .out(matrix[i]));
            else if( buttons[i] == 'd2)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i - 56) ]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) ]), .init(initialState[i]), .button(b2), .out(matrix[i]));
            else if( buttons[i] == 'd3)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i - 56) ]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) ]), .init(initialState[i]), .button(b3), .out(matrix[i]));
            else
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i - 56) ]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) ]), .init(initialState[i]), .button(b4), .out(matrix[i]));
        end
        else if( i < 8 )begin
            if( buttons[i] == 'd1)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i + 8) ]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i + 56) ]), .init(initialState[i]), .button(b1), .out(matrix[i]));
            else if( buttons[i] == 'd2)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i + 8) ]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i + 56) ]), .init(initialState[i]), .button(b2), .out(matrix[i]));
            else if( buttons[i] == 'd3)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i + 8) ]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i + 56) ]), .init(initialState[i]), .button(b3), .out(matrix[i]));
            else
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i + 8) ]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i + 56) ]), .init(initialState[i]), .button(b4), .out(matrix[i]));
        end
        else if( i % 8 == 0 )begin
            if( buttons[i] == 'd1)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i + 1]), .R(matrix[ i + 7]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b1), .out(matrix[i]));
            else if( buttons[i] == 'd2)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i + 1]), .R(matrix[ i + 7]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b2), .out(matrix[i]));
            else if( buttons[i] == 'd3)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i + 1]), .R(matrix[ i + 7]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b3), .out(matrix[i]));
            else
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i + 1]), .R(matrix[ i + 7]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b4), .out(matrix[i]));
        end
        else if( i % 8 == 7)begin
            if( buttons[i] == 'd1)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i - 7]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b1), .out(matrix[i]));
            else if( buttons[i] == 'd2)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i - 7]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b2), .out(matrix[i]));
            else if( buttons[i] == 'd3)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i - 7]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b3), .out(matrix[i]));
            else
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i - 7]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b4), .out(matrix[i]));
        end
        else begin
            if( buttons[i] == 'd1)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b1), .out(matrix[i]));
            else if( buttons[i] == 'd2)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b2), .out(matrix[i]));
            else if( buttons[i] == 'd3)
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b3), .out(matrix[i]));
            else
                Automata_logic func( .clk(clk), .rst(rst), .enable(start), .U(matrix[ (i+8) % 64]), .L(matrix[i + 1]), .R(matrix[ i - 1]), .B(matrix[ (i - 8) % 64]), .init(initialState[i]), .button(b4), .out(matrix[i]));
        end
    end
    endgenerate
    
    
    assign won = ~(|matrix);
endmodule
