


# Neural Network


![[Pasted image 20251115193240.png]]

![[Pasted image 20251115193258.png]]


We can represent it a perceptron as an AND gate:
![[Pasted image 20251116094806.png]]

here it is an OR gate:
![[Pasted image 20251116094927.png]]

![[Pasted image 20251116094935.png]]
Perceptron can represent everything but XOR gates (will learn how later)

![[Pasted image 20251116095129.png]]
Each update will update the weights

To try to move the decision boundary correctly
![[Pasted image 20251116095148.png]]



![[Pasted image 20251116095249.png]]
We need more than just linear seperation (early ML), researchers tried to solve non-linear problems by stacking (but no matter how much you stack its still linear)

So they introduced non-linear functions such as Sigmoid and RELU, which know makes outputs between 0 and 1

Here we have the sigmoid function as the activation function
![[Pasted image 20251116094644.png]]


![[Pasted image 20251116095535.png]]
We use gradient descent as our updating rule to have minimized error

Our loss function:
![[Pasted image 20251116095632.png]]



To calculate error gradient of sigmoid function:
![[Pasted image 20251116095800.png]]


We previously went over the updating of a single neuron, this is how you congregate multiple layers of neurons:
![[Pasted image 20251116095849.png]]


Backpropagation Algorithm:
![[Pasted image 20251116100059.png]]
![[Pasted image 20251116100357.png]]
![[Pasted image 20251116100500.png]]
![[Pasted image 20251116100512.png]]

![[Pasted image 20251116100537.png]]

![[Pasted image 20251116100604.png]]

![[Pasted image 20251116100709.png]]


![[Pasted image 20251116100732.png]]

![[Pasted image 20251116100756.png]]

Techniques for training:
Activation:
![[Pasted image 20251116101402.png]]
![[Pasted image 20251116101451.png]]


Initialization of neuron weights:
![[Pasted image 20251116101614.png]]
![[Pasted image 20251116101828.png]]


Momentum:
![[Pasted image 20251116102009.png]]
