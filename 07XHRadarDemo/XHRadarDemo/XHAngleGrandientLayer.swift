//
//  XHAngleGrandientLayer.swift
//  XHAngleGradientLayer
//
//  Created by Henry Huang on 2/26/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

class XHAngleGrandientLayer: CALayer {

    private let MaxAngle = 2 * M_PI
    private let MaxHue = 255.0
    
    private struct Transition {
        let fromLocation: Double
        let toLocation: Double
        let fromColor: UIColor
        let toColor: UIColor
        
        func colorForPercent(percent: Double) -> UIColor {
            let normalizedPercent = percent.convertFrom(currentRangeMin: fromLocation, currentRangeMax: toLocation, toRangeMin: 0.0, rangeMax: 1.0)
            return UIColor.lerpColor(from: fromColor.rgba, to: toColor.rgba, atPercent: CGFloat(normalizedPercent))
        }
    }
    
// MARK: - Properties
    // The array of UIColor objects defining the color of each gradient stop.
    // Defaults to empty array. 
    // Animatable.
    internal var colors = [UIColor]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // The array of Double values defining the location of each
    // gradient stop as a value in the range [0,1]. 
    // The values must be monotonically increasing. 
    // If empty array is given, the stops are
    // assumed to spread uniformly across the [0,1] range.
    // Defaults to nil. 
    // Animatable.
    internal var locations = [Double]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var transitions = [Transition]()
    
    internal override func drawInContext(ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        drawRect(CGContextGetClipBoundingBox(ctx))
        UIGraphicsPopContext()
    }
    
    private func drawRect(rect: CGRect) {
        loadTransitions()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let longerSide = max(rect.width, rect.height)
        let radius = Double(longerSide) * M_SQRT2
        // let radius = Double(sqrt(rect.width * rect.width + rect.height * rect.height))
        var angle = 0.0
        let step = M_PI_2 / radius

        while angle <= MaxAngle {
            let pointX = radius * cos(angle) + Double(center.x)
            let pointY = radius * sin(angle) + Double(center.y)
            let startPoint = CGPoint(x: pointX, y: pointY)
            
            let line = UIBezierPath()
            line.moveToPoint(startPoint)
            line.addLineToPoint(center)
            
            colorAtAngle(angle).setStroke()
            line.stroke()
            
            angle += step
            
        }
    }
    
    private func colorAtAngle(angle: Double) -> UIColor {
        let percent = angle.convertFrom(currentRangeMin: 0, currentRangeMax: MaxAngle, toRangeMin: 0.0, rangeMax: 1.0)
        guard let transition = transitionForPercent(percent) else {
            return spectrumColorForAngle(angle)
        }
        return transition.colorForPercent(percent)
    }
    
    private func transitionForPercent(percent: Double) -> Transition? {
        let filteredTransition = transitions.filter { (transition: Transition) -> Bool in
            percent >= transition.fromLocation && percent < transition.toLocation
        }
        let defaultTransition = percent <= 0.5 ? transitions.first : transitions.last
        return filteredTransition.first ?? defaultTransition
    }
    
    private func spectrumColorForAngle(angle: Double) -> UIColor {
        let hue = angle.convertFrom(currentRangeMin: 0, currentRangeMax: MaxAngle, toRangeMin: 0.0, rangeMax: MaxHue)
        return UIColor(hue: CGFloat(hue / MaxHue), saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    
    private func loadTransitions() {
        transitions.removeAll()
        
        if colors.count > 1 {
            let transitionsCount = colors.count - 1
            let locationStep = 1.0 / Double(transitionsCount)
            
            for i in 0 ..< transitionsCount {
                let fromLocation, toLocation: Double
                let fromColor, toColor: UIColor
                
                if locations.count == colors.count {
                    fromLocation = locations[i]
                    toLocation = locations[i + 1]
                } else {
                    fromLocation = locationStep * Double(i)
                    toLocation = locationStep * Double(i + 1)
                }
                
                fromColor = colors[i]
                toColor = colors[i+1]
                
                let transition = Transition(fromLocation: fromLocation, toLocation: toLocation, fromColor: fromColor, toColor: toColor)
                transitions.append(transition)
            }
        }
    }
}

// MARK: - Extensions

private extension Double {
    
    func convertFrom(currentRangeMin oldMin: Double, currentRangeMax oldMax: Double, toRangeMin newMin: Double, rangeMax newMax: Double) -> Double {
        let oldRange, newRange, newValue: Double
        oldRange = oldMax - oldMin
        if oldRange == 0.0 {
            newValue = newMin
        } else {
            newRange = newMax - newMin
            newValue = (self - oldMin) * (newRange / oldRange) + newMin
        }
        return newValue
    }
}

private extension UIColor {
    
    struct RGBA {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        init(color: UIColor) {
            color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
    }
    
    var rgba: RGBA {
        return RGBA(color: self)
    }
    
    class  func lerpColor(from fromColor: UIColor.RGBA, to toColor: UIColor.RGBA, atPercent percent: CGFloat) -> UIColor {
        let red = fromColor.red + (toColor.red - fromColor.red) * percent
        let green = fromColor.green + (toColor.green - fromColor.green) * percent
        let blue = fromColor.blue + (toColor.blue - fromColor.blue) * percent
        let alpha = fromColor.alpha + (toColor.alpha - fromColor.alpha) * percent
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}