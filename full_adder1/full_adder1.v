module full_adder1(Ai,Bi,Ci,So,Co);
    input Ai,Bi,Ci;
    output So,Co;

    assign {Co,So}=Ai+Bi+Ci;
endmodule

