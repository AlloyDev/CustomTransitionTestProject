//
//  CustomPresentAnimation.m
//  CustomTransitionTestProject
//
//  Created by Tsyganov Stanislav on 16.02.14.
//  Copyright (c) 2014 Tsyganov Stanislav. All rights reserved.
//

#import "CustomPresentAnimation.h"

@implementation CustomPresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
  return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  
  CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
  // 2. obtain the container view
  UIView *containerView = [transitionContext containerView];
  // 3. set initial state
  CGRect screenBounds = [[UIScreen mainScreen] bounds];
  toViewController.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
  // 4. add the view
  [containerView addSubview:toViewController.view];
  // 5. animate
  NSTimeInterval duration = [self transitionDuration:transitionContext];
  [UIView animateWithDuration:duration
                        delay:0.0
       usingSpringWithDamping:0.7
        initialSpringVelocity:0.0
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     fromViewController.view.alpha = 0.0;
                     toViewController.view.frame = finalFrame;
                   }
                   completion:^(BOOL finished) {
                     // 6. inform the context of completion
                     [transitionContext completeTransition:YES];
                     fromViewController.view.alpha = 1.0;
                   }];
}


@end
