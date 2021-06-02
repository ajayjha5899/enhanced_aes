module memory256B(clk, resetn, addr, wr, in, out);
    input clk, resetn, wr;  
    input [7:0] in, addr;
    output [7:0] out;

    reg [7:0] mem [0:255];
    reg [7:0] buffer;

    assign out = buffer;

    initial begin
        for(int i=0; i<256; i=i+1) begin
            mem[i] = 8'hFF;
        end
        buffer = 8'hFF;
    end

    always @ (posedge clk) begin
        if(wr) begin
            mem[addr] = in;
        end
        else begin
            buffer = mem[addr];
        end
    end

    always @ (negedge resetn) begin
        for(int i=0; i<256; i=i+1) begin
            mem[i] = 8'hFF;
        end
        buffer = 8'hFF;
    end
endmodule