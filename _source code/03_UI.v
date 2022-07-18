module UI
#(parameter MaxDrawAreaX = 640,
  parameter MaxDrawAreaY = 480)

(input pixclk,
input [10:0] CounterX , CounterY ,
input [3:0] cs,
input [2:0]select,
output reg [7:0] r_red, r_green, r_blue);




////////////////////////////////// picture position set
parameter POSITION1 = 40;
parameter POSITION2 = 210;
parameter POSITION3 = 370;
parameter POSITION4 = 530;

///////////////////////////////// basic color set
parameter BACKGROUND = {8'd0,8'd0,8'd0};
parameter WINDOWS = {8'd255,8'd199,8'd44};

// color set
parameter   P1_C1 = {8'd255, 8'd133, 8'd76}, 
		  	P1_C2 = {8'd243, 8'd172, 8'd71},
			P1_C3 = {8'd192,   8'd0,  8'd0},
			P1_C4 = {  8'd7, 8'd176, 8'd80},
			P1_C5 = {8'd253, 8'd192,  8'd2},
			P1_C6 = {8'd114,  8'd27, 8'd14},
			P1_C7 = {8'd201, 8'd116, 8'd51};

parameter   P2_C1 = {8'd137, 8'd173, 8'd224}, 
		  	P2_C2 = {8'd255, 8'd255, 8'd255},
			P2_C3 = {8'd208, 8'd221, 8'd203},
			P2_C4 = {8'd103, 8'd143, 8'd232},
			P2_C5 = { 8'd83, 8'd118, 8'd197};

parameter   P3_C1 = {8'd238, 8'd255, 8'd246}, 
		  	P3_C2 = {8'd213, 8'd132,  8'd76},
			P3_C3 = {8'd246, 8'd187, 8'd128},
			P3_C4 = {8'd253, 8'd226,   8'd3},
			P3_C5 = {8'd243, 8'd207, 8'd126};
			
parameter   P4_C1 = {8'd254, 8'd233, 8'd183}, 
		  	P4_C2 = {8'd250, 8'd218, 8'd159},
			P4_C3 = {8'd242, 8'd171, 8'd117},
			P4_C4 = {8'd243, 8'd207, 8'd126},
			P4_C5 = {8'd251, 8'd185,  8'd52};
// state 
parameter STR = 4'd0, WAIT = 4'd1,  ADD = 4'd2, CMP = 4'd3, SUB = 4'd4, REF = 4'd5;

reg [10:0] shift;
always @(posedge pixclk)begin
	if (cs == STR)
		case (select)
		0: shift <= 0;
		1: shift <= 160;
		2: shift <= 320;
		3: shift <= 480;
		endcase
	else 
		shift <= shift;
end

reg [23:0] SELECT_C, BACKGROUND_C;
always @(posedge pixclk)begin
	if(cs == REF) begin
		SELECT_C <= {8'd204, 8'd255,  8'd229};
		BACKGROUND_C <= {8'd204, 8'd255,  8'd229};
	end
	else begin
		SELECT_C <= WINDOWS;
		BACKGROUND_C <= BACKGROUND;
	end
end

always @ (posedge pixclk) begin
if (cs == STR)
		begin
        ////////////////////////////////////////////////////////////////////////////////////// PICTURE 1				
			////////////////////////////////////////////////////////////////////////////////////// SECTION 1
		    if (CounterY >= 0 && CounterY < 5 )
				begin 
					if (CounterX >= shift && CounterX < MaxDrawAreaX/4 + shift  )           
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 1			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 2
		    else if (CounterY >= 5 && CounterY < 155)//155 pixel
		       begin 
					if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )         
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end 
		    ////////////////////////////////////////////////////////////////////////////////////// END SECTION2
		    ////////////////////////////////////////////////////////////////////////////////////// SECTION 3 show product part
		    else if (CounterY >= 155 && CounterY < 310)//155 pixel
				     begin 			
					if       (CounterY >= 155 && CounterY < 155 + 19 )    //s1
						begin 
						if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						///////////////////////////////////////picture 1 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						///////////////////////////////////////picture 2 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C1 ; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C2; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C2; 
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2; 
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C1; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <=  P4_C2; 
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <=  P4_C1; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <=  P4_C2; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <=  P4_C1; 
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
				
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end
						
					else if (CounterY >= 155 + 19 && CounterY < 155 + 38) //s2
						begin 
						if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
					    
					    ///////////////////////////////////////picture 1 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue} <= P1_C1; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C2;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C2; 
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C1; 
						
						///////////////////////////////////////picture 2 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C;  //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C;  
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C1;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C2; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C5; 
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= P4_C1; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C2; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C1;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C2;  
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C1; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C3;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C1; 
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 38 && CounterY < 155 + 57 ) //s3
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 				
					    
					    ///////////////////////////////////////picture 1 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C2; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C2; 
						
						///////////////////////////////////////picture 2 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C4;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C1;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C1; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C1; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= P4_C1; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C2;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C1;  
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C2; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C1;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C5; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end  
						
					else if (CounterY >= 155 + 57 && CounterY < 155 + 76 ) //s4
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					    ///////////////////////////////////////picture 1 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C1; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C2;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C1; 
						
						///////////////////////////////////////picture 2 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C1;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C4;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4;
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue} <= P4_C1;  //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C4; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 76 && CounterY < 155 + 95 ) //s5
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue} <= P1_C3; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C4; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C5; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C5; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C3;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C4;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C5; 
						
						///////////////////////////////////////picture 2 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C4;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C4;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3;
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C4;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
			
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C5; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 95 && CounterY < 155 + 114 ) //s6
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C6; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C6; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C4;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C6; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C6;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C6; 
						
						///////////////////////////////////////picture 2 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C2; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 6////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4;
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 114 && CounterY < 155 + 133 ) //s7
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C7; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C7;
						
						///////////////////////////////////////picture 2 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3;
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4;
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 133 && CounterY < 155 + 152) //s8
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					    ///////////////////////////////////////picture 1 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C7;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C7;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C7; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						///////////////////////////////////////picture 2 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 ) {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C3; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3;
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C3;
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 8////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
					 else 
					    begin 
					    if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						 else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
					 
					end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 3  PICTURE 1
			////////////////////////////////////////////////////////////////////////////////////// SECTION 4
			 else if (CounterY >= 310 && CounterY < MaxDrawAreaY-5) //155 pixel
		       begin 
					if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )          
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <= BACKGROUND_C;
				end 
			////////////////////////////////////////////////////////////////////////////////////// END SECTION4
			////////////////////////////////////////////////////////////////////////////////////// SECTION 5
			else if (CounterY >= MaxDrawAreaY-5 && CounterY < MaxDrawAreaY )
				begin 
					if (CounterX >= shift && CounterX < MaxDrawAreaX/4 + shift  )           
					    {r_red,r_green,r_blue} <= SELECT_C;
					else
					    {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION5		
		end					
/////////////////////// sate//////////////////////////////////////////////////////////////////////////////////////          
else if(cs == WAIT || cs == ADD || cs == CMP || cs == SUB)
		begin
        ////////////////////////////////////////////////////////////////////////////////////// PICTURE 1				
			////////////////////////////////////////////////////////////////////////////////////// SECTION 1
		    if (CounterY >= 0 && CounterY < 5 )
				begin 
					if (CounterX >= shift && CounterX < MaxDrawAreaX/4 + shift  )           
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 1			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 2
		    else if (CounterY >= 5 && CounterY < 155)//155 pixel
		       begin 
					if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )         
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end 
		    ////////////////////////////////////////////////////////////////////////////////////// END SECTION2
		    ////////////////////////////////////////////////////////////////////////////////////// SECTION 3 show product part
		    else if (CounterY >= 155 && CounterY < 310)//155 pixel
				     begin 			
					if       (CounterY >= 155 && CounterY < 155 + 19 )    //s1
						begin 
						if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						///////////////////////////////////////picture 1 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						///////////////////////////////////////picture 2 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C1 ; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C2; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C2; 
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2; 
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C1; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <=  P4_C2; 
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <=  P4_C1; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <=  P4_C2; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <=  P4_C1; 
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
				
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end
						
					else if (CounterY >= 155 + 19 && CounterY < 155 + 38) //s2
						begin 
						if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
					    
					    ///////////////////////////////////////picture 1 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue} <= P1_C1; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C2;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C2; 
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C1; 
						
						///////////////////////////////////////picture 2 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C;  //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C;  
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C1;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C2; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C5; 
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= P4_C1; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C2; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C1;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C2;  
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C1; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C3;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C1; 
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 38 && CounterY < 155 + 57 ) //s3
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 				
					    
					    ///////////////////////////////////////picture 1 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C2; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C2; 
						
						///////////////////////////////////////picture 2 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C4;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C1;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C1; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C1; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= P4_C1; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C2;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C1;  
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C2; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C1;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C5; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end  
						
					else if (CounterY >= 155 + 57 && CounterY < 155 + 76 ) //s4
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					    ///////////////////////////////////////picture 1 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C1; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C2;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C1; 
						
						///////////////////////////////////////picture 2 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C1;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C4;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4;
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue} <= P4_C1;  //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C4; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 76 && CounterY < 155 + 95 ) //s5
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue} <= P1_C3; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C4; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C5; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C5; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C3;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C4;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C5; 
						
						///////////////////////////////////////picture 2 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C4;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C4;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3;
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C4;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
			
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C5; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 95 && CounterY < 155 + 114 ) //s6
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C6; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C6; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C4;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C6; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C6;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C6; 
						
						///////////////////////////////////////picture 2 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C2; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 6////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4;
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 114 && CounterY < 155 + 133 ) //s7
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C7; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C7;
						
						///////////////////////////////////////picture 2 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3;
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4;
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 133 && CounterY < 155 + 152) //s8
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					    ///////////////////////////////////////picture 1 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C7;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C7;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C7; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						///////////////////////////////////////picture 2 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 ) {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C3; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3;
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C3;
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 8////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
					 else 
					    begin 
					    if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						 else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
					 
					end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 3  PICTURE 1
			////////////////////////////////////////////////////////////////////////////////////// SECTION 4
			 else if (CounterY >= 310 && CounterY < MaxDrawAreaY-5) //155 pixel
		       begin 
					if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )          
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <= BACKGROUND_C;
				end 
			////////////////////////////////////////////////////////////////////////////////////// END SECTION4
			////////////////////////////////////////////////////////////////////////////////////// SECTION 5
			else if (CounterY >= MaxDrawAreaY-5 && CounterY < MaxDrawAreaY )
				begin 
					if (CounterX >= shift && CounterX < MaxDrawAreaX/4 + shift  )           
					    {r_red,r_green,r_blue} <= SELECT_C;
					else
					    {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION5		
		end						
///////////////////////other sate//////////////////////////////////////////////////////////////////////////////////////       
else
		begin
        ////////////////////////////////////////////////////////////////////////////////////// PICTURE 1				
			////////////////////////////////////////////////////////////////////////////////////// SECTION 1
		    if (CounterY >= 0 && CounterY < 5 )
				begin 
					if (CounterX >= shift && CounterX < MaxDrawAreaX/4 + shift  )           
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 1			
			////////////////////////////////////////////////////////////////////////////////////// SECTION 2
		    else if (CounterY >= 5 && CounterY < 155)//155 pixel
		       begin 
					if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )         
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end 
		    ////////////////////////////////////////////////////////////////////////////////////// END SECTION2
		    ////////////////////////////////////////////////////////////////////////////////////// SECTION 3 show product part
		    else if (CounterY >= 155 && CounterY < 310)//155 pixel
				     begin 			
					if       (CounterY >= 155 && CounterY < 155 + 19 )    //s1
						begin 
						if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						///////////////////////////////////////picture 1 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						///////////////////////////////////////picture 2 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C1 ; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C2; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C2; 
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2; 
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 1/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C1; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <=  P4_C2; 
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <=  P4_C1; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <=  P4_C2; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <=  P4_C1; 
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
				
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end
						
					else if (CounterY >= 155 + 19 && CounterY < 155 + 38) //s2
						begin 
						if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
					    
					    ///////////////////////////////////////picture 1 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue} <= P1_C1; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C2;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C2; 
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C1; 
						
						///////////////////////////////////////picture 2 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C;  //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C;  
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C1;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C2; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C5; 
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 2/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= P4_C1; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C2; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C1;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C2;  
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C1; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C3;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C1; 
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 38 && CounterY < 155 + 57 ) //s3
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 				
					    
					    ///////////////////////////////////////picture 1 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C2; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C2; 
						
						///////////////////////////////////////picture 2 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C4;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C1;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C1; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C1; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= P3_C2;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 3/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= P4_C1; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C2;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C1;  
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C2; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C1;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C5; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end  
						
					else if (CounterY >= 155 + 57 && CounterY < 155 + 76 ) //s4
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					    ///////////////////////////////////////picture 1 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C1; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C2;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C1; 
						
						///////////////////////////////////////picture 2 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C1;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C1; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C4;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4;
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 4/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue} <= P4_C1;  //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C4; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 76 && CounterY < 155 + 95 ) //s5
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )   {r_red,r_green,r_blue} <= P1_C3; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C4; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C5; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C5; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C3;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C4;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C5; 
						
						///////////////////////////////////////picture 2 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )   {r_red,r_green,r_blue} <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C4;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C4;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C4; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C5;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= P3_C3;
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C4;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 5/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
			
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= P4_C5; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 95 && CounterY < 155 + 114 ) //s6
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C6; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C6; 
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C4;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C6; 
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C6;
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C5;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C6; 
						
						///////////////////////////////////////picture 2 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C2; 
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 6////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C4; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 6/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4;
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 114 && CounterY < 155 + 133 ) //s7
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					   ///////////////////////////////////////picture 1 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= P1_C7; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C1;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C1; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C1;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= P1_C7;
						
						///////////////////////////////////////picture 2 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C2;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C2;
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3;
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )   {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 7/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C4;
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C4; 
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C4;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
						
					else if (CounterY >= 155 + 133 && CounterY < 155 + 152) //s8
						begin 
							if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						
					    ///////////////////////////////////////picture 1 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION1      && CounterX < POSITION1 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION1 + 8  && CounterX < POSITION1 + 16 )  {r_red,r_green,r_blue} <= P1_C7;
							
						else if (CounterX >= POSITION1 + 16 && CounterX < POSITION1 + 24 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 24 && CounterX < POSITION1 + 32 )  {r_red,r_green,r_blue} <= P1_C7;
							
						else if (CounterX >= POSITION1 + 32 && CounterX < POSITION1 + 40 )  {r_red,r_green,r_blue} <= P1_C7; 
							
						else if (CounterX >= POSITION1 + 40 && CounterX < POSITION1 + 48 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 48 && CounterX < POSITION1 + 56 )  {r_red,r_green,r_blue} <= P1_C7;
						
						else if (CounterX >= POSITION1 + 56 && CounterX < POSITION1 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						///////////////////////////////////////picture 2 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION2      && CounterX  < POSITION2  + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION2  + 8  && CounterX < POSITION2  + 16 ) {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION2  + 16 && CounterX < POSITION2  + 24 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 24 && CounterX < POSITION2  + 32 )  {r_red,r_green,r_blue} <= P2_C3; 
							
						else if (CounterX >= POSITION2  + 32 && CounterX < POSITION2  + 40 )  {r_red,r_green,r_blue} <= P2_C3;
							
						else if (CounterX >= POSITION2  + 40 && CounterX < POSITION2  + 48 )  {r_red,r_green,r_blue} <= P2_C3;
						
						else if (CounterX >= POSITION2  + 48 && CounterX < POSITION2  + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION2  + 56 && CounterX < POSITION2  + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
						//////////////////////////////////////picture 3 row 8/////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION3      && CounterX < POSITION3 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION3 + 8  && CounterX < POSITION3 + 16 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
							
						else if (CounterX >= POSITION3 + 16 && CounterX < POSITION3 + 24 )  {r_red,r_green,r_blue} <= P3_C3;
						
						else if (CounterX >= POSITION3 + 24 && CounterX < POSITION3 + 32 )  {r_red,r_green,r_blue} <= P3_C3; 
							
						else if (CounterX >= POSITION3 + 32 && CounterX < POSITION3 + 40 )  {r_red,r_green,r_blue} <= P3_C3;
							
						else if (CounterX >= POSITION3 + 40 && CounterX < POSITION3 + 48 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 48 && CounterX < POSITION3 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION3 + 56 && CounterX < POSITION3 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						
				     	///////////////////////////////////////picture 4 row 8////////////////////////////////////////////////////////
					    else if (CounterX >= POSITION4      && CounterX < POSITION4 + 8 )  {r_red,r_green,r_blue}  <= BACKGROUND_C; //64/8 = 8
							
						else if (CounterX >= POSITION4 + 8  && CounterX < POSITION4 + 16 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 16 && CounterX < POSITION4 + 24 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 24 && CounterX < POSITION4 + 32 )  {r_red,r_green,r_blue} <= P4_C5;
							
						else if (CounterX >= POSITION4 + 32 && CounterX < POSITION4 + 40 )  {r_red,r_green,r_blue} <= P4_C5; 
							
						else if (CounterX >= POSITION4 + 40 && CounterX < POSITION4 + 48 )  {r_red,r_green,r_blue} <= P4_C5;
						
						else if (CounterX >= POSITION4 + 48 && CounterX < POSITION4 + 56 )  {r_red,r_green,r_blue} <= BACKGROUND_C;
						
						else if (CounterX >= POSITION4 + 56 && CounterX < POSITION4 + 64 )  {r_red,r_green,r_blue} <= BACKGROUND_C; 
						///////////////////////////////////////end picture all/////////////////////////////////////////////////////////
						
					    else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
					 else 
					    begin 
					    if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )
						    begin 
							 {r_red,r_green,r_blue} <= SELECT_C;
					     	end 
						 else 
						    begin 
							 {r_red,r_green,r_blue} <= BACKGROUND_C;
					     	end 
						end 
					 
					end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION 3  PICTURE 1
			////////////////////////////////////////////////////////////////////////////////////// SECTION 4
			 else if (CounterY >= 310 && CounterY < MaxDrawAreaY-5) //155 pixel
		       begin 
					if (CounterX == 0 + shift || CounterX == MaxDrawAreaX/4 + shift -1 )          
					  {r_red,r_green,r_blue} <= SELECT_C;
					else
					  {r_red,r_green,r_blue} <= BACKGROUND_C;
				end 
			////////////////////////////////////////////////////////////////////////////////////// END SECTION4
			////////////////////////////////////////////////////////////////////////////////////// SECTION 5
			else if (CounterY >= MaxDrawAreaY-5 && CounterY < MaxDrawAreaY )
				begin 
					if (CounterX >= shift && CounterX < MaxDrawAreaX/4 + shift  )           
					    {r_red,r_green,r_blue} <= SELECT_C;
					else
					    {r_red,r_green,r_blue} <=  BACKGROUND_C;
				end  
			////////////////////////////////////////////////////////////////////////////////////// END SECTION5		
		end	
end


endmodule