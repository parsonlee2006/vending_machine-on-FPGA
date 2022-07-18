module vend_machine
#(parameter CLK_DIVIDER1 = 100000,
  parameter CLK_DIVIDER2= 100,
  parameter TOTAL_AMOUNT = 800)
(input clk,arst, // 100MHz
input [2:0] btn, // btn[0] as enter
input [15:0] sw,//  sw[15:14] number of product 
output [7:0]D1_SEG,D0_SEG,
output [3:0]D1_AN,D0_AN,
output [2:0] hdmi_tx_n, hdmi_tx_p,
output hdmi_clk_n, hdmi_clk_p,
output [2:0] RGB0,RGB1,
output [15:0] led
);
////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////Control Unit///////////////////////////////////////////////////////////////////////////////////

parameter STR = 4'd0, WAIT = 4'd1,  ADD = 4'd2, CMP = 4'd3, SUB = 4'd4, REF = 4'd5;
reg [3:0] cs, ns;
assign RGB0[2] = (cs == REF);
assign RGB0[1] = (cs == STR);

always @(posedge clk, posedge arst)begin
    if(arst) cs <= STR;
    else cs <= ns;
end

//////////// procedure/////////////////////////////////
//     1. STR: chosee number
//     2. WAIT: pusg coin
//     3. ADD: add all coin
//     4. CMP: total larger than price
//     5. REFUND: refund the money

wire confirm = btn[0];
wire re_select = btn[1];
wire finish = btn[2];
wire grt_price = (total >= price);

///////////control state//////////////////////////////

always@(*)begin
    case(cs)
    STR :  ns = (confirm) ? WAIT : STR ;         
    WAIT:  ns = (re_select)? STR : (confirm) ? ADD : WAIT ;
    ADD :  ns = CMP;
    CMP :  ns = (confirm)? CMP : (grt_price)? SUB : WAIT;
    SUB :  ns =  REF;
    REF :  ns =  (finish)? STR: REF;
    default : ns = STR;
    endcase
end
////////////control output for data flow///////////////

reg disp;
always@(*)begin
    case(cs)
    STR :  begin
        op   = 0;
        clr  = 1;
        load = 0;
    end   
    WAIT:  begin
        op   = 0;
        clr  = 0;
        load = 0; 
    end   
    ADD :  begin
        op   = 0;
        clr  = 0;
        load = 1;  
    end   
    CMP :  begin
        op   = 0;
        clr  = 0;
        load = 0;
    end   
    SUB :  begin
        op   = 1;
        clr  = 0;
        load = 1;
    end  
    REF :  begin
        op   = 1;
        clr  = 0;
        load = 0; 
    end  
    default : begin
        op   = 0;
        clr  = 1;
        load = 0;
    end   
    endcase
end

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////Operational Unit////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////select price////////////////

reg [$clog2(TOTAL_AMOUNT):0] price;
always @(posedge clk)begin
 if (cs == STR)
    case (sw[15:14])
       0: price <= 185;
       1: price <= 200;
       2: price <= 295;
       3: price <= 165;
    endcase
 else
     price <= price;
end

//////////////////input payment///////////////////////////////

reg [$clog2(TOTAL_AMOUNT)-1:0] payment; //sw[3:0]

always @(*)begin
if (cs == WAIT)
    case(sw[3:0])
    4'd1:   payment = 20; //20 cent
    4'd2:   payment = 50; //50 cent
    4'd4:   payment = 100; //100 cent
    4'd8:   payment = 200; //200 cent
    default  payment = 0;
    endcase
end

//////////////add and sub the payment to amount////////////////

reg [$clog2(TOTAL_AMOUNT):0] total;
wire [11:0] amount;
reg clr, op, load;
//from 50 cent to 5 euro
assign amount = (!op)? (total+payment):(total- price );
assign grt_price = (total >= price);

////////////// store the amount to total registor///////////////////

always @(posedge clk, posedge arst)begin
    if (arst) total <= 0;
    else if(clr) total <= 0 ;
    else if(load) total <= amount;
    else total <= total;
end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////Display part////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////7-segment///////////////////////////////////////////
//////total //////

 BCD_7seg  #(.CLK_DIVIDER1(CLK_DIVIDER1),
             .CLK_DIVIDER2(CLK_DIVIDER2),
             .TOTAL_AMOUNT(TOTAL_AMOUNT))
 B1(.clk(clk), .arst(arst), .cs(cs),.led(led) ,.total(total), .D1_SEG(D1_SEG), .D1_AN(D1_AN));
 
//////price //////

 BCD_7seg  #(.CLK_DIVIDER1(CLK_DIVIDER1),
             .CLK_DIVIDER2(CLK_DIVIDER2),
             .TOTAL_AMOUNT(TOTAL_AMOUNT))
 B0(.clk(clk), .arst(arst), .total(price), .D1_SEG(D0_SEG), .D1_AN(D0_AN));

///////////////HDMI display///////////////////////////////////////////

HDMI_test H1(.clk(clk), .cs(cs), .select(sw[15:14]), .hdmi_tx_p(hdmi_tx_p), .hdmi_tx_n(hdmi_tx_n), .hdmi_clk_p(hdmi_clk_p), .hdmi_clk_n(hdmi_clk_n));

/////////////////////////////////////////////////////////////////


endmodule
