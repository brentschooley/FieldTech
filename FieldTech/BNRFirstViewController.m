//
//  BNRFirstViewController.m
//  FieldTech
//

#import "BNRFirstViewController.h"
#import "BNRAppDelegate.h"

@interface BNRFirstViewController ()

@end

@implementation BNRFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSStringFromClass([self class]);
    
    BNRAppDelegate *appDelegate = (BNRAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.navigationController.delegate = appDelegate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
