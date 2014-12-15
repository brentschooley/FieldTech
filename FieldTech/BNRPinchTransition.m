//
//  BNRPinchTransition.m
//  FieldTech
//
//  Created by Brent Schooley on 12/15/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "BNRPinchTransition.h"

@interface BNRPinchTransition() <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UINavigationController *navController;
@property (nonatomic, assign) CGFloat firstScale;
@property (nonatomic, assign) CGFloat lastPercent;

@end

@implementation BNRPinchTransition

- (void)addInteractionToViewController:(UIViewController *)viewController
{
    self.navController = viewController.navigationController;
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handlePinch:)];
    [viewController.view addGestureRecognizer:pinchRecognizer];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)pinchRecognizer
{
    switch (pinchRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.interactive = YES;
            self.firstScale = pinchRecognizer.scale;
            [self.navController popViewControllerAnimated:YES];
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat percentComplete = ((pinchRecognizer.scale / self.firstScale) - 1.0) / 2.0;
            self.lastPercent = percentComplete;
            NSLog(@"Percent complete is %f, Last Percent is %f", percentComplete, self.lastPercent);
            [self updateInteractiveTransition:percentComplete];
        }
        break;
            
            
        case UIGestureRecognizerStateCancelled:
            self.interactive = NO;
            [self cancelInteractiveTransition];
            break;
        case UIGestureRecognizerStateEnded:
            self.interactive = NO;
            
            if (self.lastPercent > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            break;
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateFailed:
            break;
    }
}

@end
