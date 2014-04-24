//
//  SwipeInteractionController.h
//  CustomTransitionTestProject
//
//  Created by Tsyganov Stanislav on 24.04.14.
//  Copyright (c) 2014 Tsyganov Stanislav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeInteractionController : UIPercentDrivenInteractiveTransition

- (void)wireToViewController:(UIViewController *)viewController;

@property (nonatomic, assign) BOOL interactionInProgress;

@end
