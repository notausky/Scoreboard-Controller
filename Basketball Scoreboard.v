module ScoreboardController(clk, St, Pt, Done, seg7_points_2, seg7_points_1, seg7_points_0, seg7_timer_1, seg7_timer_0, seg7_level); 

  parameter Threshold_1 = 40;

  input   clk; 
  input   St;
  input   Pt;  
  output reg Done;
  output  [6:0]seg7_points_2;
  output  [6:0]seg7_points_1;
  output  [6:0]seg7_points_0;
  output  [6:0]seg7_timer_1;
  output  [6:0]seg7_timer_0;
  output  [6:0]seg7_level;
   
  reg [3:0]  BCD_points_2;  //100
  reg [3:0]  BCD_points_1;  //10
  reg [3:0]  BCD_points_0;  //1
  reg [3:0]  BCD_timer_1;   //10
  reg [3:0]  BCD_timer_0;   //1
  reg [3:0]  BCD_level;
  reg [6:0]  seg7Rom [0:9];
  reg [2:0]  State;
  reg [2:0]  Nextstate;
  reg ClrS;
  reg ClrL;
  reg Ldt;
  reg EnT;
  reg Tthree;
  reg Tup;
  reg Add2;
  reg Add3;
  reg Pass;
  reg Next;
  reg Final;


  initial begin
    State = 3'b000;
    Nextstate = 3'b000;
    BCD_points_2= 4'b0000;
    BCD_points_1 = 4'b0000;
    BCD_points_0 = 4'b0000;
    BCD_timer_1 = 4'b0110;
    BCD_timer_0 = 4'b0000;
    BCD_level = 4'b0001;
    seg7Rom[0] = 7'b0111111;
    seg7Rom[1] = 7'b0000110;
    seg7Rom[2] = 7'b1011011;
    seg7Rom[3] = 7'b1001111;
    seg7Rom[4] = 7'b1100110;
    seg7Rom[5] = 7'b1101101;
    seg7Rom[6] = 7'b1111100;
    seg7Rom[7] = 7'b0000111;
    seg7Rom[8] = 7'b1111111;
    seg7Rom[9] = 7'b1100111;
    ClrS = 1'b0;
    ClrL = 1'b0;
    Ldt = 1'b0;
    EnT = 1'b0;
    Tthree = 1'b0;
    Tup = 1'b0;
    Add2 = 1'b0;
    Add3 = 1'b0;
    Pass = 1'b0;
    Next = 1'b0;
    Final = 1'b0;
  end

  always @(posedge Add2, Add3) begin  //Points+
    if (Add2 == 1'b1) begin
      if (BCD_points_0 < 4'b1000) begin
        BCD_points_0 <= BCD_points_0 + 2;
      end
      else if (BCD_points_1 < 4'b1001) begin //10+
        BCD_points_1 <= BCD_points_1 + 1;
        BCD_points_0 <= BCD_points_0 - 8;
      end
      else if(BCD_points_2 < 4'b1001) begin //100+
        BCD_points_2 <= BCD_points_2 + 1;
        BCD_points_1 <= BCD_points_1 - 9;
        BCD_points_0 <= BCD_points_0 - 8;
      end 
      Add2 <= 1'b0;   
    end
    else if (Add3 == 1'b1)begin  
      if (BCD_points_0 < 4'b0111) begin
        BCD_points_0 <= BCD_points_0 + 3;
      end
      else if (BCD_points_1 < 4'b1001) begin // 10+
        BCD_points_1 <= BCD_points_1 + 1;
        BCD_points_0 <= BCD_points_0 - 7;
      end
      else if(BCD_points_2 < 4'b1001) begin // 100+ 
        BCD_points_2 <= BCD_points_2 + 1;
        BCD_points_1 <= 0;
        BCD_points_0 <= BCD_points_0 - 7;
      end
     Add3 <= 1'b0;
    end 
  end
  
  always @(posedge ClrS) begin
    BCD_points_2 <= 4'b0000;
    BCD_points_1 <= 4'b0000;
    BCD_points_0 <= 4'b0000;
  end
  
  always @(posedge ClrL) begin
    BCD_level <= 4'b0001;
    Final <= 1'b0;
  end

  always @(posedge Ldt) begin
    BCD_timer_1 <= 4'b0110;
    BCD_timer_0 <= 4'b0000;
    Tthree <= 1'b0;
    Tup <= 1'b0;
  end
  
  always @(posedge Next) begin
    BCD_level <= BCD_level + 1;
    Pass <= 1'b0;
  end

  
  
  always @(posedge clk) begin // Timer, (set 1s/clk)
    if(EnT == 1'b1) begin
      if(BCD_timer_1 == 4'b0000 && BCD_timer_0 == 4'b0000) begin
        EnT <= 1'b0;
        if(BCD_level == 2) begin  //final level?
            Final <= 1'b1;
        end
        else begin
          if(BCD_points_2 * 100 + BCD_points_1 * 10 + BCD_points_0  >=  Threshold_1) begin  //pass?
            Pass <= 1'b1;
          end
        end
        Tup <= 1'b1;
      end
      else if(BCD_timer_0 == 4'b0000) begin
        BCD_timer_0 <= 4'b1001;
        BCD_timer_1 <= BCD_timer_1 - 1;
      end
      else begin
        BCD_timer_0 <= BCD_timer_0 - 1;
      end
    end
    if(BCD_timer_1 == 4'b0001 && BCD_timer_0 == 4'b0101 ) begin
      Tthree <= 1'b1;
    end
  end


  always @(posedge St, Pt, clk) begin  //SM
    case (State)  
      0 : 
        begin
          Done = 1'b0;
          if (St == 1'b1) begin
            Nextstate <= 1;
          end
          else begin
            Nextstate <= 0;
          end
        end
      1 : 
        begin
          ClrS <= 1'b1;
          ClrL <= 1'b1;
          Ldt <= 1'b1;
          Nextstate <= 2;
        end
      2 :
        begin
          EnT <= 1'b1;
          ClrS <= 1'b0;
          ClrL <= 1'b0;
          Ldt <= 1'b0; 
          if (Tup == 1'b1) begin
            if (Final == 1'b1) begin
              Nextstate <= 7;
            end
            else begin
              if (Pass == 1'b1) begin
                Nextstate <= 5;
              end
              else begin
                Nextstate <= 7;
              end
            end
          end
          else begin
            if (Pt == 1'b1) begin
              if (Tthree == 1'b1) begin
                Nextstate <= 4;
              end
              else begin
                Nextstate <= 3;
              end
            end
            else begin
              Nextstate <= 2;
            end
          end
        end
      3 :
        begin
          Add2 <= 1'b1;
          Nextstate <= 2;
        end
      4 :
        begin
          Add3 <= 1'b1;
          Nextstate <= 2;
        end
      5 :
        begin
          Next <= 1'b1;
          Nextstate <= 6;
        end
      6 :
        begin
          Ldt <= 1'b1;
          Nextstate <= 2;
        end
      7 :
        begin
          Done = 1'b1;
          Nextstate <= 0;
        end
    endcase
  State <= Nextstate;
  end

  assign seg7_points_2 = seg7Rom[BCD_points_2];
  assign seg7_points_1 = seg7Rom[BCD_points_1];
  assign seg7_points_0 = seg7Rom[BCD_points_0];
  assign seg7_timer_1 = seg7Rom[BCD_timer_1];
  assign seg7_timer_0 = seg7Rom[BCD_timer_0];
  assign seg7_level = seg7Rom[BCD_level];


endmodule
