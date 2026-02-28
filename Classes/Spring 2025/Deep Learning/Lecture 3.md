




![[Pasted image 20260220090828.png]]
For classification it is easy to map a neural network to discrete outputs
For Images (which is unstructured  but entirely numerical) it is easy to flatten it and apply nonlinear transformations to derive outputs from it

Ways to turn textual data to numerical info:
- frequency: Drawbacks: You miss a lot of semantical meaning, you are using pure frequency no context understanding

There is a better way using Embeddings that provides meaning to the semantical meaning, 

When LLM and NLP started, they provided rules to the model to understand meaning and grammar, but it was very tedious


![[Pasted image 20260225085814.png]]
Turn each word into a numerical vector
- Start from random noise: Assign a random vector to each word (good word = positive, bad word = negative)
- Have Neural Net derive meaning from the vectors of each word
- After Neural Net tuned all the vectors, we do not need the Neural Net anymore, just the vectors 

The vector of a word in the system is known as the "hidden representation." Say we have vectors for water and milk, the are similar in a way, meaning that their vector representation in the space is close together. But if two things are very distinct they will be very far away 

"Thank" and "You" are always used together, so when the model is tuning the vectors, the resulting vectors will also place the two close together.


![[Pasted image 20260225090731.png]]
Say we have 4 vectors:
- France
- Paris
- China
- Beijing

If you take the difference of France - Paris, and compare  it to the difference between China - Beijing, you  will see that they have equivalent vector directions


![[Pasted image 20260225090853.png]]
If you have the vector for "King" and subtract it with the vector "Man" and then add the vector "Woman", the resulting vector will be the vector for "Queen"

Unlike bag of word, or any frequency measurement and relationship between words.
The model, using embeddings, can ascertain the meaning of words and derive it from other words as well, to build a semantical meaning in a sense.


![[Pasted image 20260225091407.png]]
You can differentiate different people based on numerical vectors (Personality Embedding Vector). You can use Personality Embedding Vector to match different people on dating apps that would match well if their vectors are close



![[Pasted image 20260225091657.png]]


![[Pasted image 20260225091935.png]]

1:00:00