//
//  PushAnimator.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 02. 08..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)
class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let to = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.addSubview(to.view)
        to.view.alpha = 0

        UIView.animate(withDuration: 1.0, animations: {
            to.view.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
#endif
