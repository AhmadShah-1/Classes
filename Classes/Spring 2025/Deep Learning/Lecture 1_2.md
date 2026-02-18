

![[Pasted image 20260206131437.png]]

Deep:
Linear Transform, Non-linear activation


![[Pasted image 20260206140858.png]]
Steps to map image to two outputs:
1. Take a 10 x 10 pixel image
2. Make it into a 100 x 1 matrix
3. multiply 100x100 with 100x1 to make a 100x1 matrix
4. throw away the bottom 50 of the 100x1 matrix   (Because we are trying to make sure the top 50 are large values and the bottom values are close to 0, and as they are close to 0, we can throw them away and equate them to be 0)

To better understand the above, lets use the example of an iphone
imagine you have a phone on an angle on a table, it has three dimensions (x, y, z) in the 3D cooridnate plan (how it is oriented in space)
if we then apply a rotation to it so that its flat against the z axis (the phone is looking straight at us) then the z coordinate is useless to us as we are looking at the 2 dimensions

so we are effectively throwing away the z coordinates, and we turned a 3D reference into a 2D one 

We are always trying to rotate our data in some way, that a portion of our data goes to 0 (3D object becomes 2D, we are reducing dimensions), we are trying to change a high dimensional input to a lower dimension output

#nonlinear-transform 
Example of a 256x1 image to a 10 output result
![[Pasted image 20260206141447.png]]
why are we trying to keep reducing and throwing away information as we go down
this is because high-dimensional representations have a lot of redundant information



![[Pasted image 20260206142619.png]]
v(t+1) = $v(t)_{1}$ * w1 + $v(t)_2$ * w2 + ...



![[Pasted image 20260206183929.png]]

![[Pasted image 20260206184118.png]]
Here b is a shift applied on the neuron
The example of turning the X values to equate to 0, is RELU activation function (nonlinear)
The nonlinear function RELU is just one example, you can make anything you want, as long as it results in a nonlienar transform
(Obviously have some reason for what nonlinear transform you use, we need to be able to change the geometry)

When creating Linear Models, they are very simple but also very limited, you must be able to find the correct transforms and shifts to reach an answer 
Nonlinear models help solve this by changing the geometry and focusing on the needed parts


![[Pasted image 20260206184530.png]]



![[Pasted image 20260206184552.png]]
Sometimes the output might be high or very low, its a range, which isn't good for situations like classifcation where you need discrete outputs

So we use softmax, to normalize the range to be between 0-1, which we then use as likelihood or probability


![[Pasted image 20260206185014.png]]
![[Pasted image 20260206185033.png]]
![[Pasted image 20260206185359.png]]
![[Pasted image 20260206185528.png]]

![[Pasted image 20260206185635.png]]
Deeper is better  


![[Pasted image 20260206185854.png]]
![[Pasted image 20260206190413.png]]
![[Pasted image 20260206190424.png]]

![[Pasted image 20260206190454.png]]

![[Pasted image 20260206190541.png]]

   