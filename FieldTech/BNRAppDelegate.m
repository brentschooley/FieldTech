//
//  BNRAppDelegate.m
//  FieldTech
//

#import "BNRAppDelegate.h"
#import "BNRSplitTransition.h"
#import "BNRPinchTransition.h"

@interface BNRAppDelegate() <UIViewControllerAnimatedTransitioning, UIViewControllerInteractiveTransitioning>

@property (nonatomic, strong) BNRPinchTransition *interactiveTransition;

@end

@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    UITabBarController *mainVC = (UITabBarController *)self.window.rootViewController;
    mainVC.delegate = self;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    NSLog(@"Asking for animation controller");
    
    
    BNRSplitTransition *animController = [[BNRSplitTransition alloc] init];
    return animController;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Return how long, in seconds, the animation should take
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Get the destination view controller
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // Get a snapshot of the destination view and make it full transparent
    UIView *toViewSnapshot = [toVC.view snapshotViewAfterScreenUpdates:YES];
    toViewSnapshot.alpha = 0.0;
    
    // Put the view in the container of the animation
    UIView *container = [transitionContext containerView];
    [container addSubview:toViewSnapshot];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toViewSnapshot.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         [toViewSnapshot removeFromSuperview];
                         [container addSubview:toVC.view];
                         
                         [transitionContext completeTransition:YES];
                     }
     ];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if(self.interactiveTransition.isInteractive) {
        return self.interactiveTransition;
    }
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC
{
    return self;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(!self.interactiveTransition) {
        self.interactiveTransition = [[BNRPinchTransition alloc] init];
    }
    [self.interactiveTransition addInteractionToViewController:viewController];
}

@end









