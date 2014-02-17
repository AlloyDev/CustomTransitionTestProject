//
//  FlipAnimationController.h
//  CustomTransitionTestProject
//
//  Created by Tsyganov Stanislav on 17.02.14.
//  Copyright (c) 2014 Tsyganov Stanislav. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlipAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL reverse;

@end
