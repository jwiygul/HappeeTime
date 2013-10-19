//
//  UroAppAppDelegate.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "UroAppAppDelegate.h"
#import "IntakeViewController.h"
#import "OutputViewController.h"
#import "LogItemStore.h"
#import "OutputLogItemStore.h"
#import "MailViewController.h"
#import "MenuPageViewController.h"
static int applicationBadge = 0;
@implementation UroAppAppDelegate
{
    UIViewController<BannerViewContainer> *currentControl;
    ADBannerView *bannerView;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    IntakeViewController *vcc = [[IntakeViewController alloc]init];
    MenuPageViewController *mpvc;
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        mpvc = [[MenuPageViewController alloc]init];
    }
    else
        mpvc = [[MenuPageViewController alloc]initWithNibName:@"MenuPagePadViewController" bundle:nil];
    OutputViewController *ovc = [[OutputViewController alloc]init];
    UITabBarController *tbc = [[UITabBarController alloc]init];
  
    bannerView = [[ADBannerView alloc]initWithFrame:CGRectMake(0.0, bounds.size.height, 0.0, 0.0)];
    bannerView.delegate = self;
    MailViewController *mvc = [[MailViewController alloc]init];
    tbc.delegate=self;
    [[tbc tabBar]setBarTintColor:[UIColor blackColor]];
    [[tbc tabBar]setTranslucent:NO];
    NSArray *viewcontrols = [[NSArray alloc]initWithObjects:mpvc, vcc,ovc, mvc,nil];
    [tbc setViewControllers:viewcontrols];
    currentControl=(UIViewController<BannerViewContainer> *)tbc.selectedViewController;
    [[self window]setRootViewController:tbc];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(updateBadgeNumber) name:@"increasedBadges" object:nil];
    NSNotificationCenter *ns = [NSNotificationCenter defaultCenter];
    [ns addObserver:self selector:@selector(decreaseBadgeNumber) name:@"decreasedBadges" object:nil];
    NSNotificationCenter *nl = [NSNotificationCenter defaultCenter];
    [nl addObserver:self selector:@selector(applicationBadgeZero) name:@"badgesSeen" object:nil];
    applicationBadge += [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingPoopBadges];
    applicationBadge += [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingPeeBadges];
    applicationBadge += [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingFiberBadges];
    applicationBadge += [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingFluidBadges];
    
    
    return YES;
}
-(NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else
        return UIInterfaceOrientationMaskPortrait;
}

-(void)updateBadgeNumber
{
    applicationBadge++;
}

-(void)decreaseBadgeNumber
{
    applicationBadge--;
}
-(void)applicationBadgeZero
{
    applicationBadge = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[LogItemStore sharedStore]saveChanges];
    [[OutputLogItemStore sharedStore]saveChanges];
    UIApplication *app = [UIApplication sharedApplication];
    if (applicationBadge >0)
    app.applicationIconBadgeNumber = applicationBadge;
    else{
        applicationBadge = 0;
        app.applicationIconBadgeNumber = nil;
    }

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    int count = [[[LogItemStore sharedStore]itemContainer]count];
    NSDate *containerDate = [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:count -1]dateCreated];
    NSDate *todaysDate = [[NSDate alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *containerString = [formatter stringFromDate:containerDate];
    
    NSString *todaysDateString = [formatter stringFromDate:todaysDate];
    NSComparisonResult containerResult = [todaysDateString compare:containerString];
    if (containerResult != NSOrderedSame) {
        [[LogItemStore sharedStore]setCurrentItemContainer];
        [[OutputLogItemStore sharedStore]setCurrentItemContainer];
        NSNotification *note = [NSNotification notificationWithName:@"newDay" object:nil];
        [[NSNotificationCenter  defaultCenter]postNotification:note];
    }
   ;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}
-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"erroloading");
    [currentControl hideBannerView:bannerView animated:YES];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (currentControl==viewController) {
        return;
    }
    if (bannerView.bannerLoaded) {
        
        [currentControl hideBannerView:bannerView animated:NO];
        [(UIViewController<BannerViewContainer> *)viewController showBannerView:bannerView animated:YES];
    }
    
    currentControl = (UIViewController<BannerViewContainer> *)viewController;
}
@end
