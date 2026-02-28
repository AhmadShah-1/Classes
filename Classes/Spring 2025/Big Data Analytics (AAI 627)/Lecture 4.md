![[Pasted image 20260227212833.png]]
We need to make sure that to apply AR(1) the data has to be stationary, in the case of stock prices (X_t), it keeps going up or continously down, so that is not stationary

so what do you do, try figuring out some quality of the data that is stationary
so turn X_t --> Y_t   

and if Y_t is not stationary, derive it further until you get something close to stationary

for stocks maybe instead of price, look at price difference, or return value


#Auto-correlation-Function
#Auto-Regressive

![[Pasted image 20260222063449.png]]

![[Pasted image 20260222070305.png]]

![[Pasted image 20260222070914.png]]
the value of r_1 is between -1 to 1, with 1 meaning perfectly positively correlated, and -1 meaning perfectly negatively correlated, and 0 means there is no correlation

![[Pasted image 20260227214418.png]]
For ACF, when we say how does X(t) (today) compare to X(t), it has a value of 1, meaning high correlation (obviosuly)

Now if we say how does X(t) (today) compare to X(t-2) (two days ago (initial)) then the value of correlation is smaller, and so on and so forth, as shown in the graph, the correlation with the start day becomes less and less

![[Pasted image 20260227214725.png]]

![[Pasted image 20260227214813.png]]

![[Pasted image 20260227215343.png]]
the second subscript when it says (a_0, 1) The 1 is the AR(1) and then AR(2) and so on, its just to differentiate it

So to find the AR(p) of a model, you guess and test different AR models.
When you are testing a AR(p) model, look at the highest order coefficient (for the first its a_1,1 for the second its a_2,2 etc) and if the value is close to 0, you know that you overestimated, and that you should go back

![[Pasted image 20260227215636.png]]

![[Pasted image 20260227220506.png]]
The graph shows that the model does not depend on 3 days before, it depends on 1 and 2 days before


![[Pasted image 20260227220627.png]]

![[Pasted image 20260227220846.png]]
For a 5% significance level (2.5% on each side), if the value of the PACF drops to be within 2.5% of 0 in either direction, then it is evaluated as being 0 (so we take p to be the previous number)
Of course, the number of data points you have also plays a role too, but thats the rule of thumb usually