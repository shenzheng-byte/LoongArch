`timescale 1ns/1ns

module test;
    reg [3:0] ai, bi;
    reg [3:0] ai2, bi2;
    reg [3:0] value_blk;
    reg [3:0] value_non;
    reg [3:0] value_non2;

    initial begin
        // 初始值
        ai  = 4'd1;
        bi  = 4'd2;
        ai2 = 4'd7;
        bi2 = 4'd8;
        #20;

        // ===================== 20ns 同一时刻执行 =====================
        ai        = 4'd3;      // 阻塞：立即变 3
        bi        = 4'd4;      // 阻塞：立即变 4
        value_blk = ai + bi;   // 立即算 3+4=7

        value_non <= ai + bi;  // 非阻塞：暂存 7
        ai2       <= 4'd5;     // 非阻塞：暂存 5
        bi2       <= 4'd6;     // 非阻塞：暂存 6
        value_non2<= ai2 + bi2;// 非阻塞：用旧值 7+8=15

        // ----------------- 【打印1】同一时刻，非阻塞还没更新 -----------------
        // 这里能看到：ai2=7, bi2=8, value_non2=旧值（未更新）
        $display("========== 时间 = %0d ns（本行执行中，非阻塞未更新） ==========", $time);
        $display("ai=%0d, bi=%0d", ai, bi);
        $display("ai2=%0d, bi2=%0d  (旧值！)", ai2, bi2);
        $display("value_blk=%0d", value_blk);
        $display("value_non=%0d, value_non2=%0d", value_non, value_non2);

        #1;

        // ----------------- 【打印2】非阻塞 已经全部更新完成 -----------------
        $display("\n========== 时间 = %0d ns（非阻塞已更新） ==========", $time);
        $display("ai=%0d, bi=%0d", ai, bi);
        $display("ai2=%0d, bi2=%0d", ai2, bi2);
        $display("value_blk=%0d", value_blk);
        $display("value_non=%0d, value_non2=%0d", value_non, value_non2);

        #100;
        $finish;
    end

endmodule