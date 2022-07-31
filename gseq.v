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

initial begin
    for (i=0; i<n; i++) begin
        if (a1 * k ** i >= 64'B1111111111111111111111111111111111111111111111111111111111111111) begin
            s[i] = 64'B0000000000000000000000000000000000000000_01101111_01110110_01100110; // "<61 nulls>ovf"
            if (show) begin
                $display("%d: %s", i+1, s[i]);
            end
        end else begin
            s[i] = a1 * k ** i;
            if (show) begin
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
