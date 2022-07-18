module BCD_7seg
#(parameter CLK_DIVIDER1 = 100000,
   parameter CLK_DIVIDER2 = 500,
  parameter TOTAL_AMOUNT = 500)
(    input [3:0] cs,
    input arst, clk,
    input [$clog2(TOTAL_AMOUNT):0]total,
    output reg [7:0]D1_SEG,
    output reg [3:0]D1_AN,
    output reg [15:0] led
);
/////////////// bin_data to BCD/////////////////
parameter STR = 4'd0, WAIT = 4'd1,  ADD = 4'd2, CMP = 4'd3, SUB = 4'd4, REF = 4'd5;
reg [11:0]bcd;
integer i;
always @(*)begin
  bcd=0;		 	
    for (i=0;i<$clog2(TOTAL_AMOUNT)+1;i=i+1) begin					//Iterate once for each bit in input number
        if (bcd[3:0] >= 5)  bcd[3:0]  = bcd[3:0] + 3;		//If any BCD digit is >= 5, add three
	    if (bcd[7:4] >= 5)  bcd[7:4]  = bcd[7:4] + 3;
	    if (bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;
	    bcd = {bcd[10:0],total[$clog2(TOTAL_AMOUNT)-i]};				//Shift one bit, and shift in proper bit from input 
    end
end
//////////clk_divider//////////////////////////////////// 100 MHZ --> 1 kHZ
reg clk_div1,clk_div2;
reg [$clog2(CLK_DIVIDER1):0] cnt1;
reg [$clog2(CLK_DIVIDER2):0] cnt2;

always@(posedge clk, posedge arst) begin
    if (arst) cnt1 <= 0;
    else if (cnt1 == CLK_DIVIDER1-1) cnt1 <= 0;		
    else cnt1 <= cnt1 + 1;
end

always@(posedge clk, posedge arst) begin
    if (arst) clk_div1 <= 0;
    else if (cnt1 == CLK_DIVIDER1-1) clk_div1 <= ~clk_div1;		
    else clk_div1 <= clk_div1;
end

always@(posedge clk_div1, posedge arst) begin
    if (arst) cnt2 <= 0;
    else if (cnt2 == CLK_DIVIDER2-1) cnt2 <= 0;		
    else cnt2 <= cnt2 + 1;
end

always@(posedge clk_div1, posedge arst) begin
    if (arst) clk_div2 <= 0;
    else if (cnt2 == CLK_DIVIDER2-1) clk_div2 <= ~clk_div2;		
    else clk_div2 <= clk_div2;
end
////////// 7seg controller & Display ///////////////////////////////////
reg [1:0] Sel;
reg [3:0]data;

always @(posedge clk_div1, posedge arst)begin
    if(arst) Sel <= 0;
    else   Sel <= Sel + 1;
end

always @(*)begin
    case(Sel)
    2'b00: begin data = bcd[3:0];  D1_AN= 4'b1110;end
    2'b01: begin data = bcd[7:4];  D1_AN= 4'b1101;end
    2'b10: begin data = bcd[11:8]; D1_AN= 4'b1011;end
    2'b11: begin data = 4'd0;      D1_AN= 4'b0111;end
    endcase
end
always @ (*)
begin
    case(data)
    0: D1_SEG = (Sel == 2'b10)? 8'b0100_0000: 8'b1100_0000 ;	
    1: D1_SEG = (Sel == 2'b10)? 8'b0111_1001: 8'b1111_1001;
    2: D1_SEG = (Sel == 2'b10)? 8'b0010_0100: 8'b1010_0100;
    3: D1_SEG = (Sel == 2'b10)? 8'b0011_0000: 8'b1011_0000;
    4: D1_SEG = (Sel == 2'b10)? 8'b0001_1001: 8'b1001_1001;
    5: D1_SEG = (Sel == 2'b10)? 8'b0001_0010: 8'b1001_0010;
    6: D1_SEG = (Sel == 2'b10)? 8'b0000_0010: 8'b1000_0010;
    7: D1_SEG = (Sel == 2'b10)? 8'b0111_1000: 8'b1111_1000;
    8: D1_SEG = (Sel == 2'b10)? 8'b0000_0000: 8'b1000_0000;
    9: D1_SEG = (Sel == 2'b10)? 8'b0001_0000: 8'b1001_0000;
    default: D1_SEG = 8'b1100_0000;	
    endcase
end
////////// LED light & Display ///////////////////////////////////

always @(posedge clk_div2, posedge arst)begin
    if(arst) led <= 16'b1010_1010_1010_1010;
    else  begin
    case(cs)
     STR:  led <=  16'b1010_1010_1010_1010;
     WAIT: led <=  {led[14:0],led[15]};
     ADD : led <=  {led[14:0],led[15]};
     CMP : led <=  {led[14:0],led[15]};
     SUB : led <=  {led[14:0],led[15]};
     REF : led <= 16'b1111_0000_1111_0000;
     endcase
     end
end

endmodule

