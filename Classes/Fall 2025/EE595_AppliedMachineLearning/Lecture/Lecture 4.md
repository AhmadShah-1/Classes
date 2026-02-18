# Decision Trees



![[Pasted image 20251114063823.png]]

can handle both regression and classification classes with the same model


![[Pasted image 20251114064119.png]]

leaf node should be yes or no

![[Pasted image 20251115133343.png]]

we can see a clear path in its assumptions (makes its results explainable) (something we can tune directly and explain why a result was obtained)

![[Pasted image 20251115145713.png]]

![[Pasted image 20251115145833.png]]
Entropy used to measure the uncertaininty basically to measaure chaos
x = random variable
log2 is because we are measuring with bits

![[Pasted image 20251115150122.png]]
E = 0 means no uncertainty
E = 1 means max uncertainity (50/50 class split)
Entropy is between 0 and 1

![[Pasted image 20251115150148.png]]

![[Pasted image 20251115150810.png]]

![[Pasted image 20251115150823.png]]
![[Pasted image 20251115150835.png]]
![[Pasted image 20251115150901.png]]

![[Pasted image 20251115150907.png]]


## Real Example
Calculate Total Entropy:
![[Pasted image 20251115151145.png]]

Calculate for each branch (we choose outlook):
![[Pasted image 20251115151312.png]]

calculate weighted entropy (how many yes of each)
![[Pasted image 20251115151505.png]]

Now we have information gain:
![[Pasted image 20251115151526.png]]


## Check other attributes
![[Pasted image 20251115151616.png]]

## Check each attribute based on it
![[Pasted image 20251115151711.png]]

![[Pasted image 20251115151806.png]]
![[Pasted image 20251115151813.png]]

![[Pasted image 20251115151922.png]]
We have 2-3 sub criteria usually to tell it to stop because we won't be able ot get any more meaningful attribute splits that leads to a decent gain


 ![[Pasted image 20251115152234.png]]

![[Pasted image 20251115152521.png]]

## How to reduce overfitting:
![[Pasted image 20251115152606.png]]

![[Pasted image 20251115152831.png]]

![[Pasted image 20251115152934.png]]
This avoids computational costs
Negatives: No special deisgn or rigourous proofs

![[Pasted image 20251115153500.png]]


## Example:
![[Pasted image 20251115153708.png]]

Lets focus on the low tree:
![[Pasted image 20251115153733.png]]
1 is less than 2.82 which means we can remove the tree
so we remove Regular and Irregular and if a student has Low its classified as No

## Other kind of pruning
![[Pasted image 20251115153924.png]]
![[Pasted image 20251115154053.png]]
![[Pasted image 20251115154210.png]]

## Chi Sqaured Table
![[Pasted image 20251115154403.png]]


# Real World Example (Chi Square)
![[Pasted image 20251115154500.png]]
![[Pasted image 20251115154541.png]]
![[Pasted image 20251115154825.png]]
the result is 0.73 and we want a 95% success rate
95% means a value of .05, which corresponds to 3.84146
and our value is less than the required, meaning it isn't statistically important 

(much like last time) we can delete that tree

![[Pasted image 20251115154951.png]]

![[Pasted image 20251115155017.png]]
![[Pasted image 20251115155318.png]]




## Classification And Regression Trees
![[Pasted image 20251115155444.png]]
![[Pasted image 20251115155631.png]]

