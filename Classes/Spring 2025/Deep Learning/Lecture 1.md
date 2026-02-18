
![[Pasted image 20260131200505.png]]

Machine Learning:
- Structured Data (Features)
- Human needs to specify features, for the model to learn
- For tabular data


Deep Learning:
- Unstructured Data (Neural Network)
- No human needed, model learns to get the desired output
- Used for Images
- Matrix Multiplication (multiple steps hence its called Deep)

Linear:
![[Pasted image 20260131201737.png]]
- You do rotations and do not change the geometry
- Because you aren't changing the geometry, the data is preserved, so if you rotate it one way, just perform the inverse to retrieve the original data
- Think of rotating a rubix cube, you can always rotate it back
- Linear Transform


NonLinear:
![[Pasted image 20260131201924.png]]
-  Say you divide the matrix into parts, whichever parts are less than 0, just equate it to zero
- You are not transforming anything, instead you are removing and modifying data
- As you are modifying the data, you cannot restore the original state
- Think of a rubix cube, cut off a corner (like with a knife), it is now lost and cannot be restored


Steps for converting an image:
![[Pasted image 20260131202340.png]]
- Input vector
- multiply by matrix (Neural Network)
- apply nonlinear operator
- multiply by matrix
- apply nonlinear operator

Think of rotating a rubix cube, then cut of the corner, rotate it again, cut off another corner, and keep doing it and it will be reshaped to whatever you want it to be
Input (cube) -> output (sphere)
This process is called Deep

Info about building models: https://d2l.ai/chapter_builders-guide/index.html
