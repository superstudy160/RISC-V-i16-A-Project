`include "./b.v"

module A();

    reg inp;
    wire out;
    
    B u_B(
        .a 	( inp  ),
        .b 	( out  )
    );
    

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, A);

        inp <= 0;
        #10;
        $display("%b %b", inp, out);
        inp <= 1;
        #10;
        $display("%b %b", inp, out);
        #10;
    end
endmodule //A
