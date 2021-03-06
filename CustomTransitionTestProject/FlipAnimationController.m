//
//  FlipAnimationController.m
//  CustomTransitionTestProject
//
//  Created by Tsyganov Stanislav on 17.02.14.
//  Copyright (c) 2014 Tsyganov Stanislav. All rights reserved.
//

#import "FlipAnimationController.h"

@implementation FlipAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
  return 1.0;
}

-(CATransform3D) yRotation:(CGFloat)angle{
  return CATransform3DMakeRotation(angle, 0, 1.0, 0);
}

- (void)animateTransition: (id<UIViewControllerContextTransitioning>)transitionContext {
  // 1. the usual stuff ...
  UIView* containerView = [transitionContext containerView];
  UIViewController *fromVC = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
  UIView *toView = toVC.view;
  UIView *fromView = fromVC.view;
  [containerView addSubview:toVC.view];
  
  // 2. Add a perspective transform
  CATransform3D transform = CATransform3DIdentity;
  transform.m34 = -0.002;
  [containerView.layer setSublayerTransform:transform];
  
  // 3. Give both VCs the same start frame
  CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
  fromView.frame = initialFrame;
  toView.frame = initialFrame;
  
  // 4. reverse?
  float factor = self.reverse ? 1.0 : -1.0;
  
  // 5. flip the to VC halfway round - hiding it
  toView.layer.transform = [self yRotation:factor * -M_PI_2];
  
  // 6. Animate
  NSTimeInterval duration = [self transitionDuration:transitionContext];
  [UIView animateKeyframesWithDuration:duration
                                 delay:0.0
                               options:0
                            animations:^{
                              [UIView addKeyframeWithRelativeStartTime:0.0
                                                      relativeDuration:0.5
                                                            animations:^{
                                                              fromView.layer.transform = [self yRotation:factor * M_PI_2];
                                                            }];
                              [UIView addKeyframeWithRelativeStartTime:0.5
                                                      relativeDuration:0.5
                                                            animations:^{
                                                              // 8. rotate the to view
                                                              toView.layer.transform = [self yRotation:0.0];
                                                            }];
                            }
                            completion:^(BOOL finished) {
                              [transitionContext completeTransition: ![transitionContext transitionWasCancelled]];
                            }];
}

@end
