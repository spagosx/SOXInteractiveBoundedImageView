//
//Copyright (c) 2014 Daniele Spagnolo
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
//

import UIKit

class SOXPanRotateZoomImageView: UIImageView, UIGestureRecognizerDelegate {
 
    var previousLocation = CGPointZero
    
    override init(image: UIImage!) {
        super.init(image: image)
        self.initialSetup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }
    
    func initialSetup() {
        self.userInteractionEnabled = true
        
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: Selector("handleRotation:"))
        rotationRecognizer.delegate = self
        self.addGestureRecognizer(rotationRecognizer)
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        panRecognizer.delegate = self
        self.addGestureRecognizer(panRecognizer)
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("handlePinch:"))
        pinchRecognizer.delegate = self
        self.addGestureRecognizer(pinchRecognizer)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.superview?.bringSubviewToFront(self)
        previousLocation = self.center
    }
    
    func handleRotation(gesture: UIRotationGestureRecognizer) {
        gesture.view!.transform = CGAffineTransformRotate(gesture.view!.transform, gesture.rotation);
        gesture.rotation = 0;
    }
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translationInView(self.superview!)
        let newPosition = CGPointMake(previousLocation.x + translation.x, previousLocation.y + translation.y)
        self.center = newPosition
    }
    
    func handlePinch(gesture: UIPinchGestureRecognizer) {
        gesture.view!.transform = CGAffineTransformScale(gesture.view!.transform, gesture.scale, gesture.scale);
        gesture.scale = 1;
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
