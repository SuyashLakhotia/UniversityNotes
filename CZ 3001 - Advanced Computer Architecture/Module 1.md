# Module 1

## Review of Hardware Components
- **Arithmetic Logic Unit (ALU)** performs arithmetic and logical operations.- **Control Unit** generates control signals to load data into the registers, read data from memory/registers, write data into memory, perform ALU operations etc.- **Memory** stores data and instructions.
- **Input Units** provide the input data.- **Output Units** deliver the output.
- The ALU, control unit and a set of registers make up the **Central Processing Unit (CPU)**.

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
	- SIMD, Vector Processors
- Reduction of CPI
	- Instruction Pipelining
	- Multi-issue Processors (VLIW, Superscalar Processors)
	- Multicore Processing

### Amdahl's Law
- Speedup via parallelism is limited by that component of an application which cannot be enhanced (the sequential component).
- If a fraction *U* of an application cannot be enhanced for parallel implementation, then the speedup is limited to *1/U*.
	- If *x%* of an application cannot be enhanced, then the speedup is limited to *100/x*.

#### Speedup
Speedup of Computer B over Computer A =
Exec. Time in Comp A &divide; Exec. Time in Comp B

### Other Metrics
- MIPS (Millions of Instructions per Second)
- FLOPS (Floating Point Operations per Second)

## Types of Parallelism
- **Instruction Level Parallelism:**
	- **Scalar Pipeline:** Multiple instructions are executed concurrently at different stages of the pipeline in a single processor.
	- **Superscalar/VLIW Processors:** Multiple independent instructions are identified and grouped to be executed concurrently in different functional units in a single processor.
- **Data Level Parallelism:** The same operation/task is performed on multiple data values concurrently in multiple processing units.
- **Task Level Parallelism:** Independent processors ("cores") perform different sets of independent tasks concurrently in the same *multicore processor*.

## Power Consumption
### Dynamic Power Consumption
- Consumed when the processor executes instructions.
- Increases with the operating voltage and clock frequency of the processor.
- Mainly due to charging and discharging of pseudo capacitors in the CMOS transistors.

#### Formula
**P<sub>dyn</sub> = ACV<sup>2</sup>f**

- A: switching activity factor (avg. fraction of transistors switching in one clock cycle)
- C: total load capacitance in the circuit
- V: operating voltage
- f: clock frequency

### Static Power Consumption
- Consumed when the processor is powered-on (even if no instructions are executed).
- Independent of clock frequency.
- Proportional to leakage current, which increases with temperature and vice-versa.
- Increase in temperature also reduces the processor's reliability.

#### Formula
**P<sub>static</sub> = VI<sub>leak</sub>**

### Reducing Power Consumption
- **Maximum Operating Frequency:** f<sub>max</sub> &prop; (V - V<sub>th</sub>)<sup>2</sup> / V
- Voltage reduction can result in considerable saving of power, however, performance is almost linearly degraded with voltage reduction.
- If performance degrades, the clock period increases, increasing the total energy consumed.

#### Energy & Energy Delay Product
- Since battery life & net heat dissipation depend on energy consumption (and not power consumption), a better metric for power efficiency is **energy (in Joules/instruction)**.
- However, energy can also be reduced by reducing the voltage that may subsequently degrade the speed performance.
- Hence, **Energy Delay Product = Energy &times; Computation Time** is a better metric than power and energy to compare the power efficiency of processors.
- How to reduce EDP?
	- Either increase the performance or reduce the energy dissipation without significantly deteriorating the other.
		- Parallel Processing & Pipelining.
	- Voltage-Frequency Scaling
		- If a system is designed to provide more than required performance at a given voltage, then the operating voltage and frequency can be scaled down to provide needed performance with lower power dissipation.