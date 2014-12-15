//
//  BNRPinchTransition.h
//  FieldTech
//
//  Created by Brent Schooley on 12/15/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNRPinchTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, getter=isInteractive) BOOL interactive;

- (void)addInteractionToViewController:(UIViewController *)viewController;

@end
