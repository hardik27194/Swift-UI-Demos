//
//  ViewController.swift
//  XHRadarDemo
//
//  Created by Henry Huang on 2/28/16.
//  Copyright © 2016 XiaoHuang. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    let shadowView = UIView()
    var angelGradientView: XHAngleGradientView!
    var avatarView: UIImageView!
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // location manager setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // shadow view setup
        let radius = (view.frame.width - 70) / 2
        let frame = CGRectMake(35, view.frame.height/2 - radius - 100 , radius * 2, radius * 2)
        shadowView.frame = frame
        shadowView.layer.shadowColor = UIColor.blackColor().CGColor
        shadowView.layer.shadowOffset = CGSizeZero
        shadowView.layer.shadowRadius = 3.0
        shadowView.layer.shadowOpacity = 0.6
        
        // map view setup
        mapView.frame = CGRectMake(0, 0, radius*2, radius*2)
        mapView.delegate = self
        mapView.userInteractionEnabled = false
        mapView.zoomEnabled = false
        mapView.layer.cornerRadius = radius
        mapView.clipsToBounds = true
        shadowView.addSubview(mapView)
        view.addSubview(shadowView)
        
        // angel gradient view setup (radar view)
        let color0 = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        let color1 = UIColor(red: 106.0/255.0, green: 213.0/255.0, blue: 103.0/255.0, alpha: 1.0)
        let colors = [color0, color0, color0, color1]
        let locations: [Double] = []
        angelGradientView = XHAngleGradientView(frame: frame, withColors: colors, withLocations: locations, shape: XHAngleGradientView.Shape.Oval)
        angelGradientView.alpha = 0.8
        view.addSubview(angelGradientView)
        
        // avatar view
        let avatarRadius = radius / 3
        avatarView = UIImageView(frame: CGRectMake(angelGradientView.center.x - avatarRadius, angelGradientView.center.y - avatarRadius, avatarRadius * 2, avatarRadius * 2))
        avatarView.image = UIImage(named: "avatar.png")
        avatarView.layer.borderColor = UIColor.whiteColor().CGColor
        avatarView.layer.borderWidth = 3.0
        avatarView.layer.cornerRadius = avatarRadius
        avatarView.clipsToBounds = true
        view.addSubview(avatarView)
             
        // add tap gesture to avartar
        let tapGesture = UITapGestureRecognizer(target: self, action: "ripple:")
        avatarView.userInteractionEnabled = true
        avatarView.addGestureRecognizer(tapGesture)
        
        // animation
        spinRadar()
        NSTimer.scheduledTimerWithTimeInterval(1.8, target: self, selector: "ripple:", userInfo: nil, repeats: true)
        
        // button setup
        label = UILabel(frame: CGRectMake(view.center.x - 75, mapView.center.y + mapView.frame.height, 150, 75))
        let font = UIFont(name: "HelveticaNeue-Thin", size: 30.0)
        label.textAlignment = .Center
        label.font = font
        label.text = "Locating..."
        view.addSubview(label)
    }
    
// MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        let geo = CLGeocoder()
        geo.reverseGeocodeLocation(location!) { (placeMark, error) -> Void in
            guard let placeMark = placeMark?.first else {
                print("Could not locate")
                return
            }
            let city = placeMark.locality
            self.label.text = city
        }
        
        mapView.setRegion(region, animated: false)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

// MARK: Animations
    func spinRadar() {
        let spin = CABasicAnimation(keyPath: "transform.rotation")
        spin.duration = 2.0
        spin.toValue = NSNumber(double: M_PI)
        spin.cumulative = true
        spin.removedOnCompletion = false
        spin.repeatCount = Float.infinity
        angelGradientView.layer.addAnimation(spin, forKey: "spin")
    }
    
    func ripple(sender: AnyObject) {
        // frame setup
        let rippleLayer = CAShapeLayer()
        let frame = CGRectMake(-CGRectGetMidX(avatarView.bounds), -CGRectGetMidY(avatarView.bounds), avatarView.bounds.size.width, avatarView.bounds.size.height)
        rippleLayer.path = UIBezierPath(ovalInRect: frame).CGPath
        rippleLayer.position = view.convertPoint(mapView.center, fromView: nil)
        rippleLayer.lineWidth = 1.5
        rippleLayer.strokeColor = UIColor(red: 87.0/255.0, green: 175.0/255.0, blue: 50.0/255.0, alpha: 1.0).CGColor
        rippleLayer.fillColor = UIColor.clearColor().CGColor
        mapView.layer.addSublayer(rippleLayer)
        
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            rippleLayer.removeFromSuperlayer()
        }
        
        // animation setup
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        scaleAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(3.5, 3.5, 1))
        
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 1.0
        alphaAnimation.toValue = 0.0
        
        let animations = CAAnimationGroup()
        animations.animations = [scaleAnimation, alphaAnimation]
        animations.duration = 1.0
        animations.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        rippleLayer.addAnimation(animations, forKey: nil)
        
        CATransaction.commit()
    }

}

