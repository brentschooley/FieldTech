//
//  BNRThirdViewController.m
//  FieldTech
//
//  Created by Stephen Christopher on 3/1/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "BNRThirdViewController.h"
#import "BNRSplitTransition.h"

@interface BNRThirdViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation BNRThirdViewController

- (id<UIViewControllerAnimatedTransitioning>)modalAnimationController
{
    BNRSplitTransition *animationController = [[BNRSplitTransition alloc] init];
    return animationController;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destinationVC = [segue destinationViewController];
    
    [destinationVC setTransitioningDelegate:self];
}

#pragma mark - <UIViewControllerTransitioningDelegate>

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [self modalAnimationController];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [self modalAnimationController];
}

@end
