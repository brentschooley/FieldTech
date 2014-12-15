//
//  BNRModalViewController.m
//  FieldTech
//
//  Created by Stephen Christopher on 3/1/14.
//  Copyright (c) 2014 Jonathan Blocksom. All rights reserved.
//

#import "BNRModalViewController.h"

@interface BNRModalViewController ()

- (IBAction)didPressDismissButton:(id)sender;

@end

@implementation BNRModalViewController

- (void)didPressDismissButton:(id)sender
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

@end
