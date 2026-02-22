

#Tokenization
#NLP

NLP is far different  from LLM

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
Tokens → building blocks  
n-grams → combinations of tokens


Originally with creating a feature per word,  we would have n features for n words
However, when creating pairs, we increase the number of features that we have,  so if  we have  n words we would have features>n

![[Pasted image 20260218185600.png]]
![[Pasted image 20260218185610.png]]


![[Pasted image 20260218184051.png]]
we do not want lowfrequency words as there is n't enough information for the model to learn
we do not want high frequency words as they are too generalized
we want medium frequency so we can generalize and not overfit

- **Very high frequency words** ("the", "and")  
    → appear everywhere → not discriminative  
    → low information value
    
- **Very low frequency words**  
    → may be typos, noise  
    → model may memorize them → overfitting


![[Pasted image 20260218184340.png]]
We go from high dimensional data to lower dimensional data (we are removing columns) this results in a model that will be less likely to overfit

![[Pasted image 20260218184424.png]]
There are different ways to count frequency
- Count whether it appears or not (Binary)
- Raw number of times it appears
- Normalization percentage of the frequency in the paragraph (or whatever mode we use [sentence])  [I personally like this]
- Log of the count [Good for recommender: used in tiktok algo to find the type of things you like]

![[Pasted image 20260218185104.png]]
say we had 10,000 reviews for a movie
each of those reviews are a document
then we count the occurance of each word in all the documents
say for example each document mentions the word awesome about 3 times, and 2000 times in all the documents  

2000 would be document frequency
the IDF would be log(10000/2000)

TF answers:
> Is this word important in this document?

IDF answers:
> Is this word special compared to the whole corpus?

TF-IDF answers:
> Is this word important here AND rare globally?




![[Pasted image 20260218190205.png]]
We can use normalization to make BOW better

We can use logistic regression, random forest, decision tree, xgboost, etc as this is numerical tabular data





![[Pasted image 20260218190434.png]]
![[Pasted image 20260218190501.png]]
![[Pasted image 20260218190529.png]]

![[Pasted image 20260218190540.png]]
![[Pasted image 20260218190550.png]]



![[Pasted image 20260218190555.png]]

![[Pasted image 20260218190844.png]]
Normally when working with models, you want numerical data, and when you have text data such as names (which we cannot turn to columns) we would use OneHotEncoding to translate it to a language the model can process, however this is flawed

say we onehotencode "water" and "milk", when encoded, they will be entirely different vectors, with no relation to one another, thus the model cannot build an inference of relationship between the two. (It should kinda map liquid or say milk comprised of water)

Another problem:
Amazon for example would assign objectIDs to names, which would result in large values, if those were oneHotEncoded, it would result in a large number of parameters, additionally when thinking of the insane amount of words in the English language, if we were to do 1-gram, then 2-gram, etc. The size of possibilities would continually grow, the model would be unable to learn as it is unable to make similarities between words, and this exponential growth also has an effect on our storage.

One way to solve this is to preserve the order of it,  by using step grams or CBOW to preserve order relation.

To solve this we use embeddings instead      


(ASK GPT IF WHAT I WROTE ABOVE SOUNDS ABOUT RIGHT)