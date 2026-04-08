module and_gate_tb;
    reg a;
    reg b;
    wire c;

    and_gate uut (.a(a), .b(b), .c(c));

    initial begin
        // 新增：生成波形文件
        $dumpfile("and_gate_wave.vcd"); // 波形文件保存为 and_gate_wave.vcd
        $dumpvars(0, and_gate_tb);      // 记录测试模块的所有信号
        
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end

    initial begin
        $monitor("Time = %0t, a = %b, b = %b, c = %b", $time, a, b, c);
    end
endmodule