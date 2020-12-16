// N-bit parameterized structural multiplier

module mult #(parameter WIDTH=6)
  (input [WIDTH-1:0] x,y, output [WIDTH*2-1:0] z);
  
  wire [11:0] x0;
  wire [10:0] x1;
  wire [9:0] x2;
  wire [8:0] x3;
  wire [7:0] x4;
  wire [6:0] x5;

  genvar i;
  for(i=WIDTH*2-1; i>WIDTH-1; i=i-1) begin: X_w
    wire [i:0] xi;
  end
  
  genvar j;
  for(i=0; i<WIDTH; i=i+1) begin: andx
    for(j=0; j<WIDTH; j=j+1) begin: andy
      and gi(xi[j],x[i],y[j]);
    end
  end

  wire [9:0] c1i;
  wire [10:0] c1o;
  wire [8:0] c2i;
  wire [9:0] c2o;
  wire [7:0] c3i;
  wire [8:0] c3o;
  wire [6:0] c4i;
  wire [7:0] c4o;
  wire [5:0] c5i;
  wire [6:0] c5o;

  for(i=WIDTH*2-3; i>WIDTH-2; i=i-1) begin: cin_w
    wire [i:0] carryi;
  end

  for(i=WIDTH*2-2; i>WIDTH-1; i=i-1) begin: cout_w
    wire [i:0] couti;
  end

  wire [9:0] FA1;
  wire [8:0] FA2;
  wire [7:0] FA3;
  wire [6:0] FA4;
  wire [5:0] FA5;

  for(i=WIDTH*2-3; i>WIDTH-2; i=i-1) begin: FA_w
    wire [i:0] FAi;
  end

  and g0 [5:0] (x11[5:0],x[0],y[5:0]);
  and g1 [5:0] (x10[5:0],x[1:1],y[5:0]);
  and g2 [5:0] (x9[5:0],x[2:2],y[5:0]);
  and g3 [5:0] (x8[5:0],x[3:3],y[5:0]);
  and g4 [5:0] (x7[5:0],x[4:4],y[5:0]);
  and g5 [5:0] (x6[5:0],x[5:5],y[5:0]);
  HA h1 (x11[1],x10[0],z[1],cout10[0]);
  HA h2 (FA9[0],x9[0],z[2],cout9[0]);
  HA h3 (FA8[0],x8[0],z[3],cout8[0]);
  HA h4 (FA7[0],x7[0],z[4],cout7[0]);
  HA h5 (FA6[0],x6[0],z[5],cout6[0]);
  FA f1 [9:0] (x11[11:2],x10[10:1],carry9,FA9,cout10[10:1]);
  FA f2 [8:0] (FA9[9:1],x9[9:1],carry8,FA8,cout9[9:1]);
  FA f3 [7:0] (FA8[8:1],x8[8:1],carry7,FA7,cout8[8:1]);
  FA f4 [6:0] (FA7[7:1],x7[7:1],carry6,FA6,cout7[7:1]);
  FA f5 [5:0] (FA6[6:1],x6[6:1],carry5,FA5,cout6[6:1]);
  addsub #(.WIDTH(WIDTH)) a1 (FA5,x6[5:0],x[5],z[11:6]);

  assign carry9[9:0] = cout10[9:0];
  assign carry8[8:0] = cout9[8:0];
  assign carry7[7:0] = cout8[7:0];
  assign carry6[6:0] = cout7[6:0];
  assign carry5[5:0] = cout6[5:0];

  assign x11[11:6] = {6{x11[5]}};
  assign x10[10:6] = {5{x10[5]}};
  assign x9[9:6] = {4{x9[5]}};
  assign x8[8:6] = {3{x8[5]}};
  assign x7[7:6] = {2{x7[5]}};
  assign x6[6] = x6[5];

  assign z[0] = x11[0];
endmodule


module tb;
  reg [5:0] a,b;
  wire [11:0] z,x11;


  mult m1(a,b,z);

  initial begin
    a = 6'b110110; b = 6'b101011;
  end

  initial
    $monitor("A=%b, B=%b, Sum=%b, x11=%d @ time=%d",a,b,z,x11,$time);
endmodule