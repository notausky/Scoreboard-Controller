module t_ScoreboardController(); 


       wire Done;
       wire [6:0]seg7_points_2;
       wire [6:0]seg7_points_1;
       wire [6:0]seg7_points_0;
       wire [6:0]seg7_timer_1;
       wire [6:0]seg7_timer_0;
       wire [6:0]seg7_level;
       reg clk=0, St=0, Pt=0;

       always  #5 clk = ~clk;

       ScoreboardController C1(clk, St, Pt, Done, seg7_points_2, seg7_points_1, seg7_points_0, seg7_timer_1, seg7_timer_0, seg7_level);

       initial begin
               St = 1;
               #60 Pt = 1; #5 Pt = 0; St = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;

               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;

               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0; 
               #20 Pt = 1; #5 Pt = 0;
               
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0; 
               #20 Pt = 1; #5 Pt = 0;

               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0; 
               #20 Pt = 1; #5 Pt = 0;

               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0; 
               

               #40 Pt = 1; #5 Pt = 0; // R2
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0; 
               #20 Pt = 1; #5 Pt = 0;

               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
    
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
 
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0; 

               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;  

               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;          

               #200 St = 1;
               #20 Pt = 1; #5 Pt = 0; St = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;
               #20 Pt = 1; #5 Pt = 0;


        
      end
       
    endmodule
   
