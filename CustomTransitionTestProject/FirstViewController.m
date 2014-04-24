//
//  FirstViewController.m
//  CustomTransitionTestProject
//
//  Created by Tsyganov Stanislav on 16.02.14.
//  Copyright (c) 2014 Tsyganov Stanislav. All rights reserved.
//

#import "FirstViewController.h"
#import "CustomPresentAnimation.h"
#import "FlipAnimationController.h"
#import "SwipeInteractionController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController {
  CustomPresentAnimation *_customPresentAnimation;
  FlipAnimationController *_flipAnimationController;
  SwipeInteractionController *_swipeInteractionController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
    _customPresentAnimation = [CustomPresentAnimation new];
    _flipAnimationController = [FlipAnimationController new];
    _swipeInteractionController = [SwipeInteractionController new];
//    [_swipeInteractionController wireToViewController:self.tabBarController.selectedViewController];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  self.navigationController.delegate = self;
  self.tabBarController.delegate = self;
//  [_swipeInteractionController wireToViewController:[self.tabBarController.viewControllers objectAtIndex:1]];
  for (UIViewController* vc in self.tabBarController.viewControllers) {
      [_swipeInteractionController wireToViewController:vc];
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  if ([segue.identifier isEqualToString:@"presentSecond"]) {
    UIViewController *toVC = segue.destinationViewController;
    // сообщаем следующему контроллеру, что этот отвечает за переход
    toVC.transitioningDelegate = self;
  }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
  if (!_customPresentAnimation) {
    _customPresentAnimation = [CustomPresentAnimation new];
  }
  return _customPresentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
  if (!_customPresentAnimation) {
    _customPresentAnimation = [CustomPresentAnimation new];
  }
  return _customPresentAnimation;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
  
  if (!_flipAnimationController) {
    _flipAnimationController = [FlipAnimationController new];
  }
  
  NSInteger indexFromVC = [[tabBarController viewControllers] indexOfObject:fromVC];
  NSInteger indexToVC = [[tabBarController viewControllers] indexOfObject:toVC];
  
  if (indexToVC<indexFromVC) {
    _flipAnimationController.reverse = YES;
  }else{
    _flipAnimationController.reverse = NO;
  }
  [_swipeInteractionController wireToViewController:toVC];
  
  return _flipAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
  if (!_swipeInteractionController) {
    _swipeInteractionController = [SwipeInteractionController new];
  }
  return _swipeInteractionController.interactionInProgress ? _swipeInteractionController : nil;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

}

@end
