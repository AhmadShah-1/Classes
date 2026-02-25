




![[Pasted image 20260220090828.png]]
For classification it is easy to map a neural network to discrete outputs
For Images (which is unstructured  but entirely numerical) it is easy to flatten it and apply nonlinear transformations to derive outputs from it

Ways to turn textual data to numerical info:
- frequency: Drawbacks: You miss a lot of semantical meaning, you are using pure frequency no context understanding

There is a better way using Embeddings that provides meaning to the semantical meaning, 


![[Pasted image 20260225085814.png]]
Turn each word into a numerical vector

When LLM and NLP started, they provided rules to the model to understand e