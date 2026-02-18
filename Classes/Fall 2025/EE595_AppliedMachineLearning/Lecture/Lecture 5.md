
# Ensemble Learning



### This is just for general knowledge (not specifically just for ensemble learning)
Similiar to overfitting
![[Pasted image 20251115155941.png]]
![[Pasted image 20251115160026.png]]

![[Pasted image 20251115160238.png]]
Bias = Model performance - Real Target
Variance = Model performance - actual performance

![[Pasted image 20251115160350.png]]

![[Pasted image 20251115160428.png]]

We want complex models to make better guesses, but not too many that it cant generalize new data well

![[Pasted image 20251115160511.png]]
Helps balance bias and variance
average validation results across folds
and the test on testing data





# Ensemble Learning

![[Pasted image 20251115160858.png]]
Ensemble Learning uses individual classifiers together to build a stronger predictor (ensemble)

![[Pasted image 20251115160935.png]]

![[Pasted image 20251115161029.png]]

![[Pasted image 20251115161043.png]]
![[Pasted image 20251115161342.png]]


![[Pasted image 20251115161425.png]]
Classifiers must be selected each for a specific problem (no point of having two very similar classifiers)
Ensemble has better generalizing ability 

![[Pasted image 20251115161502.png]]

![[Pasted image 20251115161557.png]]

![[Pasted image 20251115161703.png]]
Soft output means some continuous value (percentage)

![[Pasted image 20251115161722.png]]
Class Label is a Hard Output

![[Pasted image 20251115161740.png]]

# Soft Output
![[Pasted image 20251115161753.png]]

![[Pasted image 20251115161819.png]]

![[Pasted image 20251115161825.png]]
We can assume weights by the importance of each classifier


# Hard Output
![[Pasted image 20251115162005.png]]

![[Pasted image 20251115162027.png]]
we choose the first one with majority vote
we can go a step further

![[Pasted image 20251115162046.png]]

 Next up is naive bayes
![[Pasted image 20251115162355.png]]


![[Pasted image 20251115162630.png]]


Naive Bayes can be used for both soft and hard outputs



# Major Influential Methods

![[Pasted image 20251115163208.png]]

## Bootstrapping
![[Pasted image 20251115163241.png]]
Pruning the trees in a decision tree can lead to instability and high variance, bagging and pasting is used to solve that

Bagging: 
- When selecting samples for each training subset, the algorithm can select the **same sample more than once**.
- Each subset is a _bootstrap_ sample.
![[Pasted image 20251115163521.png]]


Pasting: 
- Each training subset is made by selecting observations **once**, so no repetition.
![[Pasted image 20251115163552.png]]




![[Pasted image 20251115164546.png]]
![[Pasted image 20251115164555.png]]
![[Pasted image 20251115164611.png]]
![[Pasted image 20251115164617.png]]


Just side node: Random Forest is just Decision Trees with Bagging and/or pasting with random subset method (learn later)


We sometimes use severla decision trees to solve a problem rather than just one large one 
as the large one will have overfitting (while trying to fit several constriants)
but several smaller ones will each learn a slightly different decision boundary (thus reducing overfitting)



# Boosting
![[Pasted image 20251115164025.png]]
Basically help the next model's training by learning from the mistakes of the previous model's training to save time and computation

![[Pasted image 20251115164706.png]]

![[Pasted image 20251115164107.png]]


![[Pasted image 20251115164431.png]]
(LEARN LATER HOW IT THE NEXT MODEL LEARNS)



# Stacking
![[Pasted image 20251115165040.png]]
![[Pasted image 20251115165048.png]]
![[Pasted image 20251115165054.png]]
![[Pasted image 20251115165100.png]]
![[Pasted image 20251115165106.png]]

Three ways to ensemble modes:
Bagging uses a power way
Boosting uses a sequential way
Stacking uses a hierarchical way



# Last way
![[Pasted image 20251115165248.png]]
![[Pasted image 20251115165327.png]]
![[Pasted image 20251115165333.png]]
![[Pasted image 20251115165341.png]]

