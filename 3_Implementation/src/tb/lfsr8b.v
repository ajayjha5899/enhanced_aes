module lfsr8b(in, clk, out, resetn);
    input [7:0] in;
    input clk, resetn;
    output [7:0] out;
    
    reg [7:0] internal;
    reg [7:0] internal_delay;
    reg temp;
    
    assign out = internal;
    
    initial begin
        internal = in;
    end
    // 8,6,5,4 type LFSR
    always @ (posedge clk) begin
        temp = internal[4] ^ internal[3] ^ internal[2] ^ internal[0];
        internal = internal >> 1;  //shift
        internal[7] = temp;
    end

    always @ (negedge resetn) begin
        internal = in;
    end
endmodule