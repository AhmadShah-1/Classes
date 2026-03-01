
![[Pasted image 20260228201555.png]]
To know how good your ARIMA model is, use AIC to evaluate it

The goal of the model is to fit all the data, excluding the noise
So after fitting ARIMA, the only thing left should be pure randomness
Data = Signal + Noise   (The leftover (resididuals) should look like noise)

Check the residual errors from the fitted model with ACF and PACF. This is because the residuals should behave like white noise, meaning:
- Mean is around 0
- Constant Variance
- No autocorrelation

So if you plot:
- ACF of residuals
- PACF of residuals
If you see spikes, then the model missed some structure
If residual ACF is flat -> good

![[Pasted image 20260228202008.png]]
![[Pasted image 20260228202025.png]]


![[Pasted image 20260228210328.png]]
Say you have two models, and are not sure which is better
compare the residuals (e_t)
the one that closely models the actual noise is the better model

![[Pasted image 20260228210836.png]]
![[Pasted image 20260228210951.png]]


![[Pasted image 20260228211242.png]]
Mean is 0, so it is stationary
However the values fluctuate greatly, so the variance is high
However realistically, the variance isn't that bad, say you took several sections of the data to look at, 50-100 and 150-200 and 250-300 they all follow the same kind of structure

![[Pasted image 20260228211527.png]]
This is the ACF and PACF of the previous graph
In the ACF Graph:
So in the first one at lag 0 (today) it has a high correlation with today (obviously)
then if you compare today with yesterday (where it says -0.4) you see some negative correlation

The other values that fall within the blue dashes, are statically insignificant relation and are considered 0

So after 2 days, there is not correlation

In the PACF Graph:
The points where the points fall are the coefficient values.
So 
if its AR(1) then the a<sub>1, 1</sub> coefficient is -0.42
If its AR(2) then the a<sub>2, 2</sub> coefficient is -0.4
etc

## Is this Data AR or MA model?
![[Pasted image 20260228212612.png]]
First lets look at the expected properties of AR(1) and MA(1) based on the ACF and PACF values we have

For AR(1):
- ACF shows the correlation between todays value and the previous days values (correlation so a gradual decline)
- PACF shows how many days of previous data actually correlate to today (the kind of AR(p) model, thus provides p)

For MA(1):
- ACF here still shows the correlation between todays values with the previous days values but with a focus on the noise from those days, basically we are saying today's noise depends on yesterday's noise [but noise has no correlation] so at t=1 (today) we will have some value for ACF, but then subsequent days is a large drop (no correlation so a drop)
- PACF shows the relation of the overlapping noise (shocks), if today depends on the shock of yesterday, does the noise from the day before yesterday help contribute any information on today, and as you progress you see a gradual decay

When I said "basically we are saying today's noise depends on yesterday's noise", this is an incorrect statement, conceptually we are saying correlation but not in this way 
![[Pasted image 20260228214837.png]]



Refresher for why:
AR(1) = MA(infinity) also the reverse is applicable
![[Pasted image 20260228213718.png]]


So to the question:
Is this Data AR or MA model?
Its a MA model
and looking at the values for the ACF, we note 0, 1, 2 as being non-zero, so we this is a MA(2) model



![[Pasted image 20260228215555.png]]
For this stock data we need to use ARIMA, as by taking the mean of window selections, they are obviously different

![[Pasted image 20260228215619.png]]
When using the first order difference for ARIMA, the mean of the data seems okay, however the variance is high, and it happens often and at random points
this is time invariant volatility

say we perform ACF and MA on this so we assumed ARIMA(3, 1, 2) [AR(3), I(1), MA(2)]
![[Pasted image 20260228220044.png]]
When looking at ACF, today (day 0 or lag 0) has correlation with itself, but none of the previous days has any correlation, this is descriptive of noise 

 When looking at PACF, we note that there is some data, where at 30 lag we see some information, so its not a terrible model, but it certainly isn't great

You can try to tune the model by further changing our original ARIMA values


## Next Topic Recommender

![[Pasted image 20260228220542.png]]
In the reranking step, we ensure we are taking into consideration other factors, we are not too strict and show slightly irrelevant items
Say a user searches for swimming,
you would want a majority of the content to be what the user is looking for
but you also show other topics such as hiking and kayaking to possibly generate new interest for the user

![[Pasted image 20260228221215.png]]
 