# Module 1

## Review of Hardware Components
- **Arithmetic Logic Unit (ALU)** performs arithmetic operations and logical operations.- **Control Unit** generates control signals to load data into the registers, to read data from the memory or from registers, to write data into the memory, and to perform ALU operations, etc.- **Memory:** stores data and instructions
- **Input Units:** provide the input data- **Output Units:** deliver out the output
- ALU, control unit and a set of registers make up the **Central Processing Unit (CPU)**.

## Performance Metrics
### Execution Time
- Time required to execute a program.
- Performance = 1 / Execution Time
- Execution Time = Instruction Count &times; Cycles Per Instruction &times; Clock Period

#### CPI & Datapath
- Multi-cycle Datapath: CPI > 1
- Pipelined Datapath: CPI = 1 *(ideal)*
- Parallel Datapath: CPI < 1

#### Solutions for Performance Enhancement
- Reduction of Clock Period / Increase in Clock Frequency
	- Power Consumption Increases
	- CPI Increases
	- Memory-Wall Problem
- Reduction of Instruction Count
	- Complexity of Instructions Increases &rArr; Clock Period Increases
	- *SIMD, Vector Processors*
- Reduction of CPI
	- Instruction Pipelining
	- Multi-issue Processors (VLIW, Superscalar Processors)
	- Multicore Processing

### Amdahl's Law
- Speedup via parallelism is limited by that component of an application which cannot be enhanced (the sequential component).
- If fraction *U* of an application cannot be enhanced for parallel implementation, then the speedup is limited by a factor of *1/U*.
	- If *x%* of an application cannot be enhanced, then the speedup is limited by a factor of *100/x*.

#### Speedup
Speedup of Computer B over Computer A:
Exec. Time in Comp A / Exec. Time in Comp B

### Other Metrics
- MIPS (Millions of Instructions per Second)
- FLOPS (Floating Point Operations per Second)

## Types of Parallelism
- **Instruction Level Parallelism:** Multiple instructions are executed concurrently at different stages of the pipeline.
- **Data Level Parallelism:** Each processor performs the same task on different data.
- **Task Level Parallelism:** Each processor performs a different set of independent tasks concurrently.

## Power Consumption
### Dynamic Power Consumption
- Consumed when the processor executes instructions.
- Increases with the operating voltage and clock frequency of the processor.
- Mainly due to charging and discharging of pseudo capacitors in the CMOS transistors.

#### Formula
<p align="center">
	P<sub>dyn</sub> = ACV<sup>2</sup>f
</p>

- A: switching activity factor (avg. fraction of transistors switching in one clock cycle)
- C: total load capacitance in the circuit
- V: operating voltage
- f: clock frequency

### Static Power Consumption
- Consumed when the processor powered-on (even if no instructions are executed).
- Independent of clock frequency but increases with the temperature of the processor.
- Mainly due to leakage current.

#### Formula
<p align="center">
	P<sub>static</sub> = VI<sub>leak</sub>
</p>

- Leakage current increases with temperature and vice-versa.

### Reducing Power Consumption
- **Maximum Operating Frequency:** f<sub>max</sub> &prop; V
- Voltage reduction can result in considerable saving of power, however, performance is linearly degraded with voltage reduction.
- If performance degrades, clock period increases, increasing total energy consumed.

#### Energy Delay Product
- **Energy Delay Product = Energy &times; Computation Time**
- How to reduce EDP?
	- Either increase the performance or reduce the energy dissipation without significantly deteriorating the other.
		- Parallel Processing & Pipelining.
	- Voltage-Frequency Scaling
		- If a system is designed to provide more than required performance at a givenvoltage, then the operating voltage and frequency can be scaled down to provide needed performance with lower power dissipation.

### Misc. Notes
- Power dissipation makes the device hotter, which reduces the reliability of the processor.