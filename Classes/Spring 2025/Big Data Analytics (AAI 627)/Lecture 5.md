
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
First lets look at the expected properties of AR(1) and MA(1)
For AR(1):
- ACF shows the correlation between todays value and the previous days values
- PACF 