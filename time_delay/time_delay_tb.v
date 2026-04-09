`timescale 1ns/1ns

module test ;
    reg  ai, bi ;
    wire so_lose, so_get, so_normal ;
 
    // 优化 ai 激励：间隔均匀、跳变清晰
    initial begin
        ai = 0;
        #20;  ai = 1;  // 20ns
        #20;  ai = 0;  // 40ns
        #20;  ai = 1;  // 60ns
        #20;  ai = 0;  // 80ns
        #20;  ai = 1;  // 100ns
    end
 
    // 优化 bi 激励：和 ai 错开，方便观察组合逻辑时延
    initial begin
        bi = 0;
        #30;  bi = 1;  // 30ns
        #30;  bi = 0;  // 60ns
        #30;  bi = 1;  // 90ns
    end
 
    // 时延模块例化
    time_delay_module  u_wire_delay(
        .ai        (ai),
        .bi        (bi),
        .so_lose   (so_lose),
        .so_get    (so_get),
        .so_normal (so_normal)
    );
 
    // 关键优化：实时打印所有信号值，清晰看时延
    initial begin
        $monitor("Time: %3d ns | ai=%b | bi=%b | so_lose=%b | so_get=%b | so_normal=%b",
                 $time, ai, bi, so_lose, so_get, so_normal);
    end
 
    // 仿真控制：150ns 足够观察所有跳变+时延
    initial begin
        #150;
        $display("\n仿真结束！");
        $finish;
    end
 
    // 波形导出（可选，方便Verdi/ModelSim看波形）
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, test);
    end
 
endmodule