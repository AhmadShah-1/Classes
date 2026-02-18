
# XGBoost

![[Pasted image 20260205164254.png]]
For Structured Data 


 ![[Pasted image 20260205164539.png]]
 Tree-based means it has good explanations for why it works (Unlike Deep-Learning)

![[Pasted image 20260205164629.png]]

![[Pasted image 20260205164723.png]]

![[Pasted image 20260205165106.png]]

![[Pasted image 20260205165710.png]]

 ![[Pasted image 20260205175045.png]]

![[Pasted image 20260205175108.png]]

![[Pasted image 20260205180111.png]]
L1: Faster, uses absolute value on coeffients [y = logit(a1x1 + a2x2 + ...) + |a1| + |a2| + |.|]
L2: Slower, uses square value of coefficients 

Sparsity Awareness:
Say you have missing data, for organizing classes based on an indivudal's age, if over 30 years old save to right column, if under left
if its missing the age value, the model will try placing it in each category one by one and see whihc has the bigger effect on accuracy

Weighted Quantile Sketch:
it tries to use percentiles to help make evaluations (like what's the age of the top 10% of good programmers)


![[Pasted image 20260205184132.png]]
Uses Gradient and Hessan (or hertian, not sure what he was saying) Hessan helps make predictions towards the gradient faster than just using the Gradient


Regularizer:
![[Pasted image 20260205184254.png]]
![[Pasted image 20260205184300.png]]


![[Pasted image 20260205184307.png]]
Gradient: first derivitive
Hessan: Second Derivtive


![[Pasted image 20260205184327.png]]

![[Pasted image 20260205184605.png]]

![[Pasted image 20260205184633.png]]
Less precision but far faster


![[Pasted image 20260205184654.png]]
XGBoost when scanning trees looks layer by layer (horizontally)
LightGMB when scanning tress uses depth first search
![[Pasted image 20260205184813.png]]
![[Pasted image 20260205184823.png]]

![[Pasted image 20260205184846.png]]

![[Pasted image 20260205184850.png]]

![[Pasted image 20260205184902.png]]
Learning Rate: 
n_estimators: smaller = efficient     bigger = better
max_depth: if you have hundres and thousands of features, then increase it really high, otherwise it doesn't need to be that deep


![[Pasted image 20260205185045.png]]
gamma: measure loss 


![[Pasted image 20260205185115.png]]
![[Pasted image 20260205185132.png]]
0 for lambda or alpha means no regularization of that type (L2, L1)