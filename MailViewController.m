//
//  MailViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "MailViewController.h"
#import "AwardCell.h"
#import "VoidingLogCell.h"
#import "LogItemStore.h"
#import "ProgramInfoViewController.h"
#import "OutputLogItemStore.h"
#import <UIKit/UIKit.h>



static int tableViewLoads = 0;
static int fiberAwardsCount = 0;
static int fluidsAwardsCount = 0;
static int peeAwardsCount = 0;
static int poopAwardsCount = 0;
static int badgesEarned = 0;
static int earnedFiberBadge = 0;
static int earnedFluidBadge = 0;
static int earnedPeeBadge = 0;
static int earnedPoopBadge = 0;
@implementation MailViewController
{
    ADBannerView *myBannerView;
}
@synthesize tableViewFluid,tableViewFiber, tableViewPee, tableViewPoop,toolBar,scrollView, pageControl,leavingPageNumber;

-(id)init
{
    self= [super initWithNibName:@"MailViewController" bundle:nil];
    if (self
        ) {
        self.tabBarItem.title = @"Awards Page";
        self.tabBarItem.image = [UIImage imageNamed:@"medalGrey1.png"];
        
        NSNotificationCenter *clearBadges = [NSNotificationCenter defaultCenter];
        [clearBadges addObserver:self selector:@selector(dataCleared) name:@"dataCleared" object:nil];
        
        NSNotificationCenter *fiBadge = [NSNotificationCenter defaultCenter];
        [fiBadge addObserver:self selector:@selector(newFiberMeritBadge) name:@"newFiberMeritBadge" object:nil];
        NSNotificationCenter *fiBadgeGone = [NSNotificationCenter defaultCenter];
        [fiBadgeGone addObserver:self selector:@selector(lowerFiberBadgeCount) name:@"fiberMeritBadgeGone" object:nil];
        NSNotificationCenter *flBadge = [NSNotificationCenter defaultCenter];
        [flBadge addObserver:self selector:@selector(newFluidMeritBadge) name:@"newFluidMeritBadge" object:nil];
        NSNotificationCenter *flBadgeGone = [NSNotificationCenter defaultCenter];
        [flBadgeGone addObserver:self selector:@selector(lowerFluidBadgeCount) name:@"fluidMeritBadgeGone" object:nil];
        NSNotificationCenter *peeBadge = [NSNotificationCenter defaultCenter];
        [peeBadge addObserver:self selector:@selector(newPeeMeritBadge) name:@"newPeeMeritBadge" object:nil];
        NSNotificationCenter *peeBadgeGone = [NSNotificationCenter defaultCenter];
        [peeBadgeGone addObserver:self selector:@selector(lowerPeeBadgeCount) name:@"peeMeritBadgeGone" object:nil];
        NSNotificationCenter *poopBadge = [NSNotificationCenter defaultCenter];
        [poopBadge addObserver:self selector:@selector(newPoopMeritBadge) name:@"newPoopMeritBadge" object:nil];
        NSNotificationCenter *poopBadgeGone = [NSNotificationCenter defaultCenter];
        [poopBadgeGone addObserver:self selector:@selector(lowerPoopBadgeCount) name:@"poopMeritBadgeGone" object:nil];
        int totalStoredBadges = 0;
        if ([[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingFiberBadges]>0) {
            totalStoredBadges += [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingFiberBadges];
            earnedFiberBadge = [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingFiberBadges];
        }
        if ([[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingFluidBadges]>0) {
            totalStoredBadges +=[[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingFluidBadges];
            earnedFluidBadge = [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingFluidBadges];
        }
        if ([[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingPoopBadges]>0) {
            totalStoredBadges += [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingPoopBadges];
            earnedPoopBadge = [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingPoopBadges];
        }
        if ([[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingPeeBadges]>0) {
            totalStoredBadges += [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingPeeBadges];
            earnedPeeBadge = [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]pendingPeeBadges];
        }
        if (totalStoredBadges >0) {
            NSNumber *newBadgeNumber = [[NSNumber alloc]initWithInt:totalStoredBadges];
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
            NSString *badges = [formatter stringFromNumber:newBadgeNumber];
            self.tabBarItem.badgeValue =badges;
            badgesEarned = totalStoredBadges;
        }
        
        
    }
    
    return self;
}
-(void)newPeeMeritBadge
{
    earnedPeeBadge++;
    [[LogItemStore sharedStore]setPendingPeeBadges:1];
    [self updateBadge:self];
}
-(void)newPoopMeritBadge
{
    earnedPoopBadge++;
    [[LogItemStore sharedStore]setPendingPoopBadges:1];
    [self updateBadge:self];
}
-(void)newFiberMeritBadge
{
    earnedFiberBadge++;
    [[LogItemStore sharedStore]setPendingFiberBadges:1];
    [self updateBadge:self];
}
-(void)newFluidMeritBadge
{
    earnedFluidBadge++;
    [[LogItemStore sharedStore]setPendingFluidBadges:1];
    [self updateBadge:self];
}
-(void)lowerPeeBadgeCount
{
    earnedPeeBadge--;
    if (earnedPeeBadge >=0) {
        [[LogItemStore sharedStore]setPendingPeeBadges:2];
        [self lowerBadgeCount];
    }
    if (earnedPeeBadge < 0) {
        earnedPeeBadge = 0;
    }
}
-(void)lowerPoopBadgeCount
{
    earnedPoopBadge--;
    if (earnedPoopBadge >=0) {
        [[LogItemStore sharedStore]setPendingPoopBadges:2];
        [self lowerBadgeCount];
    }
    if (earnedPoopBadge <0) {
        earnedPoopBadge = 0;
    }
}
-(void)lowerFiberBadgeCount
{
    earnedFiberBadge--;
    if (earnedFiberBadge >=0) {
        [[LogItemStore sharedStore]setPendingFiberBadges:2];
        [self lowerBadgeCount];
    }
    if (earnedFiberBadge <0) {
        earnedFiberBadge = 0;
    }
    
    
}
-(void)lowerFluidBadgeCount
{
    earnedFluidBadge--;
    if (earnedFluidBadge >=0) {
        [[LogItemStore sharedStore]setPendingFluidBadges:2];
        [self lowerBadgeCount];
    }
    if (earnedFluidBadge <0) {
        earnedFluidBadge = 0;
    }
}


-(void)lowerBadgeCount
{
    badgesEarned--;
    if (badgesEarned <=0) {
        badgesEarned = 0;
        self.tabBarItem.badgeValue = nil;
        NSNotification *note = [NSNotification notificationWithName:@"badgesSeen" object:nil];
        [[NSNotificationCenter  defaultCenter]postNotification:note];
    }
    if (badgesEarned >0) {
        NSNumber *newBadgeNumber = [[NSNumber alloc]initWithInt:badgesEarned];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        NSString *badges = [formatter stringFromNumber:newBadgeNumber];
        self.tabBarItem.badgeValue =badges;
        NSNotification *note = [NSNotification notificationWithName:@"decreasedBadges" object:nil];
        [[NSNotificationCenter  defaultCenter]postNotification:note];
    }
}
-(void)dataCleared
{
    self.tabBarItem.badgeValue =nil;
}
-(void)updateBadge:(id)sender
{
    badgesEarned++;
    NSNumber *newBadgeNumber = [[NSNumber alloc]initWithInt:badgesEarned];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    NSString *badges = [formatter stringFromNumber:newBadgeNumber];
    self.tabBarItem.badgeValue =badges;
    NSNotification *note = [NSNotification notificationWithName:@"increasedBadges" object:nil];
    [[NSNotificationCenter  defaultCenter]postNotification:note];
}




-(void)loadView
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    UIView *view = [[UIView alloc]initWithFrame:rect];
    [self setView:view];
    
   
}

-(void)viewDidAppear:(BOOL)animated
{
   
    [super viewDidAppear:animated];
    
    [tableViewFiber reloadData];
    [tableViewPoop reloadData];
    [tableViewPee reloadData];
    [tableViewFluid reloadData];
   
    
    self.tabBarItem.badgeValue = nil;
    [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]setPendingPoopBadges:0];
    [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]setPendingFiberBadges:0];
    [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]setPendingFluidBadges:0];
    [[[[LogItemStore sharedStore]itemContainer]objectAtIndex:0]setPendingPeeBadges:0];
    badgesEarned = 0;
    earnedFiberBadge = 0;
    earnedFluidBadge =0;
    earnedPeeBadge = 0;
    earnedPoopBadge =0;
    NSNotification *note = [NSNotification notificationWithName:@"badgesSeen" object:nil];
    [[NSNotificationCenter  defaultCenter]postNotification:note];
    
}

-(void)showInfo:(id)sender
{
    ProgramInfoViewController *pvc = [[ProgramInfoViewController alloc]init];
    UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:pvc];
    [navCom setModalPresentationStyle:UIModalPresentationFormSheet];
    [navCom setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:navCom animated:YES completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    toolBar = [[UIToolbar alloc]init];
    UINib *nib = [UINib nibWithNibName:@"AwardCell" bundle:nil];
    UINib *padNib = [UINib nibWithNibName:@"AwardCellPad" bundle:nil];
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    [[self view]addSubview:toolBar];
    CGSize toolSize = [toolBar sizeThatFits:CGSizeZero];
    CGRect rect;
   
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation])&& [UIDevice currentDevice].userInterfaceIdiom !=UIUserInterfaceIdiomPhone) {
        rect = CGRectMake(0.0, screenRect.origin.y, toolSize.width-(screenRect.size.height-screenRect.size.width)+ [UIApplication sharedApplication].statusBarFrame.size.width, toolSize.height);
    }
    else
        rect = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, toolSize.width, toolSize.height+0.5*[UIApplication sharedApplication].statusBarFrame.size.height);
    
    
    
    [toolBar setTintColor:[UIColor whiteColor]];
    toolBar.translucent =NO;
    [toolBar setBarTintColor:[UIColor blackColor]];
    toolBar.frame = rect;
   
    [toolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [[self view]addSubview:toolBar];
    UIBarButtonItem *nameButton =[[UIBarButtonItem alloc]initWithTitle:@"AWARDS PAGE" style:nil target:nil action:nil];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *buttonArray = [NSArray arrayWithObjects: flexItem, nameButton, flexItem,nil];
    [toolBar setItems:buttonArray];
    
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation])&& [UIDevice currentDevice].userInterfaceIdiom !=UIUserInterfaceIdiomPhone) {
        if ([self interfaceOrientation] ==UIDeviceOrientationLandscapeRight) {
            screenRect.origin.x -= [UIApplication sharedApplication].statusBarFrame.size.width;
        }
        screenRect.origin.y +=toolSize.height;
        screenRect.size.width += screenRect.size.height-screenRect.size.width;
    }
    else  
    screenRect.origin.y += [UIApplication sharedApplication].statusBarFrame.size.height;
    
    tableViewFiber = [[UITableView alloc]initWithFrame:screenRect style:UITableViewStyleGrouped];
    [tableViewFiber setDataSource:self];
    [tableViewFiber setDelegate:self];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [tableViewFiber registerNib:padNib forCellReuseIdentifier:@"AwardCellPad"];
    }
    else
    [tableViewFiber registerNib:nib forCellReuseIdentifier:@"AwardCell"];
    [[self view]addSubview:tableViewFiber];
  
    tableViewFluid = [[UITableView alloc]initWithFrame:screenRect style:UITableViewStyleGrouped];
    [tableViewFluid setDataSource:self];
    [tableViewFluid setDelegate:self];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [tableViewFluid registerNib:padNib forCellReuseIdentifier:@"AwardCellPad"];
    }
    else
    [tableViewFluid registerNib:nib forCellReuseIdentifier:@"AwardCell"];
    
    tableViewPee = [[UITableView alloc]initWithFrame:screenRect style:UITableViewStyleGrouped];
    [tableViewPee setDataSource:self];
    [tableViewPee setDelegate:self];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [tableViewPee registerNib:padNib forCellReuseIdentifier:@"AwardCellPad"];
    }
    else
    [tableViewPee registerNib:nib forCellReuseIdentifier:@"AwardCell"];
    
    tableViewPoop = [[UITableView alloc]initWithFrame:screenRect style:UITableViewStyleGrouped];
    [tableViewPoop setDataSource:self];
    [tableViewPoop setDelegate:self];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [tableViewPoop registerNib:padNib forCellReuseIdentifier:@"AwardCellPad"];
    }
    else
    [tableViewPoop registerNib:nib forCellReuseIdentifier:@"AwardCell"];
        
    
    //create bookcase image for scrollview
    UIImageView *bookCase = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
    UIImageView *anotherCase = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
    UIImageView *yetAnotherCase =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];;
    UIImageView *andYetAnotherCase =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
     yetAnotherCase.frame = tableViewFluid.frame;
    andYetAnotherCase.frame= tableViewPee.frame;
    bookCase.frame = tableViewPoop.frame;
    anotherCase.frame = tableViewFiber.frame;
    
    tableViewPoop.backgroundView =bookCase;
    tableViewFluid.backgroundView =yetAnotherCase;
    tableViewPee.backgroundView = andYetAnotherCase;
    tableViewFiber.backgroundView = anotherCase;
   
    tableViewFiber.tag = 1;
    tableViewFluid.tag = 2;
    tableViewPee.tag = 3;
    tableViewPoop.tag =4;
    scrollView = [[UIScrollView alloc]initWithFrame:screenRect];
    [scrollView addSubview:tableViewFiber];
    [scrollView addSubview:tableViewFluid];
    [scrollView addSubview:tableViewPee];
    [scrollView addSubview:tableViewPoop];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    
    [self.view addSubview:scrollView];
    [self layoutScrollPages];
    
    CGRect screenres = [[UIScreen mainScreen]applicationFrame];
    pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 4;
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    //create page control
    CGSize sier = [pageControl sizeForNumberOfPages:4];
    [[self view]addSubview:pageControl];
    CGRect recter;
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation])&& [UIDevice currentDevice].userInterfaceIdiom !=UIUserInterfaceIdiomPhone) {
        recter = CGRectMake(screenres.size.width/2-sier.width/2, screenres.size.width-2*toolSize.height, sier.width, sier.height);
    }
    else
        recter = CGRectMake(screenres.size.width/2-sier.height/2, screenres.size.height-2*toolSize.height, sier.width, sier.height);
    pageControl.frame = recter;
    pageControl.backgroundColor = [UIColor clearColor];
    [pageControl addTarget:self action:@selector(updatePage:) forControlEvents:UIControlEventValueChanged];
    [pageControl sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)updatePage:(int)number
{
    int page = pageControl.currentPage;
    if (number == 4) {
        page +=1;
    }
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
   
    if (scrollView.contentOffset.x != 0.0) {
         pageControl.currentPage = page;
    }
   
}
- (void)layoutScrollPages
{
	UITableView *view = [[UITableView alloc]init];
	NSArray *subviews = [scrollView subviews];
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation])&& [UIDevice currentDevice].userInterfaceIdiom !=UIUserInterfaceIdiomPhone)
    {
        for (view in subviews)
        {
            if ([view isKindOfClass:[UITableView class]] && view.tag > 0)
            {
                CGRect frame = view.frame;
                frame.origin = CGPointMake(curXLoc, 0);
                view.frame = frame;
                
                curXLoc += (screenRect.size.height);
            }
        }
        [scrollView setContentSize:CGSizeMake(4 * screenRect.size.height, [scrollView bounds].size.height)];
        
    }
    else//place the view in a serial vertical fashion
        {
            for (view in subviews)
            {
                if ([view isKindOfClass:[UITableView class]] && view.tag > 0)
                {
                    CGRect frame = view.frame;
                    frame.origin = CGPointMake(curXLoc, 0);
                    view.frame = frame;
                    curXLoc += (screenRect.size.width);
                }
            }
            [scrollView setContentSize:CGSizeMake((4 * screenRect.size.width), [scrollView bounds].size.height)];
    
        }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    pageNumber = pageControl.currentPage;
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    
    int number = 0;
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation]))
    {
        if ([self interfaceOrientation] == UIDeviceOrientationLandscapeRight) {
            screenRect.origin.x -= [UIApplication sharedApplication].statusBarFrame.size.width;
        }
        
        screenRect.origin.y +=toolBar.frame.size.height;
        tableViewFiber.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.height, screenRect.size.width);
        tableViewFluid.frame = tableViewFiber.frame;
        tableViewPee.frame = tableViewFiber.frame;
        tableViewPoop.frame = tableViewFiber.frame;
        UIImageView *bookCase = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        UIImageView *anotherCase = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        UIImageView *yetAnotherCase =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];;
        UIImageView *andYetAnotherCase =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        yetAnotherCase.frame = tableViewFluid.frame;
        andYetAnotherCase.frame= tableViewPee.frame;
        bookCase.frame = tableViewPoop.frame;
        anotherCase.frame = tableViewFiber.frame;
        
        tableViewPoop.backgroundView =bookCase;
        tableViewFluid.backgroundView =yetAnotherCase;
        tableViewPee.backgroundView = andYetAnotherCase;
        tableViewFiber.backgroundView = anotherCase;
        scrollView.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.height, screenRect.size.width);
        CGSize pcSize =   [pageControl sizeForNumberOfPages:4];
        pageControl.frame = CGRectMake(screenRect.size.height/2-pcSize.width/2, screenRect.size.width - toolBar.frame.size.height*2, pcSize.width, pcSize.height);
        [self layoutScrollPages];
        if (pageNumber ==3) {
            number = 4;
        }
        
        
    }
    else
    {
        
        screenRect.origin.y +=toolBar.frame.size.height/2 ;
        tableViewFiber.frame = screenRect;
        tableViewFluid.frame = tableViewFiber.frame;
        tableViewPee.frame = tableViewFiber.frame;
        tableViewPoop.frame = tableViewFiber.frame;
        UIImageView *bookCase1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        UIImageView *anotherCase1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        UIImageView *yetAnotherCase1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];;
        UIImageView *andYetAnotherCase1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        yetAnotherCase1.frame = tableViewFluid.frame;
        andYetAnotherCase1.frame= tableViewPee.frame;
        bookCase1.frame = tableViewPoop.frame;
        anotherCase1.frame = tableViewFiber.frame;
        
        tableViewPoop.backgroundView =bookCase1;
        tableViewFluid.backgroundView =yetAnotherCase1;
        tableViewPee.backgroundView = andYetAnotherCase1;
        tableViewFiber.backgroundView = anotherCase1;
        scrollView.frame = screenRect;
        CGSize sier = [pageControl sizeForNumberOfPages:4];
        [[self view]addSubview:pageControl];
        CGRect recter = CGRectMake(screenRect.size.width/2-sier.width/2, screenRect.size.height-2*toolBar.frame.size.height, sier.width, sier.height);
        pageControl.frame = recter;
        [self layoutScrollPages];
    }
    [self updatePage:(number)];
    [tableViewFiber reloadData];
    [tableViewFluid reloadData];
    [tableViewPee reloadData];
    [tableViewPoop reloadData];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorColor = [UIColor clearColor];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    
    
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation])&& [UIDevice currentDevice].userInterfaceIdiom !=UIUserInterfaceIdiomPhone)
    {
        if ([self interfaceOrientation] == UIDeviceOrientationLandscapeRight) {
            screenRect.origin.x -= [UIApplication sharedApplication].statusBarFrame.size.width;
        }
        
        screenRect.origin.y +=toolBar.frame.size.height;
        tableViewFiber.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.height, screenRect.size.width);
        tableViewFluid.frame = tableViewFiber.frame;
        tableViewPee.frame = tableViewFiber.frame;
        tableViewPoop.frame = tableViewFiber.frame;
        UIImageView *bookCase = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        UIImageView *anotherCase = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        UIImageView *yetAnotherCase =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];;
        UIImageView *andYetAnotherCase =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        yetAnotherCase.frame = tableViewFluid.frame;
        andYetAnotherCase.frame= tableViewPee.frame;
        bookCase.frame = tableViewPoop.frame;
        anotherCase.frame = tableViewFiber.frame;
        
        tableViewPoop.backgroundView =bookCase;
        tableViewFluid.backgroundView =yetAnotherCase;
        tableViewPee.backgroundView = andYetAnotherCase;
        tableViewFiber.backgroundView = anotherCase;
        scrollView.frame = CGRectMake(screenRect.origin.x, screenRect.origin.y, screenRect.size.height, screenRect.size.width);
        CGSize pcSize =   [pageControl sizeForNumberOfPages:4];
        pageControl.frame = CGRectMake(screenRect.size.height/2-pcSize.width/2, screenRect.size.width - toolBar.frame.size.height*2, pcSize.width, pcSize.height);
        [self layoutScrollPages];
        
        tableViewFiber.rowHeight = 175.0;
        tableViewFluid.rowHeight = 175.0;
        tableViewPee.rowHeight = 175.0;
        tableViewPoop.rowHeight = 175.0;
        
    }
    else
    {
        
        screenRect.origin.y +=(toolBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height);
        tableViewFiber.frame = screenRect;
        tableViewFluid.frame = tableViewFiber.frame;
        tableViewPee.frame = tableViewFiber.frame;
        tableViewPoop.frame = tableViewFiber.frame;
        UIImageView *bookCase1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        UIImageView *anotherCase1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        UIImageView *yetAnotherCase1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];;
        UIImageView *andYetAnotherCase1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AwardCase"]];
        yetAnotherCase1.frame = tableViewFluid.frame;
        andYetAnotherCase1.frame= tableViewPee.frame;
        bookCase1.frame = tableViewPoop.frame;
        anotherCase1.frame = tableViewFiber.frame;
        
        tableViewPoop.backgroundView =bookCase1;
        tableViewFluid.backgroundView =yetAnotherCase1;
        tableViewPee.backgroundView = andYetAnotherCase1;
        tableViewFiber.backgroundView = anotherCase1;
        scrollView.frame = screenRect;
        CGSize sier = [pageControl sizeForNumberOfPages:4];
        [[self view]addSubview:pageControl];
        CGRect recter = CGRectMake(screenRect.size.width/2-sier.width/2, screenRect.size.height-80.0, sier.width, sier.height);
        pageControl.frame = recter;
        [self layoutScrollPages];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            tableViewFiber.rowHeight = 73.0;
            tableViewFluid.rowHeight = 73.0;
            tableViewPee.rowHeight = 73.0;
            tableViewPoop.rowHeight  = 73.0;
        }
        else{
        tableViewFiber.rowHeight = 175.0;
        tableViewFluid.rowHeight = 175.0;
        tableViewPee.rowHeight = 175.0;
        tableViewPoop.rowHeight = 175.0;
        }
        
    }
    if (leavingPageNumber == 3) {
        [self updatePage:4];
    }
    else
    [self updatePage:1];
    [tableViewFiber reloadData];
    [tableViewFluid reloadData];
    [tableViewPee reloadData];
    [tableViewPoop reloadData];
  
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tableViewFiber)
    {
        AwardCell *cell = [[AwardCell alloc]init];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            cell = [tableViewFiber dequeueReusableCellWithIdentifier:@"AwardCellPad"];
        }
        else
            cell = [tableViewFiber dequeueReusableCellWithIdentifier:@"AwardCell"];
      
        int numberOfAwards;
        int anotherAwardsCount = fiberAwardsCount;
        if (fiberAwardsCount < 5)
        {
            numberOfAwards = fiberAwardsCount;
        }
        else
            numberOfAwards = 5;
 
        for (int count = 0; count < numberOfAwards; count++)
        {
            
            if ([[cell imageOne]image] ==nil && count >= 0)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setOne:[UIImage imageNamed:@"explosionPad.png"]];
                }
                else
                [cell setOne:[UIImage imageNamed:@"explosionPhone.png"]];
                
                
            }
            else if ([[cell imageTwo]image] == nil && count > 0)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setTwo:[UIImage imageNamed:@"explosionPad.png"]];
                }
                else
                
                [cell setTwo:[UIImage imageNamed:@"explosionPhone.png"]];
                
            }
            else if ([[cell imageThree]image] == nil  && count >1)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setThree:[UIImage imageNamed:@"explosionPad.png"]];
                }
                else
                [cell setThree:[UIImage imageNamed:@"explosionPhone.png"]];
            }
            else if ([[cell imageFour]image] == nil  && count > 2)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setFour:[UIImage imageNamed:@"explosionPad.png"]];
                }
                else
                [cell setFour:[UIImage imageNamed:@"explosionPhone.png"]];
            }
            else if ([[cell imageFive]image] == nil && count > 3)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setFive:[UIImage imageNamed:@"explosionPad.png"]];
                }
                else
                [cell setFive:[UIImage imageNamed:@"explosionPhone.png"]];
            }
            fiberAwardsCount--;
            
        }
        //next two blocks ensure that if an award was erased from one of the input pages, it is removed from the cell as well
        int blankImages = 0;
        if ([[cell imageOne]image]==nil)
            blankImages++;
        if ([[cell imageTwo]image] == nil)
            blankImages++;
        if ([[cell imageThree]image] == nil)
            blankImages++;
        if ([[cell imageFour]image] == nil)
            blankImages++;
        if ([[cell imageFive]image] == nil)
            blankImages++;
        
        
        if (anotherAwardsCount < 5-blankImages && tableViewLoads !=1)
        {
            if (anotherAwardsCount ==4)
                cell.imageFive.image = nil;
            else if (anotherAwardsCount ==3)
                cell.imageFour.image = nil;
            else if (anotherAwardsCount ==2)
                cell.imageThree.image = nil;
            else if (anotherAwardsCount ==1)
                cell.imageTwo.image = nil;
            
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        tableViewLoads++;
        
        return cell;
    }
    else if (tableView == tableViewFluid)
    {
        
        AwardCell *cell = [[AwardCell alloc]init];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            cell = [tableViewFluid dequeueReusableCellWithIdentifier:@"AwardCellPad"];
        }
        else
        cell = [tableViewFluid dequeueReusableCellWithIdentifier:@"AwardCell"];
        int numberOfAwards;
        int anotherAwardsCount = fluidsAwardsCount;
        if (fluidsAwardsCount < 5)
        {
            numberOfAwards = fluidsAwardsCount;
        }
        else
            numberOfAwards = 5;
        for (int count = 0; count < numberOfAwards; count++)
        {
            if ([[cell imageOne]image] ==nil && count >= 0)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                      [cell setOne:[UIImage imageNamed:@"ThumbsUpiPad.png"]];
                }
                else
                [cell setOne:[UIImage imageNamed:@"HPThumbsUpiPhone.png"]];
                
            }
            else if ([[cell imageTwo]image] == nil && count > 0)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setTwo:[UIImage imageNamed:@"ThumbsUpiPad.png"]];
                }
                else
                    [cell setTwo:[UIImage imageNamed:@"HPThumbsUpiPhone.png"]];
            }
            else if ([[cell imageThree]image] == nil && count >1)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setThree:[UIImage imageNamed:@"ThumbsUpiPad.png"]];
                }
                else
                    [cell setThree:[UIImage imageNamed:@"HPThumbsUpiPhone.png"]];
            }
            else if ([[cell imageFour]image] == nil && count >2)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setFour:[UIImage imageNamed:@"ThumbsUpiPad.png"]];
                }
                else
                    [cell setFour:[UIImage imageNamed:@"HPThumbsUpiPhone.png"]];
            }
            else if ([[cell imageFive]image] == nil && count >3)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setFive:[UIImage imageNamed:@"ThumbsUpiPad.png"]];
                }
                else
                    [cell setFive:[UIImage imageNamed:@"HPThumbsUpiPhone.png"]];
            }
            fluidsAwardsCount--;
            
        }
        int blankImages = 0;
        if ([[cell imageOne]image] == nil)
            blankImages++;
        if ([[cell imageTwo]image] == nil)
            blankImages++;
        if ([[cell imageThree]image] == nil)
            blankImages++;
        if ([[cell imageFour]image] == nil)
            blankImages++;
        if ([[cell imageFive]image] == nil)
            blankImages++;
        
        
        if (anotherAwardsCount < 5-blankImages && tableViewLoads !=1)
        {
            if (anotherAwardsCount ==4)
                cell.imageFive.image = nil;
            else if (anotherAwardsCount ==3)
                cell.imageFour.image = nil;
            else if (anotherAwardsCount ==2)
                cell.imageThree.image = nil;
            else if (anotherAwardsCount ==1)
                cell.imageTwo.image = nil;
        }

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        tableViewLoads++;
        return cell;
    }
    else if (tableView == tableViewPoop)
    {
        AwardCell *cell = [[AwardCell alloc]init];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            cell = [tableViewPoop dequeueReusableCellWithIdentifier:@"AwardCellPad"];
        }
        else
            cell = [tableViewPoop dequeueReusableCellWithIdentifier:@"AwardCell"];
            
        int numberOfAwards;
        int anotherAwardsCount = poopAwardsCount;
        if (poopAwardsCount < 5)
        {
            numberOfAwards = poopAwardsCount;
        }
        else
            numberOfAwards = 5;
        for (int count = 0; count < numberOfAwards; count++)
        {
            if ([[cell imageOne]image] ==nil && count >= 0)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setOne:[UIImage imageNamed:@"PoopiPad.png"]];
                }
                else
                [cell setOne:[UIImage imageNamed:@"PoopiPhone.png"]];
            }
            else if ([[cell imageTwo]image] == nil && count >0)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setTwo:[UIImage imageNamed:@"PoopiPad.png"]];
                }
                else
                [cell setTwo:[UIImage imageNamed:@"PoopiPhone.png"]];
            }
            else if ([[cell imageThree]image] == nil && count >1)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setThree:[UIImage imageNamed:@"PoopiPad.png"]];
                }
                else
                [cell setThree:[UIImage imageNamed:@"PoopiPhone.png"]];
            }
            else if ([[cell imageFour]image] == nil && count >2)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setFour:[UIImage imageNamed:@"PoopiPad.png"]];
                }
                else
                [cell setFour:[UIImage imageNamed:@"PoopiPhone.png"]];
            }
            else if ([[cell imageFive]image] == nil && count >3)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setFive:[UIImage imageNamed:@"PoopiPad.png"]];
                }
                else
                [cell setFive:[UIImage imageNamed:@"PoopiPhone.png"]];
            }
            poopAwardsCount--;
            
        }
        int blankImages = 0;
        if ([[cell imageOne]image] == nil)
            blankImages++;
        if ([[cell imageTwo]image] == nil)
            blankImages++;
        if ([[cell imageThree]image] == nil)
            blankImages++;
        if ([[cell imageFour]image] == nil)
            blankImages++;
        if ([[cell imageFive]image] == nil)
            blankImages++;
        
        
        if (anotherAwardsCount < 5-blankImages && tableViewLoads !=1)
        {
            if (anotherAwardsCount ==4)
                cell.imageFive.image = nil;
            else if (anotherAwardsCount ==3)
                cell.imageFour.image = nil;
            else if (anotherAwardsCount ==2)
                cell.imageThree.image = nil;
            else if (anotherAwardsCount ==1)
                cell.imageTwo.image = nil;
            
        }

        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        tableViewLoads++;
        return cell;

    }
    else
    {
        AwardCell *cell = [[AwardCell alloc]init];
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            cell = [tableViewPee dequeueReusableCellWithIdentifier:@"AwardCellPad"];
        }
        else
            cell = [tableViewPee dequeueReusableCellWithIdentifier:@"AwardCell"];
        int numberOfAwards;
        int anotherAwardsCount = peeAwardsCount;
        if (peeAwardsCount < 5)
        {
            numberOfAwards = peeAwardsCount;
        }
        else
            numberOfAwards = 5;
        
        
        for (int count = 0; count < numberOfAwards; count++)
        {
            if ([[cell imageOne]image] ==nil && count >= 0)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setOne:[UIImage imageNamed:@"FlushiPad.png"]];
                }
                else
                [cell setOne:[UIImage imageNamed:@"FlushiPhone.png"]];
            }
            else if ([[cell imageTwo]image] == nil && count >0)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setTwo:[UIImage imageNamed:@"FlushiPad.png"]];
                }
                else

                [cell setTwo:[UIImage imageNamed:@"FlushiPhone.png"]];
            }
            else if ([[cell imageThree]image] == nil && count >1)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setThree:[UIImage imageNamed:@"FlushiPad.png"]];
                }
                else

                [cell setThree:[UIImage imageNamed:@"FlushiPhone.png"]];
            }
            else if ([[cell imageFour]image] == nil && count >2)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setFour:[UIImage imageNamed:@"FlushiPad.png"]];
                }
                else

                [cell setFour:[UIImage imageNamed:@"FlushiPhone.png"]];
            }
            else if ([[cell imageFive]image] == nil && count >3)
            {
                if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                    [cell setFive:[UIImage imageNamed:@"FlushiPad.png"]];
                }
                else

                [cell setFive:[UIImage imageNamed:@"FlushiPhone.png"]];
            }
            peeAwardsCount--;
            
        }
        int blankImages = 0;
        if ([[cell imageOne]image] == nil)
            blankImages++;
        if ([[cell imageTwo]image] == nil)
            blankImages++;
        if ([[cell imageThree]image] == nil)
            blankImages++;
        if ([[cell imageFour]image] == nil)
            blankImages++;
        if ([[cell imageFive]image] == nil)
            blankImages++;
        
        
        if (anotherAwardsCount < 5-blankImages && tableViewLoads !=1)
        {
            if (anotherAwardsCount ==4)
                cell.imageFive.image = nil;
            else if (anotherAwardsCount ==3)
                cell.imageFour.image = nil;
            else if (anotherAwardsCount ==2)
                cell.imageThree.image = nil;
            else if (anotherAwardsCount ==1)
                cell.imageTwo.image = nil;
            
        }
        tableViewLoads++;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }
    
   
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    fiberAwardsCount = [[LogItemStore sharedStore]countFiberAwardsSet];
    fluidsAwardsCount =[[LogItemStore sharedStore]countFluidTypesSet];
    poopAwardsCount = [[OutputLogItemStore sharedStore]countPoopAwardsSet];
    peeAwardsCount = [[OutputLogItemStore sharedStore]countPeeAwardsSet];
    leavingPageNumber = pageControl.currentPage;
    [super viewWillDisappear:animated];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if (tableView == tableViewFiber)
    {
        int rows = [[LogItemStore sharedStore]countFiberAwardsSet];
        fiberAwardsCount = [[LogItemStore sharedStore]countFiberAwardsSet];
        
        int rowsToReturn = rows / 5;
        int remainder = rows % 5;
        if (rows == 0) {
            return 0;
        }
        if (rowsToReturn >0)
        {
            if (remainder >0)
            {
                return rowsToReturn + 1;
            }
            return rowsToReturn ;
            
        }
        else
            return 1;
        
    }
    
    else if (tableView ==tableViewFluid)
    {
        
        int rows = [[LogItemStore sharedStore]countFluidTypesSet];
        fluidsAwardsCount = [[LogItemStore sharedStore]countFluidTypesSet];
        int rowsToReturn = rows / 5;
        int remainder = rows % 5;
        if (rows == 0) {
            return 0;
        }
        if (rowsToReturn >0)
        {
            if (remainder >0)
            {
                return rowsToReturn + 1;
            }
            return rowsToReturn ;
        }
        else
            return 1;
        
    }
    else if (tableView == tableViewPoop)
    {
        int rows = [[OutputLogItemStore sharedStore]countPoopAwardsSet];
        poopAwardsCount = [[OutputLogItemStore sharedStore]countPoopAwardsSet];
        int rowsToReturn = rows / 5;
        int remainder = rows % 5;
        if (rows == 0) {
            return 0;
        }
        if (rowsToReturn >0)
        {
            if (remainder >0)
            {
                return rowsToReturn + 1;
            }
            return rowsToReturn ;
        }
        else
            return 1;
    }
    else
    {
        int rows = [[OutputLogItemStore sharedStore]countPeeAwardsSet];
        peeAwardsCount = [[OutputLogItemStore sharedStore]countPeeAwardsSet];
        int rowsToReturn = rows / 5;
        int remainder = rows % 5;
        if (rows == 0) {
            return 0;
        }
        if (rowsToReturn >0)
        {
            if (remainder >0)
            {
                return rowsToReturn + 1;
            }
            return rowsToReturn ;
        }
        else
            return 1;
        
    }
}

-(void)showBannerView:(ADBannerView *)bannerView animated:(BOOL)animated
{
  
    
}
-(void)hideBannerView:(ADBannerView *)bannerView animated:(BOOL)animated
{
   
}

@end
