

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
So we create a table and count the occurrences of each word in each sentence

however the model still does not know what is positive and what is negative

so we provide a value column ([1 0 0]^T), where a 1 indicates this is a positive statement, and a 0 indicates a negative statement. 

another way to  use this method is for days of the week, instead of having the output as a continuous date, use [0 1 0 0 0 0 0]  where 1 is tuesday

However, this method does not preserve the ordering, and this is important when dealing with language


![[Pasted image 20260218183735.png]]
So here we include two words for every token

Originally with creating a feature per word,  we would have n features for n words
However, when creating pairs, we increase the number of features that we have,  so if  we have  n words we would have features>n

![[Pasted image 20260218184051.png]]
we do not want lowfrequency words as there is n't enough information for the model to learn
we do not want high frequency words as they are too generalized
we want medium frequency so we can generalize and not overfit

![[Pasted image 20260218184340.png]]
We go from high dimensional data to lower dimensional data (we are removing columns) this results in a model that will be less likely to overfit

![[Pasted image 20260218184424.png]]
There are different ways to count frequency
- Count whether it appears or not (Binary)
- Raw number of times it appears
- Normalization percentage of the frequency in the paragraph (or whatever mode we use [sentence])  [I personally like this]
- Log of the count