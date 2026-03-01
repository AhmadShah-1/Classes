
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

