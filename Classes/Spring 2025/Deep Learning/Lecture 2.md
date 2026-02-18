

#Tokenization
#NLP


highly nonlinear activation functions are better for hidden layers

For images, input layer reduce dimensions until the output layer is reached
For timeseries or sensor data, you can still flatten it into a input matrix, very  good for highly non-linear relationships  

Natural language processing is unstructured data. As for numerical input  we can use numerical matrix  and neural networks, with sequential and  nonlinear mapping. But for natural language we need a different approach.


![[Pasted image 20260218092644.png]]
![[Pasted image 20260218092716.png]]
Token is smaller than a word
Token < Word

about 0.6 word  =  1 tokens

![[Pasted image 20260218092854.png]]
import nltk  (for tokenization)

![[Pasted image 20260218092925.png]]
We want the same token  for different forms of the word, so we use stemming to remove the suffix and get the root of the word (called a stem)

TODO: ask chatgpt to explain lemmitization

![[Pasted image 20260218092936.png]]

![[Pasted image 20260218181237.png]]
So we need some way to numerically represent the sentences
So we create a table and count the occurances of each word in each sentence

however the model still does not know what is positive and what is negative

so we provide a value column ([1 0 0]^T), where a 1 indicates this is a positive statement, and a 0 indicates a negative statement. 
