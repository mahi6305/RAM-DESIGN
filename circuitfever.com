module ram(
    input clk,
    input write_enable,
    input [9:0]address,
    input [7:0]data_in,
    output reg [7:0]data_out
);

reg [7:0]ram_block[0:1023];

always @(posedge clk) begin
        if(write_enable)
            ram_block[address] <= data_in;
        else
            data_out <= ram_block[address];
end

endmodule
ram uut(clk,write_enable,address,data_in,data_out);

initial begin
clk = 0;
data_in = 8'h56;
write_enable = 0;
address = 55;
#20
write_enable = 1;
#20;
write_enable = 0;
address = 66;
data_in = 8'h36;
#20
write_enable = 1;
#20 
write_enable = 0;
#20
address = 55;
#20
$finish();

end

always #10 clk = ~clk;  //clock generation

endmodule
