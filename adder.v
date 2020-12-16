// Basic adders used for multiplier

module FA(input a,b,cin, output s,cout);
  assign #1 s = a^b^cin;
  assign #1 cout = (a&b)|(cin&(a^b));
endmodule

module HA(input a,b, output s,cout);
  assign #1 s = a^b;
  assign #1 cout = a&b;
endmodule


module addsub #(parameter WIDTH=4) 
  (input [WIDTH-1:0] a,b, input as, output [WIDTH-1:0] s);
  wire [WIDTH-1:0] inb,cin,cout;

  xor #1 x1 [WIDTH-1:0] (inb,b,as);
  FA #1 f1 [WIDTH-1:0] (a,inb,cin,s,cout);

  assign cin[0] = as;
  assign cin[WIDTH-1:1] = cout[WIDTH-2:0];
endmodule