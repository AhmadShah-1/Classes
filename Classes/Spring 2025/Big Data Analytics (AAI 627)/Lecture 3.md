
To find if say two things are correlated and how correlated they are:
![[Pasted image 20260206153130.png]]

Cov() [covariance] tells the direction of correlation (if x mean rises y mean dips vice versa) but it gives it in units
correlation coefficient gives it in terms of magnitude

having the magnitude not the actual units helps in applying it to several different datasets



![[Pasted image 20260206155256.png]]
Staitonarity makes sense for things that change by week
does not make sense for stock prices that are consistently changing

If you take the mean of one time series (7 days) and compare it to the mean of another time series, you can say that the means will be the same (thats the last bulletpoint)




![[Pasted image 20260206161359.png]]
For correlations that are likely to occur but at uncertain intervals (stock prices) use auto-correlation
for example, can I use the price of a stock from yesterday to help predict todays price
![[Pasted image 20260206161725.png]]
Correlation helped correlate different things to one another
auto-correlation helps correlate given things and history of past data
![[Pasted image 20260206161842.png]]




![[Pasted image 20260206162111.png]]
The formula:
explains how to predict today given the history (Xt1 etc) and if its off apply coefficients to balance a0 etc, and et is called the residual (noise/unexplained) 
think in terms of stocks



![[Pasted image 20260206162521.png]]


![[Pasted image 20260206162914.png]]

![[Pasted image 20260206163024.png]]

![[Pasted image 20260206163045.png]]

![[Pasted image 20260206163236.png]]

