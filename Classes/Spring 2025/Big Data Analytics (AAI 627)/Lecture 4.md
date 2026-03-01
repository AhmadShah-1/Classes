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

![[Pasted image 20260227221517.png]]
The Yule Walker equations help in estimating the a1 to ap that we need for AR(p)

![[Pasted image 20260227222106.png]]
For time series, you move it back day by day (if by 1 day) and calculate the cross product of overlapping days

this is what is meant by Xt then Xt-1 etc


![[Pasted image 20260227222243.png]]
The left hand side is the autocorrelation between X_t and its past values at lags 1 through p (How strongly today is correalted with yesterday; with two days ago; up to p days ago)

The large matrix in the right hand side is the correlation structure among the lagged predictions X_t-1, X_t-2, ..., X_t-p
![[Pasted image 20260227222554.png]]

The Px1 matrix on the right hand side are the AR coefficients we want to solve for

To solve for the coefficients, just inverse the large matrix and solve (as shown in the image)


![[Pasted image 20260227222732.png]]
How would you use this info:
1. Use ACF to tell you the kind of model you're dealing with (AR, MA, ARMA other kinds of models)
2. Use PACF to get the p value (if its AR)
3. Use Yule-Walker to get the a1 to ap values
ACF -> PACF -> AR(p)




## New Concept

![[Pasted image 20260228191128.png]]
The equation in red is just the AR(p) model, and look at the right graph
When the PACF has a sudden drop then we know AR(p) is applicable, however when you see a gradual decline, AR(p) isn't fit, so MA (Moving Average) works here


In the MA(q) equation we aren't using past values of X, instead we use the Past Shocks (Errors).
X_t: Observed value at time t (same as AR)
c   : A constant (mean level)
e_t: White noise (shock, innovation)
b1, ..., bq: weights on past shocks 



A stationary AR(1) can be rewritten as an infinite MA process (Had GPT organize Professor notes)
![[Pasted image 20260228192318.png]]
![[Pasted image 20260228192405.png]]
![[Pasted image 20260228192446.png]]

![[Pasted image 20260228192509.png]]
![[Pasted image 20260228192514.png]]


Shock is just unexpected noise
![[Pasted image 20260228192646.png]]
![[Pasted image 20260228192654.png]]
![[Pasted image 20260228192706.png]]
![[Pasted image 20260228192722.png]]
![[Pasted image 20260228192743.png]]

AR(p) = MA(infinity)
MA(q) = AR(infinity)

AR(p) = MA(infinity) means that if today depends on p days before, then today depends on all the infinite history noise summed together

MA(q) = AR(infinity) means that if today depends on the past q noise, then today depends on all the history observations


![[Pasted image 20260228193546.png]]
Sometimes the data might rely on AR and MA, so use ARMA (both)

 If you have:
 q = 0 
 then
 its AR(p)

If you have:
p = 0
then
its MA(q)


