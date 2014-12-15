//
//  BNRSplitTransition.m
//  FieldTech
//
//  Created by Brent Schooley on 12/15/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "BNRSplitTransition.h"

@implementation BNRSplitTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Return how long, in seconds, the animation should take
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Get transition context views and things
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    
    UIView *inView = [transitionContext containerView];
    
    //Create snapshot views of the halves of the current view
    CGRect topHalf, bottomHalf;
    CGRectDivide(fromView.bounds, &topHalf, &bottomHalf, fromView.bounds.size.height /2.0, CGRectMinYEdge);
    
    UIView *topHalfView = [fromView resizableSnapshotViewFromRect:topHalf afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    UIView *bottomHalfView = [fromView resizableSnapshotViewFromRect:bottomHalf afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
    bottomHalfView.frame = bottomHalf;
    
    // Add the split views and destination view to that container
    [inView addSubview:toView];
    [inView addSubview:topHalfView];
    [inView addSubview:bottomHalfView];
    
//    [UIView animateWithDuration:1.0
//                          delay:0.0
//         usingSpringWithDamping:0.9
//          initialSpringVelocity:1.0
//                        options:0
//                     animations:^{
//                         topHalfView.center = CGPointMake(-topHalfView.center.x, topHalfView.center.y);
//                         bottomHalfView.center = CGPointMake(bottomHalfView.center.x + bottomHalf.size.width, bottomHalfView.center.y);
//                     } completion:^(BOOL finished) {
//                         [topHalfView removeFromSuperview];
//                         [bottomHalfView removeFromSuperview];
//                         
//                         [transitionContext completeTransition:YES];
//                     }];
    
    [UIView animateKeyframesWithDuration:1.0
                                   delay:0.0
                                 options:0
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    topHalfView.center = CGPointMake(0.0, topHalfView.center.y);
                                                                    bottomHalfView.center = CGPointMake(bottomHalf.size.width, bottomHalfView.center.y);
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0.5
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    topHalfView.center = CGPointMake(0.0, inView.bounds.size.height + topHalf.size.height / 2.0);
                                                                    bottomHalfView.center = CGPointMake(bottomHalf.size.width, -bottomHalf.size.height / 2.0);
                                                                }];
                              } completion:^(BOOL finished) {
                                  [topHalfView removeFromSuperview];
                                  [bottomHalfView removeFromSuperview];
                                  
                                  if([transitionContext transitionWasCancelled]) {
                                      [transitionContext completeTransition:NO];
                                  } else {
                                      [transitionContext completeTransition:YES];
                                  }
                              }];
}

@end
