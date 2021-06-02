`include "lfsr8b.v"
`include "memory256B.v"

module keygen(clk, resetn, lfsr8b_in, out, valid);
    input clk, resetn;
    input [7:0] lfsr8b_in;
    output [127:0] out;
    output valid;

    reg [7:0] outbuff [0:15];
    reg validbuff;
    reg [7:0] readaddr;
    reg [4:0] index;
    reg [7:0] lfsr8b_1_out_buff;
    //new
    reg [7:0] prevpn;
    wire [4:0] indexwire;

    assign out = {outbuff[0],outbuff[1],outbuff[2],outbuff[3],outbuff[4],outbuff[5],outbuff[6],outbuff[7],outbuff[8],outbuff[9],outbuff[10],outbuff[11],outbuff[12],outbuff[13],outbuff[14],outbuff[15]};
    assign valid = validbuff;
    assign indexwire = index;

    wire [7:0] lfsr8b_1_out;
    lfsr8b lfsr8b_1 (lfsr8b_in, clk, lfsr8b_1_out, resetn);
    
    reg [7:0] memory256B_1_addr;
    reg memory256B_1_wr;
    reg [7:0] memory256B_1_in;
    wire [7:0] memory256B_1_out;
    memory256B memory256B_1 (clk, resetn, memory256B_1_addr, memory256B_1_wr, memory256B_1_in, memory256B_1_out);

    initial begin
        memory256B_1_addr = 8'hFF;  //dont change
        memory256B_1_wr = 1;
        readaddr = 8'h00;
        validbuff = 1'b0;
        index = 5'b11111;    //dont change
        for(int i=0; i<16; i=i+1) begin
            outbuff[i] = 8'hFF;
        end
        lfsr8b_1_out_buff = 8'hFF;
        prevpn = 8'hFF;
    end

    always @ (posedge clk or lfsr8b_1_out_buff) begin
        if(memory256B_1_wr == 1'b1) begin    
            memory256B_1_addr = memory256B_1_addr + 1'b1;
/*
            if(memory256B_1_addr==8'hFF) begin
                memory256B_1_in = lfsr8b_1_out;
                memory256B_1_wr = 1'b0;
            end       
*/
            if(memory256B_1_addr==8'h25) begin
                memory256B_1_in = 8'h00;
                prevpn = lfsr8b_1_out;
            end

            else if(memory256B_1_addr>8'h25) begin
                memory256B_1_in = prevpn;
                prevpn = lfsr8b_1_out;

                if(memory256B_1_addr==8'hFF) begin
                    memory256B_1_wr = 1'b0;
                end       
            end

            else begin
                memory256B_1_in = lfsr8b_1_out;
            end
        end

        else if(~validbuff && validbuff <= 5'b01111) begin
            memory256B_1_addr = readaddr;
            readaddr = readaddr + 1'b1;
            outbuff[indexwire] = memory256B_1_out;
            index = index+1'b1;

            if(index==5'b10000) begin
                validbuff = 1'b1;
            end

        end

        lfsr8b_1_out_buff = lfsr8b_1_out;
    end

    always @ (negedge resetn) begin
        memory256B_1_addr = 8'h00;
        memory256B_1_wr = 1;
        readaddr = 8'h00;
        validbuff = 1'b0;
        index = 4'b0;
        for(int i=0; i<16; i=i+1) begin
            outbuff[i] = 8'hFF;
        end
    end
endmodule