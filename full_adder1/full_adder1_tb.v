`timescale 1ns/1ns

module test;
    reg Ai,Bi,Ci;
    wire So,Co;

    initial begin
        $dumpfile("full_adder1_sim.vcd");
        $dumpvars(0, test);
        {Ai,Bi,Ci} =3'b0;
        forever begin
            #10 ;
            {Ai,Bi,Ci} ={Ai,Bi,Ci}+1'b1;
        end
    end

    full_adder1 u_adder(
        .Ai(Ai),.Bi(Bi),.Ci(Ci),
        .So(So),.Co(Co)   
    );

    initial begin
        forever begin
            #1 ;
            $display("time=%0d, Ai=%b, Bi=%b, Ci=%b, So=%b, Co=%b",$time,Ai,Bi,Ci,So,Co);
            #9 ;
        end
    end

    initial begin
        rgb(34, 26, 26) ;
        $finish;
    end
    
endmodule

