# Neural Networks Basics

## Biological Neurons

Artificial neural networks are inspired by the biological neural networks in the brain that are made up of billions of basic information-processing units called neurons, which consist of:

- **Soma**: Cell body which processes incoming activations and converts them into output activations.
- **Dendrites**: Receptive zones that receive activation signals from other neurons.
- **Axon**: Transmission lines that send activation signals to other neurons.
- **Synapse**: The connection point between two neurons (presynaptic & postsynaptic). Allow weighted signal transmission through diffusion of chemicals.

Each neuron receives electrochemical inputs from other neurons at the dendrites. The soma sums the incoming signals and if the sum is sufficient enough to activate the neuron, it transmits an electrochemical signal along the axon where it is passed to other neurons whose dendrites may be attached at any of the axon terminals.

The neuron either fires or it doesn't and synapses may be excitatory or inhibitory.

## Artificial Neurons

![Artificial Neuron](img/Artificial%20Neuron.png)

An artificial neuron is the basic unit of neural networks. The total synaptic input ($u$) is given by the sum of the products of the inputs and their corresponding connecting weights minus the threshold (or plus the bias) of the neuron.

$$
u = \sum_{i = 1}^n x_i w_i - \theta = \boldsymbol{x}^T \boldsymbol{w} - \theta
$$

The activation function $f$ relates the synaptic input to the activation of the neuron. For a typical artificial neuron, the output $y$ is equal to the result of the activation function (i.e. $f(u)$).

### Bias vs. Threshold

The threshold can be considered as the weight for an input of -1. Often, the threshold is represented as a bias that receives a constant input of +1.

$$
\begin{aligned}
\text{Threshold: } &u = \boldsymbol{x}^T \boldsymbol{w} - \theta \\
\text{Bias: } &u = \boldsymbol{x}^T \boldsymbol{w} + b
\end{aligned}
$$

### Typical ANN Activation Functions

#### Threshold (Unit Step) Activation Function

$$
f(u) =
\begin{cases}
1 & u > 0 \\
0 & u \leq 0
\end{cases}
$$

#### Linear Activation Function

$$
f(u) = \beta u
$$

where the slope $\beta$ is often assumed to be 1.0.

#### Ramp Activation Function

$$
f(u) = \text{max} \big\{0.0, \text{min} \{1.0, u + 0.5\} \big\}
$$

#### Unipolar Sigmoid Activation Function

$$
f(u) = \frac{a}{1 + e^{-bu}}
$$

where the function ranges from $0$ to $a$ and $b$ denotes the slope. When $a = 1.0$ and $b = 1.0$, the unipolar sigmoid function is known as the **logistic function**.

#### Bipolar Sigmoid Activation Function

$$
\begin{split}
f(u) &= a \bigg(\frac{1 - e^{-bu}}{1 + e^{-bu}} \bigg) \\
     &= a \bigg(\frac{2}{1 + e^{-bu}} - 1 \bigg)
\end{split}
$$

where the function ranges from $-a$ to $+a$ and $b$ denotes the slope.

Sigmoidal functions are the most pervasive and biologically plausible activation functions. Since sigmoidal functions are differentiable, they lead to mathematically attractive neuronal models.

#### Rectified Linear Unit (ReLU) Activation Function

$$
f(u) = \max \{0, u\}
$$

ReLU units are increasingly being used to model neurons because of their speed when implementing large networks.

## ANN Architectures

### Two-Layer Feedforward Network

- Comprised of an input layer of source units that inject into an output layer of neurons.

### Multilayer Feedforward Network

- Comprised of more than one layer of neurons. Layers between input source nodes and output layer are referred to as *hidden layers*.
- Multilayer neural networks can handle more complicated and larger scale problems than single-layer networks.
- However, training a multilayer network may be more difficult and time-consuming.

### Recurrent Networks (w/o hidden neurons)

- Recurrent networks consist of a single layer of neurons with each neuron feeding its output signal back to the input layer.
- One unit of delay is assumed during the feedback of output to input.

![Recurrent Network](img/Recurrent%20Network.png)

## ANN Learning

- Neural networks attain their operating characteristics through **learning**.
- During training, the weights or the strengths of connections are gradually adjusted.
- Training may be *supervised* or *unsupervised*.

**Supervised Learning:** For each training input pattern, the network is presented with the correct target answer (i.e. the desired output).

**Unsupervised Learning:** For each training input pattern, the network adjusts weights without knowing the correct target. The network self-organizes to classify similar input patterns into clusters.

### General Learning Algorithm

If $\boldsymbol{w_k} = (w_{k1}, w_{k2}, \hdots, w_{kn})^T$ is the weight vector of neuron $k$ and the desired output for input $\boldsymbol{x} = (x_1, x_2, \hdots, x_n)^T$ is $d$, the change $\Delta$ of weight can be expressed as:

$$
\Delta \boldsymbol{w_k} = \alpha \cdot r (\boldsymbol{w_k}, b_k, \boldsymbol{x}, d)
$$

where $r (\boldsymbol{w_k}, b_k, \boldsymbol{x}, d)$ is the learning signal which depends on the current weight vector, bias, input and desired output & $\alpha$ is the learning parameter which spans between 0 and 1. Note that $d$ is zero for unsupervised learning.

Training occurs iteratively for all training patterns and all output nodes until convergence. A cycle of iteration refers to a set of iterations that goes over all the input patterns (i.e. one epoch) and convergence is achieved when there is no change in the values of weights (and bias) with every iteration.

### Hebbian Learning Rule

The Hebbian learning rule states that the weight of a connection is altered in proportion to the product of the input and output related to that connection during learning.

So, for a neuron with $i$ connections:

$$
\begin{gathered}
\Delta w_i \propto y x_i \\
\Delta w_i = \alpha y x_i
\end{gathered}
$$

The Hebbian learning rule is given by:

$$
\begin{aligned}
w_i^{new} &= w_i^{old} + \alpha y x_i \\
b^{new} &= b^{old} + \alpha y \\
\end{aligned}
$$

## Characteristics of ANNs

Neural networks posses many attractive characteristics which surpass some of the limitations in classical information processing systems.

- **Parallel & Distributed Processing:** The information is stored in connections distributed over the network and processed in a large number of neurons connected in parallel. This greatly enhances the speed and efficiency of processing.
- **Adaptiveness:** Neural networks learn from exemplars (training patterns) as they arise in the external world.
- **Generalization:** Networks have the ability to learn the rules and mimic the behavior of a large ensemble of inputs from an adequate set of exemplars.
- **Fault Tolerance:** Since information processing involves a large number of neurons and connections, the loss of a few connections does not necessarily affect the overall performance.
- **Ease of Construction:** A short development time is required to implement a neural-based solution for complex problems.

## ANN Applications

- Optical Character Recognition
- Computer Vision: Object / Face Recognition, Motion Detection
- Pattern Recognition: Defect Detection
- Engineering Process Control
