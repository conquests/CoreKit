//
//  PopAnimator.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2018. 02. 08..
//  Copyright © 2018. Tibor Bödecs. All rights reserved.
//

#if os(iOS)
open class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let from = transitionContext.viewController(forKey: .from),
            let to = transitionContext.viewController(forKey: .to)
        else {
            return
        }
        transitionContext.containerView.insertSubview(to.view, belowSubview: from.view)

        UIView.animate(withDuration: 1.0, animations: {
            from.view.alpha = 0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
#endif
