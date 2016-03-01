# ios Animation Demo
This is projects including all my iOS animation demos.

---
## \#7 XHRadarView
<img src='./07XHRadarDemo/demo/radar.png' height='80' width='80'></img>  
This is an animation demo to simulate the radar effect. When you launch the app, it will update your local address and start the radar effect animation. The fradient radar effect is based on the **[XHAngleGradientLayer](https://github.com/xhuang68/XHAngleGradientLayer)** (Swift) or **[AngleGradientLayer](https://github.com/paiv/AngleGradientLayer)** (Objective-C).  

![demo](./07XHRadarDemo/demo/demo.gif)  

###Find my iPhone icon
Also I drew the Apple's find my iPhone icon using Sketch. You can download the sketch file if you need.  

<a href='./07XHRadarDemo/demo/FindMyiphoneIcon'><img src='./07XHRadarDemo/demo/sketch.png' height='80'></img></a>  

---
## \#6 XHGradientLabelView 
<img src='./06XHGradientLabel/demo/gradient.png' height='80' width='80'></img>  
This is a custom **UIView** which supports the text gradient effect like this:  

![gradient demo](./06XHGradientLabel/demo/gradient.gif)  

###Usage
####Init

```swift
let gradientLabelView = XHGradientLabelView.init(frame: CGRect, withText text: String, andFont font: UIFont, withColors colors: [CGColor])
```
####Colors
You can choose any color you like to fill the text. Here are two color demos:  

![bw](./06XHGradientLabel/demo/bw.png)

![bw label](./06XHGradientLabel/demo/bw.gif)  

![color](./06XHGradientLabel/demo/color.png)

![color label](./06XHGradientLabel/demo/color.gif)  

####Installation
Copy **XHGradientLabelView.swift** to your project.

---
## \#5 XHCircleStrokeView
<img src='./05XHCircleStokeView/demo/circle.png' height='80' width='80'></img>  
This is a custon **UIview** which supports the circle stroke animation with a time label. 

###Demo
![circle](./05XHCircleStokeView/demo/circle.gif)

###Usage
####Init

```swift
let circleStrokeView = init(
	frame: CGRect, 
	withDuration duration: Double, 
	backColor: UIColor, 
	frontColor: UIColor, 
	fillColor: UIColor, 
	strokeWidth: CGFloat, 
	enableTimeLabel labelEnable: Bool, 
	enableGlow glowEnable: Bool)
view.addSubview(circleStrokeView)
```
Set up the view with above custom parameters. You also can enable or disable the time label and glow effect.  

####Font
You can update the time label font using  
```swift
circleStrokeView.timeLabel.font = UIFont(name: "HelveticaNeue", size: 80.0)
circleStrokeView.timeLabel.textColor = UIColor.whiteColor()
```

####Start countdown
```swift
circleStrokeView.play()
```

####Pause countdown
```swift
circleStrokeView.pause()
```

####Reset countdown
```swift
circleStrokeView.reset()
```

###Installation
Copy **XHCircleStroleView.swift** to your project.  

---
## \#4 Twitter Launch Screen Animation
<img src='./04TwitterLaunchScreen/demo/star.png' height='80' width='80'></img>  
This is a Demo to reproduce twitter's launch animation

###Demo
![twitter](./04TwitterLaunchScreen/demo/twitter.gif)

###Usage
Copy and modify the code in **AppDelegate.swift**.  
The animation is coded in side this method before the root controller is loaded:  
```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
	// animation code
	}
```
---
## \#3 XHAnimatedCircleDemo
<img src='./03XHAnimatedCircleDemo/demo/drag.png' height='80' width='80'></img>    
This is a demo to show the drag effect on the bubble view.  

*	The number below the view represents the draging progress.   
*	This circle layer consists of four seprate curves. And the yellow points in the view are the points to control these four curves.   
*	One of the use case of this effect could be the page control UI component. The bubble will be dragged and the shape will be changed between each page mark.

![drag demo](./03XHAnimatedCircleDemo/demo/drag.gif)

--- 
## \#2 Albums	
<img src='./02Albums/demo/album.png' height='80' width='80'></img>  
This is a demo with some cool animations using **Gestures** and **UIKit Dynamics** (*UIDynamicAnimator*, *UIAttachmentBehavior*, *UIGravityBehavior* and *UISnapBehavior*).		

![albums demo](./02Albums/demo/album.gif)   

---
## \#1 XHSlideMenuDemo	
<img src='./01XHSlideMenuDemo/demo/slide.png' height='80' width='80'></img>  
This is a custormize slide-out navigation panel.  			
![slide demo](./01XHSlideMenuDemo/demo/slide.gif)   