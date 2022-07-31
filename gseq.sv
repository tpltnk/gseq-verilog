module gseq_gen #(
    parameter integer n = 10,
    parameter show = 0
) (
    a1,
    k,
    s
);

// general term: a1 * k ** (n-1), where n is natural, k is real, a_i is real.

input real a1;
input real k;
output reg [63:0]s[0:n-1];
integer i;

reg [63:0] max_s = 64'b11111111_11111111_11111111_11111111_11111111_11111111_11111111_11111111;
reg [63:0] ovf_s = 64'b00000000_00000000_00000000_00000000_00000000_01101111_01110110_01100110;

initial begin
    for (i=0; i<n; i++) begin
        if (a1 * k ** i >= max_s) begin
            s[i] = ovf_s; // "<61 nulls>ovf"
        end else begin
            s[i] = a1 * k ** i;
        end
        if (show) begin
            if (s[i] == ovf_s) begin
                $display("%d: %s", i+1, s[i]);
            end else begin
                $display("%d: %.2f", i+1, s[i]);
            end
        end
    end
end

endmodule

module root;

parameter integer n = 10;
reg [63:0] e[0:n-1];

gseq_gen #(.n(n), .show(1)) g(2, 30, e);

endmodule
