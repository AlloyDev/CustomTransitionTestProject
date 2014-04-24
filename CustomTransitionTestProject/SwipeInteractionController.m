//
//  SwipeInteractionController.m
//  CustomTransitionTestProject
//
//  Created by Tsyganov Stanislav on 24.04.14.
//  Copyright (c) 2014 Tsyganov Stanislav. All rights reserved.
//

#import "SwipeInteractionController.h"

@implementation SwipeInteractionController {
  BOOL _shouldCompleteTransition;
  UIViewController *_viewController;
  UIPanGestureRecognizer *_gesture;
}

-(void)dealloc {
  [_gesture.view removeGestureRecognizer:_gesture];
}

- (void)wireToViewController:(UIViewController *)viewController{
  
  _viewController = viewController;
  [self prepareGestureRecognizerInView:viewController.view];
}


- (void)prepareGestureRecognizerInView:(UIView*)view {
  _gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
  [view addGestureRecognizer:_gesture];
}

- (CGFloat)completionSpeed
{
  return 1 - self.percentComplete;
}

- (void)handleGesture:(UIPanGestureRecognizer*)gestureRecognizer {
  CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
  CGPoint vel = [gestureRecognizer velocityInView:gestureRecognizer.view];
  
  switch (gestureRecognizer.state) {
    case UIGestureRecognizerStateBegan: {
      
      BOOL rightToLeftSwipe = vel.x < 0;
      
        // for tab controllers, we need to determine which direction to transition
      if (rightToLeftSwipe) {
        if (_viewController.tabBarController.selectedIndex < _viewController.tabBarController.viewControllers.count - 1) {
          self.interactionInProgress = YES;
          _viewController.tabBarController.selectedIndex++;
        }
        
      } else {
        if (_viewController.tabBarController.selectedIndex > 0) {
          self.interactionInProgress = YES;
          _viewController.tabBarController.selectedIndex--;
        }
      }
      
      
      break;
    }
    case UIGestureRecognizerStateChanged: {
      if (self.interactionInProgress) {
        // compute the current position
        CGFloat fraction = fabsf(translation.x / 200.0);
        fraction = fminf(fmaxf(fraction, 0.0), 1.0);
        _shouldCompleteTransition = (fraction > 0.5);
        
        // if an interactive transitions is 100% completed via the user interaction, for some reason
        // the animation completion block is not called, and hence the transition is not completed.
        // This glorious hack makes sure that this doesn't happen.
        // see: https://github.com/ColinEberhardt/VCTransitionsLibrary/issues/4
        if (fraction >= 1.0)
          fraction = 0.99;
        
        [self updateInteractiveTransition:fraction];
      }
      break;
    }
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled:
      if (self.interactionInProgress) {
        self.interactionInProgress = NO;
        if (!_shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
          [self cancelInteractiveTransition];
        }
        else {
          [self finishInteractiveTransition];
        }
      }
      break;
    default:
      break;
  }
}

@end
