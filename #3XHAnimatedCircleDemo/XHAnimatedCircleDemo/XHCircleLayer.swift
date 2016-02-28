//
//  XHCircleLayer.swift
//  XHAnimatedCircleDemo
//
//  Created by Henry Huang on 2/18/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit

enum MovingPoint {
    case POINT_B
    case POINT_D
}

let outsideRectWidth: CGFloat = 90

class XHCircleLayer: CALayer {
    
    var progress: CGFloat = 0.0 {
        didSet {
            if progress <= 0.5 {
                movePoint = .POINT_B
                print("POINT_B is moving")
            } else {
                movePoint = .POINT_D
                print("POINT_D is moving")
            }
            
            self.lastProgress = progress
            let offset = (progress - 0.5) * (frame.size.width - outsideRectWidth)
            let origin_x = position.x - outsideRectWidth/2 + offset
            let origin_y = position.y - outsideRectWidth/2
            
            outsideRect = CGRectMake(origin_x, origin_y, outsideRectWidth, outsideRectWidth)
            setNeedsDisplay()
        }
    }
    
    private var outsideRect: CGRect!
    private var lastProgress: CGFloat = 0.5
    private var movePoint: MovingPoint!
    
    override init() {
        super.init()
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? XHCircleLayer {
            progress = layer.progress
            outsideRect = layer.outsideRect
            lastProgress = layer.lastProgress
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        let offset = outsideRect.size.width / 3.6
        let movedDistance = (outsideRect.size.width * 1/6) * fabs(progress - 0.5) * 2
        
        let outsideRectCenter = CGPointMake(outsideRect.origin.x + outsideRect.size.width/2, outsideRect.origin.y + outsideRect.size.height/2)
        
        let pointA = CGPointMake(outsideRectCenter.x, outsideRect.origin.y + movedDistance)
        let pointB = CGPointMake(movePoint == .POINT_D ? outsideRectCenter.x + outsideRect.size.width/2 : outsideRectCenter.x + outsideRect.size.width/2 + movedDistance * 2, outsideRectCenter.y)
        let pointC = CGPointMake(outsideRectCenter.x, outsideRectCenter.y + outsideRect.size.height/2 - movedDistance)
        let pointD = CGPointMake(movePoint == .POINT_D ? outsideRect.origin.x - movedDistance * 2 : outsideRect.origin.x, outsideRectCenter.y)
        
        let c1 = CGPointMake(pointA.x + offset, pointA.y)
        let c2 = CGPointMake(pointB.x, movePoint == .POINT_D ? pointB.y - offset : pointB.y - offset + movedDistance)
        
        let c3 = CGPointMake(pointB.x, movePoint == .POINT_D ? pointB.y + offset : pointB.y + offset - movedDistance)
        let c4 = CGPointMake(pointC.x + offset, pointC.y)
        
        let c5 = CGPointMake(pointC.x - offset, pointC.y)
        let c6 = CGPointMake(pointD.x, movePoint == .POINT_D ? pointD.y + offset - movedDistance : pointD.y + offset)
        
        let c7 = CGPointMake(pointD.x, movePoint == .POINT_D ? pointD.y - offset + movedDistance : pointD.y - offset)
        let c8 = CGPointMake(pointA.x - offset, pointA.y)
        
        // outside rect dash
        let rectPath = UIBezierPath(rect: outsideRect)
        CGContextAddPath(ctx, rectPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(ctx, 1.0)
        let dash = [CGFloat(5.0), CGFloat(5.0)]
        CGContextSetLineDash(ctx, 0.0, dash, 2)
        CGContextStrokePath(ctx)
        
        // circle
        let ovalPath = UIBezierPath()
        ovalPath.moveToPoint(pointA)
        ovalPath.addCurveToPoint(pointB, controlPoint1: c1, controlPoint2: c2)
        ovalPath.addCurveToPoint(pointC, controlPoint1: c3, controlPoint2: c4)
        ovalPath.addCurveToPoint(pointD, controlPoint1: c5, controlPoint2: c6)
        ovalPath.addCurveToPoint(pointA, controlPoint1: c7, controlPoint2: c8)
        ovalPath.closePath()
        
        CGContextAddPath(ctx, ovalPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(ctx, UIColor(red: 51.0/255.0, green: 163.0/255.0, blue: 236.0/255.0, alpha: 1.0).CGColor)
        CGContextSetLineDash(ctx, 0, nil, 0)
        CGContextDrawPath(ctx, .FillStroke)
        
        // outline every point
        CGContextSetFillColorWithColor(ctx, UIColor.yellowColor().CGColor)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        let points = [pointA, pointB, pointC, pointD, c1, c2, c3, c4, c5, c6, c7, c8]
        drawPoint(points, ctx: ctx)
        
        
        // connect every point
        let helperline = UIBezierPath()
        helperline.moveToPoint(pointA)
        helperline.addLineToPoint(c1)
        helperline.addLineToPoint(c2)
        helperline.addLineToPoint(pointB)
        helperline.addLineToPoint(c3)
        helperline.addLineToPoint(c4)
        helperline.addLineToPoint(pointC)
        helperline.addLineToPoint(c5)
        helperline.addLineToPoint(c6)
        helperline.addLineToPoint(pointD)
        helperline.addLineToPoint(c7)
        helperline.addLineToPoint(c8)
        helperline.closePath()
        
        CGContextAddPath(ctx, helperline.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        let dash2 = [CGFloat(2.0), CGFloat(2.0)]
        CGContextSetLineDash(ctx, 0.0, dash2, 2)
        CGContextStrokePath(ctx)
        
    }
    
    private func drawPoint(points: [CGPoint], ctx: CGContextRef) {
        for point in points {
            CGContextFillRect(ctx, CGRectMake(point.x - 2, point.y - 2, 4, 4))
        }
    }
}