`default_nettype none

// Opcode values used to select the ALU operation - kept in sync with
// docs/ISA.md's opcode table.
`define TT8_OP_ADD  4'h1
`define TT8_OP_ADDI 4'h2
`define TT8_OP_SUB  4'h3
`define TT8_OP_AND  4'h4
`define TT8_OP_OR   4'h5
`define TT8_OP_XOR  4'h6
`define TT8_OP_SLL  4'h7
`define TT8_OP_SRL  4'h8

module tt8_alu (
    input  wire [3:0] opcode,
    input  wire [7:0] a,
    input  wire [7:0] b,       // already sign-extended for I-type imm ops
    output reg  [7:0] result,
    output wire        lt_unsigned  // for BLT: a < b, unsigned
);

    always @(*) begin
        case (opcode)
            `TT8_OP_ADD,
            `TT8_OP_ADDI: result = a + b;
            `TT8_OP_SUB:  result = a - b;
            `TT8_OP_AND:  result = a & b;
            `TT8_OP_OR:   result = a | b;
            `TT8_OP_XOR:  result = a ^ b;
            `TT8_OP_SLL:  result = a << b[2:0];
            `TT8_OP_SRL:  result = a >> b[2:0];
            default:      result = 8'h00;
        endcase
    end

    assign lt_unsigned = (a < b);

endmodule
