# MIPS Instructions

## Registers
- $zero: 0
- $v0 - $v1: Return Values
- $a0 - $a3: Function Arguments/Parameters
- $t0 - $t9: Temporaries (Caller-Saved)
- $s0 - $s7: Saved Values (Callee-Saved)
- $sp: Stack Pointer
- $ra: Return Address

## Instruction Format
- 32 bits.
- 3 Types:
	- **R-Type:** opcode (6) + rs (5) + rt (5) + rd (5) + shamt (5) + funct (6)
	- **I-Type:** opcode (6) + rs (5) + rt (5) + imm (16)
	- **J-Type:** opcode (6) + offset (26)

### Addressing Modes
- Register Addressing: `add $12, $10, $8`
- Indirect Addressing: `jr $31`
- Immediate Addressing: `addi $8, $12, 35`
- Base Addressing: `lw $12, 100($8)`
- PC-Relative Addressing: `beq $8, $10, 8`
- Pseudo-Direct Addressing: `j 100`

## Instruction Set
### Arithmetic
- `add $rd, $rs, $rt`
- `sub $rd, $rs, $rt`
- `addi $rt, $rs, imm`
- `addu $rd, $rs, $rt`
- `subu $rd, $rs, $rt`

**Note:** In `add` or `sub`, when overflow occurs, the result is not stored and an exception is raised. In `addu` or `subu`, the overflow is simply ignored.

### Logical
- `and $rd, $rs, $rt`
- `or $rd, $rs, $rt`
- `xor $rd, $rs, $rt`
- `andi $rt, $rs, imm`
- `ori $rt, $rs, imm`
- `xori $rt, $rs, imm`

### Shift
- `sll $rd, $rt, s` = Shift Left Logical
- `srl $rd, $rt, s` = Shift Right Logical
- `sra $rd, $rt, s` = Shift Right Arithmetic
- `slt $rd, $rs, $rt` = Set on Less Than

**Note:** `s` stands for the number of bit locations to be shifted.

**Note:** `srl` sets the MSB to 0 while `sra` duplicates the sign bit onto the MSB.

**Note:** `slt` sets $rd to 1 if $rs is less than $rt, else, it sets $rd to 0.

### Data Transfer
- `lw $rt, imm($rs)` = Load Word
- `sw $rt, imm($rs)` = Store Word
- `lb $rt, imm($rs)` = Load Byte
- `sb $rt, imm($rs)` = Store Byte

**Note:** `imm($rs)` → `mem($rs + imm)`

### Control Flow
- `beq $rs, $rt, L`
- `bne $rs, $rt, L`
- `j L`
- `jr $ra`
- `jal L`

**Note:** `j L` → [PC] = nPC[31:28]::L[25-0]::00, nPC = PC + 4

**Note:** `beq $rs, $rt, L` / `bne $rs, $rt, L` → [PC] = nPC + (L &times; 4), nPC = PC + 4

**Note:** `jal L` stores the current PC value i.e. nPC into $ra and performs a jump by L words like `beq` or `bne`.

### Adv. Arithmetic
- `mult $rs, $rt`
- `div $rs, $rt`

**Note:** `mult` results in a 64-bit product, which is stored in the special *Acc* register.

**Note:** `div` results in a quotient and a remainder. The quotient is stored in the lower half of *Acc* i.e. LO and the remainder is stored in the upper half of *Acc* i.e. HI.

### Register to Register Data Transfer
- `mfhi $rd` = Move from HI
- `mflo $rd` = Move from LO
- `mthi $rs` = Move to HI
- `mtlo $rs` = Move to LO

### Loading 32 Bits Into a Register
In order to put `0x00aa0bb0` into $t0:

1. `lui $t0, 0x00aa` = $t1 ← (imm << 16)
2. `ori $t0, 0x0bb0`
	- **Note:** `0x0bb0` is zero-extended to 32 bits.

### MIPS Procedure Calls
- When executing a procedure, the values of callee-saved registers (and $ra) must first be pushed to stack.
- The values must be popped back to their respective original registers at the end of the procedure before returning the control back to the caller.

```
addi $sp, $sp, -8	# creates stack for two values
sw <reg1>, 8($sp)
sw <reg2>, 4($sp)

< Procedure Body >

lw <reg2>, 4($sp)
lw <reg1>, 8($sp)
addi $sp, $sp, 8	# restores stack

JR $ra
```

**Note:** The value of $ra needs to be saved into the stack only if the procedure is a non-leaf or recursive procedure. 
