//
//  IntakeViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "IntakeViewController.h"
#import "LogItemContainer.h"
#import "FiberAwardViewController.h"
#import "FluidAwardViewController.h"

@implementation IntakeViewController
{
    ADBannerView *myBannerView;
}
@synthesize tableView,toolBar,topToolBar,leftTopToolBarButtonItem,barItemForward,dateButton,addButton,editButton,item;

static int number=1;


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LogItem *p = [[[[LogItemStore sharedStore]logItemContainer]logItems] objectAtIndex:[indexPath row]];
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
    [formatter1 setDateStyle:NSDateFormatterNoStyle];
    [formatter1 setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *time = [formatter1 stringFromDate:[p timeCreated]];
    NSString *timeOther = [formatter1 stringFromDate:[p dateCreated]];
    VoidingLogCell *voidingCell = [[VoidingLogCell alloc]init];
   
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPad) {
        voidingCell = [[self tableView] dequeueReusableCellWithIdentifier:@"VoidingLogCellPad"];
    }
    else
    voidingCell = [[self tableView] dequeueReusableCellWithIdentifier:@"VoidingLogCell"];
    
    [voidingCell setController:self];
    [voidingCell setTableView:[self tableView]];
    NSNumber *amount = [p amountIntake];
    if (amount == NULL) {
        [[voidingCell amountLabel]setText:@""];
    }
    else{
        NSComparisonResult result = [p.typeIntake compare:@"Fiber"];
        if (result == NSOrderedSame) {
            [[voidingCell amountLabel]setText:[NSString stringWithFormat:@"%@ gm",amount]];
        }
        else if (result == NSOrderedAscending)
            [[voidingCell  amountLabel]setText:[NSString stringWithFormat:@"%@ oz", amount]];
        else
            [[voidingCell amountLabel]setText:@""];
    }
    
    
    //this section determines whether to display a fiber or fluid award image, taking into account past editing
    NSComparisonResult result = [p.infoType compare:@"Football"];
    NSComparisonResult result1 = [p.infoType compare:@"Basketball"];
    
    if (p.infoType == nil || (p.infoType != nil && result == NSOrderedSame && [[[LogItemStore sharedStore]logItemContainer]alreadySetFiberAward] ==NO) || (p.infoType != nil && result1 ==NSOrderedSame &&[[[LogItemStore sharedStore]logItemContainer]alreadySetFluidAward] == NO))
    {
        [voidingCell setCharacter:nil withInfoType:nil];
        [[[[[LogItemStore sharedStore]logItemContainer]logItems] objectAtIndex:[indexPath row]]setInfoType:nil];
            }
    
    else if (p.infoType !=nil) {
        if (result == NSOrderedSame && [[[LogItemStore sharedStore]logItemContainer]alreadySetFiberAward] ==YES) {
            if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad) {
                [voidingCell setCharacter:[UIImage imageNamed:@"explosionPad.png"] withInfoType:nil];
            }
            else
            [voidingCell setCharacter:[UIImage imageNamed:@"explosionPhone.png"] withInfoType:nil];
            
        }
        else if (result1 == NSOrderedSame && [[[LogItemStore sharedStore]logItemContainer]alreadySetFluidAward] == YES)
        {
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                [voidingCell setCharacter:[UIImage imageNamed:@"ThumbsUpiPad.png"] withInfoType:nil];
            else
                [voidingCell setCharacter:[UIImage imageNamed:@"HPThumbsUpiPhone.png"] withInfoType:nil];
          
        }
        else
            [voidingCell setCharacter:nil withInfoType:nil];
        
    }
    else
        [voidingCell setCharacter:nil withInfoType:nil];
 
  
    if (p.timeCreated == nil) {
        [[voidingCell timeLabel]setText:timeOther];
    }
    else
        [[voidingCell timeLabel]setText:time];
    
    [[voidingCell whatLabel]setText:[p whatIntake]];
    [[voidingCell typeLabel]setText:[p typeIntake]];
    [voidingCell setSelectionStyle:UITableViewCellSelectionStyleNone];
   
    
    return voidingCell;
}
-(NSUInteger)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else
        return UIInterfaceOrientationMaskPortrait;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[LogItemStore sharedStore]logItemContainer]logItems]count];
}


-(id)init
{
    self = [super initWithNibName:@"IntakeViewController" bundle:nil];
    if (self) {
        self.tabBarItem.title = @"Intake";
        self.tabBarItem.image = [UIImage imageNamed:@"inputgreys.png"];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(updateDate) name:@"newDay" object:nil];
        
    }
    return self;
}

-(void)updateDate
{
    [tableView reloadData];
    NSDate *date = [[[LogItemStore sharedStore]logItemContainer]dateCreated];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateString = [formatter stringFromDate:date];
    [dateButton setTitle:dateString];
    barItemForward.enabled = NO;
    addButton.enabled = YES;
    leftTopToolBarButtonItem.enabled = YES;
    number = 1;

}
-(void)loadView
{
    
    CGRect rect = [[UIScreen mainScreen]bounds];
    UIView *view = [[UIView alloc]initWithFrame:rect];
    
    [self setView:view];
    
    
}

-(IBAction)addItem:(id)sender
{
    LogItem *newItem = [[LogItemStore sharedStore]createItem];
    DataViewController *dvc = [[DataViewController alloc]init];
    [dvc setItem:newItem];
    [dvc setDismissBlock:^{
        [tableView reloadData];
    }];
    UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:dvc];
    
    [navCom setModalPresentationStyle:UIModalPresentationFormSheet];
    [navCom setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navCom animated:YES completion:nil];
    
}

-(void)viewDidLoad
{
   
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"VoidingLogCell" bundle:nil];
    UINib *padNib = [UINib nibWithNibName:@"VoidingLogCellPad" bundle:nil];
    CGRect frame = [[UIScreen mainScreen]applicationFrame];
   
    
    tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    toolBar = [[UIToolbar alloc]init];
    topToolBar = [[UIToolbar alloc]init];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [tableView registerNib:padNib forCellReuseIdentifier:@"VoidingLogCellPad"];
    }
    else
    [tableView registerNib:nib forCellReuseIdentifier:@"VoidingLogCell"];
    
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [toolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [topToolBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    [[self view]addSubview:tableView];
    [[self view] addSubview:toolBar];
    [[self view]addSubview:topToolBar];
    [self view].autoresizesSubviews=YES;
    [self view].autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    CGSize rect = [toolBar sizeThatFits:CGSizeZero];
    CGSize topRect = [topToolBar sizeThatFits:CGSizeZero];
    CGRect topToolRect;
    CGRect toolRect;
   
    
    if ((UIDeviceOrientationIsLandscape([self interfaceOrientation]) && [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone)) {
        topToolRect = CGRectMake(0.0, screenRect.origin.y, topRect.width, topRect.height+0.5*[UIApplication sharedApplication].statusBarFrame.size.width);
        topToolBar.frame = topToolRect;
        toolRect = CGRectMake(0.0, screenRect.origin.y+topToolRect.size.height, rect.width, rect.height);
        toolBar.frame = toolRect;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BlueBackgroundPad.png"]];
        self.tableView.backgroundView = imageView;
        
    }
    else
    {
        topToolRect = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, topRect.width, topRect.height+0.5*[UIApplication sharedApplication].statusBarFrame.size.height);
        topToolBar.frame = topToolRect;
        toolRect = CGRectMake(0.0, screenRect.origin.y+rect.height-0.5*[UIApplication sharedApplication].statusBarFrame.size.height, rect.width, rect.height);
        toolBar.frame = toolRect;
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"BlueBackgroundPad.png"]];
        self.tableView.backgroundView = imageView;
    }
    
   
    addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    leftTopToolBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(startEdit:)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *title = [[UIBarButtonItem alloc]init];
    
    
    NSDate *date = [[[LogItemStore sharedStore]logItemContainer]dateCreated];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateString = [formatter stringFromDate:date];
   
    dateButton = [[UIBarButtonItem alloc]init];
    
    
    NSArray *barButtonArray = [NSArray arrayWithObjects:leftTopToolBarButtonItem,flexSpace,title,flexSpace, addButton,nil];
    
    [topToolBar setItems:barButtonArray];
    topToolBar.translucent=NO;
    topToolBar.tintColor = [UIColor whiteColor];
    topToolBar.barTintColor =[UIColor blackColor];
    toolBar.translucent=NO;
    toolBar.tintColor = [UIColor whiteColor];
    toolBar.barTintColor=[UIColor grayColor];
    
    [title setTitle:@"INTAKE"];
    
    
    UIBarButtonItem *barBack = [[UIBarButtonItem alloc]initWithTitle:@"LookBack" style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
    
    barItemForward = [[UIBarButtonItem alloc]initWithTitle:@"LookForward" style:UIBarButtonItemStyleBordered target:self action:@selector(goForward:)];
    barItemForward.enabled = NO;
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                              target:nil
                                                                              action:nil];
    
    NSArray *barArray = [[NSArray alloc]initWithObjects:barBack, flexItem, dateButton, flexItem, barItemForward, nil];
    [toolBar setItems:barArray];
    myBannerView = [[ADBannerView alloc]init];
    [[self view]addSubview:myBannerView];
    myBannerView.delegate =self;
    CGRect bannerFrame = myBannerView.frame;
    bannerFrame.origin.y = frame.size.height;
    myBannerView.frame =bannerFrame;
    [dateButton setTitle:dateString];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.tableView.rowHeight = 175.0;
    }
    else
    self.tableView.rowHeight = 73.0;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    if ((UIDeviceOrientationIsLandscape([self interfaceOrientation]) && [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone)) {
        
        tableView.frame = CGRectMake(0.0, screenRect.origin.y +[UIApplication sharedApplication].statusBarFrame.size.width + topToolBar.frame.size.height, screenRect.size.height, screenRect.size.width-2*toolBar.frame.size.height);
    }
    else
    {
        tableView.frame = CGRectMake(0.0, screenRect.origin.y +topToolBar.frame.size.height, screenRect.size.width, screenRect.size.height-2*toolBar.frame.size.height);
    }
    [tableView reloadData];
    
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
        tableView.frame = CGRectMake(0.0, screenRect.origin.y+ [UIApplication sharedApplication].statusBarFrame.size.width+ topToolBar.frame.size.height, screenRect.size.width-(screenRect.size.width -screenRect.size.height), screenRect.size.height-2*toolBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.width);
       
        
    }
    else
    {
        tableView.frame = CGRectMake(0.0, screenRect.origin.y +topToolBar.frame.size.height, screenRect.size.width, screenRect.size.width-2*toolBar.frame.size.height);
    }
    
    [tableView reloadData];
}


-(void)startEdit:(id)sender
{
    
    NSString *titleString = leftTopToolBarButtonItem.title;
    NSString *compareString = @"Edit";
    NSComparisonResult result = [titleString compare:compareString];
    if (tableView.editing == YES && result == NSOrderedSame) {
        [tableView setEditing:NO animated:YES];
    }
    if (result == NSOrderedSame ){
        [leftTopToolBarButtonItem setTitle:@"Done"];
        [tableView setEditing:YES animated:YES];
    }
    else{
        [tableView setEditing:NO animated:YES];
        [leftTopToolBarButtonItem setTitle:@"Edit"];
    }
}

-(void)goBack:(id)sender
{
    number++;
    BOOL success = [[LogItemStore sharedStore]goBack:number];
    if (success){
        
        barItemForward.enabled = YES;
        addButton.enabled = NO;
        leftTopToolBarButtonItem.enabled = NO;
        NSDate *date = [[[LogItemStore sharedStore]logItemContainer]dateCreated];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        NSString *dateString = [formatter stringFromDate:date];
        [dateButton setTitle:dateString];
    }
    else
        number--;
    
    [tableView reloadData];
    return;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *todaysDate = [[NSDate alloc]init];
    NSDate *logDate = [[[LogItemStore sharedStore]logItemContainer]dateCreated];
    NSComparisonResult result = [self compareDate:todaysDate withDate:logDate];
    if (result==NSOrderedSame) {
        return YES;
    }
    else
        return NO;
}
-(void)goForward:(id)sender
{
    number--;
    [[LogItemStore sharedStore]goForward:number];
    NSDate *todaysDate = [[NSDate alloc]init];
    NSDate *logDate = [[[LogItemStore sharedStore]logItemContainer]dateCreated];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateString = [formatter stringFromDate:logDate];
    [dateButton setTitle:dateString];
    [tableView reloadData];
    
    NSComparisonResult result = [self compareDate:todaysDate withDate:logDate];
    if (result ==NSOrderedSame) {
        barItemForward.enabled = NO;
        addButton.enabled = YES;
        leftTopToolBarButtonItem.enabled = YES;
    }
    
    return;
}
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSComparisonResult result = [item.infoType compare:@"Football"];
    NSComparisonResult bResult = [item.infoType compare:@"Basketball"];
    
    int count = [[[[LogItemStore sharedStore]logItemContainer]logItems]count];
    int i = 0;
    if (item.infoType != nil && ![[[[LogItemStore sharedStore]logItemContainer]logItems] containsObject:item])
    {
        
        if (result == NSOrderedSame && [[[LogItemStore sharedStore]logItemContainer]alreadySetFiberAward] == YES)
        {
            
            for (i = count-1; i > 0; i--)
            {
                LogItem *compareItem = [[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i];
                NSComparisonResult fiberResult = [compareItem.typeIntake compare:@"Fiber"];
                if (fiberResult == NSOrderedSame && compareItem.typeIntake != nil)
                    break;
            }
            NSComparisonResult finalFiberResult = [[[[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i]typeIntake] compare:@"Fiber"];
            if (finalFiberResult == NSOrderedSame && [[[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i]typeIntake] !=nil )
            {
                [[[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i]setInfoType:@"Football"];
            }
            
        }
        else if (bResult == NSOrderedSame && [[[LogItemStore sharedStore]logItemContainer]alreadySetFluidAward] == YES)
        {
            
            for (i = count-1; i > 0; i--)
            {
                LogItem *compareItem = [[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i];
                NSComparisonResult fiberResult = [compareItem.typeIntake compare:@"Drink"];
                if (fiberResult == NSOrderedSame && compareItem.typeIntake != nil)
                    break;
            }
            NSComparisonResult finalFluidResult = [[[[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i]typeIntake] compare:@"Drink"];
            if (finalFluidResult == NSOrderedSame && [[[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i]typeIntake] != nil)
                [[[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i]setInfoType:@"Basketball"];
            
            
        }
    }
   
    [[self tableView] reloadData];
}

-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    item = [[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:[indexPath row]];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LogItemStore *lis = [LogItemStore sharedStore];
        LogItem *i = [[[lis logItemContainer]logItems]objectAtIndex:[indexPath row]];
        
        [lis removeItem:i];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


-(NSComparisonResult)compareDate:(NSDate*)date1 withDate:(NSDate *)date2
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *strOne = [formatter stringFromDate:date1];
    NSString *strTwo = [formatter stringFromDate:date2];
    NSComparisonResult result = [strOne compare:strTwo];
    return result;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}
-(void)seeInfoBehindImage:(id)sender atIndexPath:(NSIndexPath *)indexPath;
{
    LogItem *itemOfInterest = [[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:[indexPath row]];
    
    if (itemOfInterest.infoType != nil)
    {
        NSComparisonResult result = [itemOfInterest.infoType compare:@"Football"];
        if (result == NSOrderedSame)
        {
            FiberAwardViewController *favc = [[FiberAwardViewController alloc]init];
            UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:favc];
            
            [navCom setModalPresentationStyle:UIModalPresentationFormSheet];
            [navCom setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:navCom animated:YES completion:nil];
            
        }
        else if (result == NSOrderedAscending)
        {
            FluidAwardViewController *fluidView = [[FluidAwardViewController alloc]init];
            UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:fluidView];
            [navCom setModalPresentationStyle:UIModalPresentationFormSheet];
            [navCom setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            [self presentViewController:navCom animated:YES completion:nil];
        }
    }
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    myBannerView = banner;
    [myBannerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
    [myBannerView setAutoresizesSubviews:YES];
    CGRect screenFrame = [[UIScreen mainScreen]applicationFrame];
    CGRect frame;
    if ([UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])){
            frame = CGRectMake(0.0, screenFrame.origin.y+screenFrame.size.width-topToolBar.frame.size.height-toolBar.frame.size.height-5.0, self.view.frame.size.width, 0.0);
            tableView.frame = CGRectMake(0.0, screenFrame.origin.y +[UIApplication sharedApplication].statusBarFrame.size.width + topToolBar.frame.size.height, screenFrame.size.height, screenFrame.size.width-2*toolBar.frame.size.height);
        }
        else{
            frame = CGRectMake(0.0, screenFrame.origin.y+screenFrame.size.height-topToolBar.frame.size.height-toolBar.frame.size.height-[UIApplication sharedApplication].statusBarFrame.size.height-5.0, 0.0, 0.0);
            tableView.frame = CGRectMake(0.0, screenFrame.origin.y +topToolBar.frame.size.height, screenFrame.size.width, screenFrame.size.height-2*toolBar.frame.size.height-20.0);
        }
    }
    
    else{
        frame =CGRectMake(0.0, screenFrame.origin.y+screenFrame.size.height-topToolBar.frame.size.height-toolBar.frame.size.height, 0.0, 0.0);
        tableView.frame = CGRectMake(0.0, screenFrame.origin.y +topToolBar.frame.size.height, screenFrame.size.width, screenFrame.size.height-2*toolBar.frame.size.height-20.0);
    }
    myBannerView.frame =frame;
   
}
-(void)hideBannerView:(ADBannerView *)bannerView animated:(BOOL)animated
{
    myBannerView = nil;
}
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
   CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = myBannerView.frame;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation]))
        bannerFrame.origin.y = contentFrame.size.width;
        else
            bannerFrame.origin.y = contentFrame.size.height;
    }
    else
        bannerFrame.origin.y = contentFrame.size.height;
        myBannerView.frame = bannerFrame;
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    if ((UIDeviceOrientationIsLandscape([self interfaceOrientation]) && [UIDevice currentDevice].userInterfaceIdiom != UIUserInterfaceIdiomPhone)) {
        
        tableView.frame = CGRectMake(0.0, screenRect.origin.y +[UIApplication sharedApplication].statusBarFrame.size.width + topToolBar.frame.size.height, screenRect.size.height, screenRect.size.width-2*toolBar.frame.size.height);
    }
    else
    {
        tableView.frame = CGRectMake(0.0, screenRect.origin.y +topToolBar.frame.size.height, screenRect.size.width, screenRect.size.height-2*toolBar.frame.size.height);
    }
    [tableView reloadData];
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
