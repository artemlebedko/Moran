// The MIT License (MIT)
//
// Copyright (c) 2019. Artem Lebedko <artemlebedko@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

open class Moran: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    open weak var animatedView: UIView?
    open var startFrame = CGRect()
    open var startBackgroundColor: UIColor?
    open var isReverse = false
    open var transitionDuration : TimeInterval = 0.3
    open var cornderRadius: CGFloat = 20.0
    open var presenting = true
    
    convenience public init(animatedView: UIView, transitionDuration: TimeInterval = 0.3) {
        self.init()
        self.animatedView = animatedView
        self.transitionDuration = transitionDuration
    }
    
    //MARK - UIViewControllerAnimatedTransitioning
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let animatedView = animatedView, let superview = animatedView.superview {
            
            // Get the frame rect in the screen coordinates
            self.startFrame = superview.convert(animatedView.frame, to: nil)
            self.startBackgroundColor = animatedView.backgroundColor
        }
        
        // Use if the transitionContext.containerView is not fullscreen
        let startFrame = transitionContext.containerView.superview?.convert(self.startFrame, to: transitionContext.containerView) ?? self.startFrame
        
        let animatedViewForTransition = UIView(frame: startFrame)
        transitionContext.containerView.addSubview(animatedViewForTransition)
        
        animatedViewForTransition.clipsToBounds = true
        animatedViewForTransition.layer.cornerRadius = cornderRadius
        animatedViewForTransition.backgroundColor = self.startBackgroundColor
        
        
        let presentedController: UIViewController
        
        if !self.isReverse {
            presentedController = transitionContext.viewController(forKey: .to)!
            presentedController.view.layer.opacity = 0.0
        }
        else {
            presentedController = transitionContext.viewController(forKey: .from)!
        }
        
        presentedController.view.frame = transitionContext.containerView.bounds
        transitionContext.containerView.addSubview(presentedController.view)
        
        //MARK - Scale transform for animated view
        let size = max(transitionContext.containerView.frame.height, transitionContext.containerView.frame.width) * 1.2
        let scaleFactor = size / animatedViewForTransition.frame.width
        let finalTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        
        //MARK - Scale transform for presented view
        let xScaleFactor    = startFrame.width / transitionContext.containerView.frame.width
        let yScaleFactor    = startFrame.height / transitionContext.containerView.frame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            presentedController.view.transform = scaleTransform
            presentedController.view.center = CGPoint(
                x: startFrame.midX,
                y: startFrame.midY)
            presentedController.view.clipsToBounds = true
        }
        
        if !self.isReverse {
            UIView.transition(with: animatedViewForTransition,
                              duration: self.transitionDuration(using: transitionContext) * 0.7,
                              options: [],
                              animations: {
                                
                                //MARK: - Presenting block animation
                                animatedViewForTransition.transform = finalTransform
                                animatedViewForTransition.center = transitionContext.containerView.center
                                animatedViewForTransition.backgroundColor = presentedController.view.backgroundColor
                                
                                presentedController.view.layer.opacity = 1.0
                                presentedController.view.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                                presentedController.view.center = CGPoint(x: transitionContext.containerView.frame.midX, y: transitionContext.containerView.frame.midY)
            },
                              completion: { (_) in
                                animatedViewForTransition.removeFromSuperview()
                                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                                self.presenting = false
            })
        } else {
            
            //MARK: - Dismiss block animation
            animatedViewForTransition.transform = finalTransform
            animatedViewForTransition.center = transitionContext.containerView.center
            
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext) * 0.7, animations: {
                presentedController.view.layer.opacity = 0
                animatedViewForTransition.backgroundColor = presentedController.view.backgroundColor
                
            })
            
            //DispatchQueue.main.asyncAfter(deadline: .now() + self.transitionDuration(using: transitionContext) * 0.32) {
            UIView.transition(with: animatedViewForTransition,
                              duration: self.transitionDuration(using: transitionContext) * 0.58,
                              options: [],
                              animations: {
                                presentedController.view.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                                presentedController.view.layer.cornerRadius = self.cornderRadius
                                presentedController.view.frame = startFrame
                                animatedViewForTransition.transform = CGAffineTransform.identity
                                animatedViewForTransition.backgroundColor = self.startBackgroundColor
                                animatedViewForTransition.frame = startFrame
            },
                              completion: { (_) in
                                animatedViewForTransition.removeFromSuperview()
                                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                                self.presenting = true
            })
            //}
        }
    }
    
    // MARK - UIViewControllerTransitioningDelegate
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isReverse = false
        return self
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isReverse = true
        return self
    }
    
}



