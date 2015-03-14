//
//Copyright (c) 2015 Daniele Spagnolo
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

class SOXInteractiveBoundedImageView: SOXPanRotateZoomImageView {
    
    var containerView: UIView?
    var gesture: UIPanGestureRecognizer!
    var myFrame = CGRectZero
    
    override func didMoveToSuperview() {
        if let superview = self.superview {
            containerView = superview
        }
    }
    
    override func handlePan(gesture: UIPanGestureRecognizer) {
        self.gesture = gesture
        
        if (containerView != nil) {
            setInitialTranslation()
            isFullyInsideContainer() ? setFrameInside() : checkBounds()
            resetTranslationToZero()
        }
    }
    
    // MARK: Hanlde Movement
    
    func setInitialTranslation() {
        let translation = gesture.translationInView(containerView!)
        myFrame = self.frame
        myFrame.origin.x += translation.x;
        myFrame.origin.y += translation.y;
    }
    
    // MARK: Check position
    
    func isFullyInsideContainer() -> Bool {
        return CGRectContainsRect(self.containerView!.bounds, myFrame)
    }
    
    func setFrameInside() {
        self.frame = myFrame;
    }
    
    // MARK: Check bounds
    
    func checkBounds() {
        checkVerticalBounds()
        checkHorizontalBounds()
    }
    
    // MARK: Vertical Bounds
    
    func checkVerticalBounds() {
        if (isGoingOutsideFromTop()) {
            constrainVerticallyFromTop()
        }
        else if (isGoingOutsideFromBottom()) {
            constrainVerticallyFromBottom()
        }
    }
    
    func isGoingOutsideFromTop() -> Bool {
        return myFrame.origin.y < self.containerView!.bounds.origin.y
    }
    
    func isGoingOutsideFromBottom() -> Bool {
        return myFrame.origin.y + myFrame.size.height > self.containerView!.bounds.size.height
    }
    
    func constrainVerticallyFromTop() {
        myFrame.origin.y = 0;
    }
    
    func constrainVerticallyFromBottom() {
        myFrame.origin.y = self.containerView!.bounds.size.height - myFrame.size.height;
    }
    
    // MARK: Horizontal Bounds
    
    func checkHorizontalBounds() {
        if (isGoingOutsideFromLeft()) {
            constrainHorizontallyFromLeft()
        }
        else if (isGoingOutsideFromRight()) {
            constrainHorizontallyFromRight()
        }
    }
    
    func isGoingOutsideFromLeft() -> Bool {
        return myFrame.origin.x < self.containerView!.bounds.origin.x
    }
    
    func isGoingOutsideFromRight() -> Bool {
        return myFrame.origin.x + myFrame.size.width > self.containerView!.bounds.size.width
    }
    
    func constrainHorizontallyFromLeft() {
        myFrame.origin.x = 0;
    }

    func constrainHorizontallyFromRight() {
        myFrame.origin.x = self.containerView!.bounds.size.width - myFrame.size.width;
    }

    // MARK: Reset
    
    func resetTranslationToZero() {
        gesture.setTranslation(CGPointMake(0, 0), inView: self.containerView!)
    }

}
