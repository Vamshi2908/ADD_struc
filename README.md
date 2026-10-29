# ADD_struc — Structural 8-bit Register-Bank Datapath (Verilog)

A small structural Verilog design: a 7-register, 8-bit register bank on a shared bus, with a `MOVE` and an `ADD` instruction and a gate-level ripple-carry adder. Built and simulated in Xilinx Vivado (target part `xc7k70tfbg484-3`).

## How it works

- **Instruction format (8 bits):** `[7:6]` opcode, `[5:3]` destination register D, `[2:0]` source register S.
  - `00` — **MOVE**: `D <- S`. Register 0 is the external port: source 0 reads `in`, destination 0 drives `out`.
  - `01` — **ADD**: `R7 <- D + S`, executed over two clock cycles. The first operand is latched into a temporary register, then the second is read onto the bus and summed by the adder, with the result written to R7.
- **Registers:** `Reg_Bank` holds R1–R7 as `Reg_8bit` instances with asynchronous active-low reset and tri-state outputs onto the shared bus.
- **Adder:** `Adder_8bit` is a generate-based chain of `full_adder` cells (9-bit sum output including carry).
- **Decoder:** `Decoder` is a 3-to-8 enable decoder used for the load and bus-enable selects.

## Layout

| Path | Contents |
|---|---|
| `rtl/Main_Module.v` | Top level: control, bus, temp register |
| `rtl/Reg_Bank.v` | `Reg_8bit` and the R1–R7 register bank |
| `rtl/Decoder.v` | 3-to-8 decoder with enable |
| `rtl/Adder_8bit.v` | `full_adder` and ripple-carry `Adder_8bit` |
| `tb/Main_Module_tb.v` | Testbench: loads R1–R7 with 1–7, then runs MOVE and ADD cases and prints the register state |

## Running the simulation

1. In Vivado, add everything in `rtl/` as design sources (`Main_Module.v` uses `` `include `` for the others, so keep them in the same folder) and `tb/Main_Module_tb.v` as the simulation source.
2. Run behavioural simulation with `Main_Module_tb` as top. The testbench prints R1–R7 and `Out` through `$monitor`.
