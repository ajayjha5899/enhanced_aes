`include "lfsr8b.v"

module aes_sbox(clk, resetn, lfsr8b_in, subready, wordin, wordout);
    input clk;
    input resetn;
    input [7:0] lfsr8b_in;
    input [31:0] wordin;
    output subready;
    output [31:0] wordout;
    
    reg subreadybuff;
    reg [7:0] subbyte [0:255];
    reg [7:0] counter;
    reg [7:0] prevpn;
    reg [7:0] lfsr8b_1_out_buff;

    assign subready = subreadybuff;
    assign wordout[31:24] = subbyte[wordin[31:24]];
    assign wordout[23:16] = subbyte[wordin[23:16]];
    assign wordout[15:08] = subbyte[wordin[15:08]];
    assign wordout[07:00] = subbyte[wordin[07:00]];
    
    wire [7:0] lfsr8b_1_out;
    lfsr8b lfsr8b_1 (lfsr8b_in, clk, lfsr8b_1_out, resetn);

    initial begin
        subreadybuff = 1'b0;
        counter = 8'hFF;
        for(int i=0; i<256; i++) begin
            subbyte[i] = 8'hFF;
        end
        prevpn = 8'hFF;
        lfsr8b_1_out_buff = 9'hFF;
    end

    always @ (posedge clk or lfsr8b_1_out_buff) begin
        counter = counter + 1'b1;
        if(subreadybuff==1'b0) begin
            if(counter == 8'h25) begin
                subbyte[counter] = 8'h00;
                prevpn = lfsr8b_1_out;
            end

            else if(counter > 8'h25) begin
                prevpn = lfsr8b_1_out_buff;
                subbyte[counter] = prevpn;
                
                if(counter==8'hFF) begin
                    subreadybuff = 1'b1;
                end
            end
                
            else begin
                subbyte[counter] = lfsr8b_1_out;
            end
        end
        lfsr8b_1_out_buff = lfsr8b_1_out;
    end

    always @ (negedge resetn) begin
        subreadybuff = 1'b0;
        counter = 8'hFF;
        for(int i=0; i<256; i++) begin
            subbyte[i] = 8'hFF;
        end
        prevpn = 8'hFF;
        lfsr8b_1_out_buff = 9'hFF;
    end
endmodule