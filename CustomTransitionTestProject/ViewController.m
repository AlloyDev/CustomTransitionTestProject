//
//  ViewController.m
//  CustomTransitionTestProject
//
//  Created by Tsyganov Stanislav on 16.02.14.
//  Copyright (c) 2014 Tsyganov Stanislav. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)close:(id)sender {
  if ([self navigationController]) {
    [[self navigationController] popViewControllerAnimated:YES];
  } else {
    [self dismissViewControllerAnimated:YES completion:nil];
  }
}

@end
