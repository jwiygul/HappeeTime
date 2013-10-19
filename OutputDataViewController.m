//
//  OutputDataViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "OutputDataViewController.h"
#import "OutputLogItemStore.h"
#import "OutputLogItemContainer.h"
#import "OutputLogItem.h"
#import "DataViewCell.h"
#import "OutputDataViewCell.h"
#import "PickerDataSource.h"
#import "OutputTypePickerSource.h"
#import "PeeQualityPickerSource.h"
#import "PeeAccidentQualityPickerSource.h"
#import "PoopQualityPickerSource.h"


@implementation OutputDataViewController
@synthesize dismissBlock,item,pickerGroupView,myDatePicker,myPickerView,rightBarButton,leftBarButton,outputTypePickerSource, peeQualityPickerSource, poopQualityPickerSource,peeAccidentQualityPickerSource, dateToolBar, typeToolBar, qualityToolBar, toolBarInUse, pickerViewInUse,datePickerInUse;
static int counter = 0;
-(void)qualityPickerButton:(id)sender
{
    
    if (self.pickerGroupView.superview == nil) {
        //myPickerView = [[UIPickerView alloc]init];
        NSComparisonResult result = [item.typeOutput compare:@"Pee accident"];
        NSComparisonResult peeResult = [item.typeOutput compare:@"Pee"];
        NSComparisonResult poopResult = [item.typeOutput compare:@"Poop"];
        ;
        if (result == NSOrderedSame && item.typeOutput != nil) {
            peeAccidentQualityPickerSource = [[PeeAccidentQualityPickerSource alloc]init];
            [myPickerView setDataSource:peeAccidentQualityPickerSource];
            [myPickerView setDelegate:peeAccidentQualityPickerSource];
            [peeAccidentQualityPickerSource setItem:item];
        }
        else if (peeResult ==NSOrderedSame && item.typeOutput != nil){
            peeQualityPickerSource = [[PeeQualityPickerSource alloc]init];
            [myPickerView setDataSource:peeQualityPickerSource];
            [myPickerView setDelegate:peeQualityPickerSource];[peeQualityPickerSource setItem:item];
        }
        else if (poopResult == NSOrderedSame && item.typeOutput != nil)
        {
            poopQualityPickerSource = [[PoopQualityPickerSource alloc]init];
            
            [myPickerView setDataSource:poopQualityPickerSource];
            [myPickerView setDelegate:poopQualityPickerSource];
            [poopQualityPickerSource setItem:item];
        }
        else
            return;
        
        datePickerInUse = NO;
        

        pickerGroupView = [[UIView alloc]initWithFrame:[[self view]frame]];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(typeDone:)];
        [bbi setTintColor:[UIColor whiteColor]];
        NSArray *bArray = [NSArray arrayWithObjects:bbi, nil];
        qualityToolBar = [[UIToolbar alloc]init];
        [qualityToolBar setItems:bArray animated:NO];
        [qualityToolBar setBarStyle:UIBarButtonSystemItemAction];
        [pickerGroupView addSubview: myPickerView];
        
        [pickerGroupView addSubview:qualityToolBar];
        toolBarInUse = qualityToolBar;
        pickerViewInUse = myPickerView;
        qualityToolBar.translucent = NO;
        qualityToolBar.barTintColor = [UIColor blackColor];
        [[[self view]window] addSubview:pickerGroupView];
        
        
        CGSize rect = [qualityToolBar sizeThatFits:CGSizeZero];
        
        CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
      
        
        CGPoint recr = CGPointMake(0.0, 0.0);
        recr.x = pickerGroupView.frame.origin.x;
        recr.y = pickerGroupView.frame.origin.y;
        
        
        qualityToolBar.frame = CGRectMake(recr.x, recr.y, rect.width, rect.height);
        myPickerView.frame = CGRectMake(0.0, recr.y + qualityToolBar.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);

        CGRect startRect;
        CGSize pickerGroupSize = [pickerGroupView sizeThatFits:CGSizeZero];
        
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
            if ([self interfaceOrientation] == UIDeviceOrientationLandscapeLeft) {
                startRect = CGRectMake(-screenRect.size.height, screenRect.origin.y + (pickerGroupSize.width/2)- [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                pickerGroupView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
            }
            else{
                startRect = CGRectMake(screenRect.size.height, screenRect.origin.y+ (pickerGroupSize.width/2)- [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                pickerGroupView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
            }
        }
        else
            startRect = CGRectMake(screenRect.size.width/2 - myPickerView.frame.size.width/2, screenRect.origin.y + screenRect.size.height, pickerGroupSize.width, pickerGroupSize.height);
        
        pickerGroupView.frame = startRect;

        
        //compute ENDING FRAME
        
        CGRect pickRect;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
            if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
                if ([self interfaceOrientation] == UIDeviceOrientationLandscapeLeft)
                    pickRect = CGRectMake(screenRect.origin.x - myPickerView.frame.size.height-2*qualityToolBar.frame.size.height, screenRect.origin.y + myPickerView.frame.size.width/2 - [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                
                else
                    pickRect = CGRectMake(screenRect.origin.x + (2*myPickerView.frame.size.height), screenRect.origin.y + myPickerView.frame.size.width/2 -1.5*[UIApplication sharedApplication].statusBarFrame.size.width+2.0, pickerGroupSize.height, pickerGroupSize.width);
            }
            else
                pickRect = CGRectMake(screenRect.size.width/2 - myPickerView.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - myPickerView.frame.size.height - qualityToolBar.frame.size.height, pickerGroupSize.width, pickerGroupSize.height);
        }
        else
            pickRect = CGRectMake(0.0, screenRect.origin.y +screenRect.size.height - myPickerView.frame.size.height - qualityToolBar.frame.size.height, pickerGroupSize.width, pickerGroupSize.height);
        
        pickerGroupView.backgroundColor = [UIColor whiteColor];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        pickerGroupView.frame = pickRect;
        
        [[self view]setAlpha:0.5];
        [[self view]setBackgroundColor:[UIColor blackColor]];
        [[self navigationItem]setRightBarButtonItem:nil];
        [[self navigationItem]setLeftBarButtonItem:nil];
        [UIView commitAnimations];
        
    }
}
- (IBAction)typePickerButton:(id)sender
{
    
    if (self.pickerGroupView.superview == nil) {
        myPickerView = [[UIPickerView alloc]init];
        outputTypePickerSource = [[OutputTypePickerSource alloc]init];
        [myPickerView setDataSource:outputTypePickerSource];
        [myPickerView setDelegate:outputTypePickerSource];
        [myPickerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
        myPickerView.showsSelectionIndicator = YES;
        [outputTypePickerSource setItem:item];
       
        
        pickerGroupView = [[UIView alloc]initWithFrame:[[self view]frame]];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(typeDone:)];
        [bbi setTintColor:[UIColor whiteColor]];
        NSArray *bArray = [NSArray arrayWithObjects:bbi, nil];
        typeToolBar = [[UIToolbar alloc]init];
        [typeToolBar setItems:bArray animated:NO];
        [typeToolBar setBarStyle:UIBarButtonSystemItemAction];
        [pickerGroupView addSubview: myPickerView];
        [pickerGroupView addSubview:typeToolBar];
        toolBarInUse = typeToolBar;
        pickerViewInUse = myPickerView;
        datePickerInUse = NO;
        [[[self view]window] addSubview:pickerGroupView];
       
        typeToolBar.translucent = NO;
        typeToolBar.barTintColor = [UIColor blackColor];
        CGSize rect = [typeToolBar sizeThatFits:CGSizeZero];
        
        CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
        
        
        CGPoint recr = CGPointMake(0.0, 0.0);
      
        recr.x = pickerGroupView.frame.origin.x;
        recr.y = pickerGroupView.frame.origin.y;
        
        
        typeToolBar.frame = CGRectMake(recr.x, recr.y, rect.width, rect.height);
        myPickerView.frame = CGRectMake(0.0, recr.y + typeToolBar.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        
        //size picker view group to screen and CREATE STARTING FRAME
        CGSize pickerGroupSize = [pickerGroupView sizeThatFits:CGSizeZero];
        CGRect startRect;
        
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
            if ([self interfaceOrientation] == UIDeviceOrientationLandscapeLeft) {
                startRect = CGRectMake(-screenRect.size.height, screenRect.origin.y + (pickerGroupSize.width/2)- [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                pickerGroupView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
            }
            else{
                startRect = CGRectMake(screenRect.size.height, screenRect.origin.y+ (pickerGroupSize.width/2)- [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                pickerGroupView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
            }
        }
        else
            startRect = CGRectMake(screenRect.size.width/2 - myPickerView.frame.size.width/2, screenRect.origin.y + screenRect.size.height, pickerGroupSize.width, pickerGroupSize.height);
        
        pickerGroupView.frame = startRect;
        
        //compute ENDING FRAME
        
        CGRect pickRect;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
            if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
                if ([self interfaceOrientation] == UIDeviceOrientationLandscapeLeft)
                    pickRect = CGRectMake(screenRect.origin.x - myPickerView.frame.size.height-2*typeToolBar.frame.size.height, screenRect.origin.y + myPickerView.frame.size.width/2 - [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                
                else
                    pickRect = CGRectMake(screenRect.origin.x + (2*myPickerView.frame.size.height), screenRect.origin.y + myPickerView.frame.size.width/2 -1.5*[UIApplication sharedApplication].statusBarFrame.size.width+2.0, pickerGroupSize.height, pickerGroupSize.width);
            }
            else
                pickRect = CGRectMake(screenRect.size.width/2 - myPickerView.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - myPickerView.frame.size.height - typeToolBar.frame.size.height, pickerGroupSize.width, pickerGroupSize.height);
        }
        else
            pickRect = CGRectMake(0.0, screenRect.origin.y +screenRect.size.height - myPickerView.frame.size.height - typeToolBar.frame.size.height, pickerGroupSize.width, pickerGroupSize.height);
        
        pickerGroupView.backgroundColor = [UIColor whiteColor];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        pickerGroupView.frame = pickRect;
        
        [[self view]setAlpha:0.5];
        [[self view]setBackgroundColor:[UIColor blackColor]];
        [[self navigationItem]setRightBarButtonItem:nil];
        [[self navigationItem]setLeftBarButtonItem:nil];
        [UIView commitAnimations];
       
    }
    
}
-(void)timePickerButton:(id)sender
{
    if (self.pickerGroupView.superview == nil) {
        myDatePicker = [[UIDatePicker alloc]init];
        [myDatePicker setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
        
        myDatePicker.datePickerMode = UIDatePickerModeTime;
        
        pickerGroupView = [[UIView alloc]initWithFrame:[[self view]frame]];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(typeDone:)];
        [bbi setTintColor:[UIColor whiteColor]];
        NSArray *bArray = [NSArray arrayWithObjects:bbi, nil];
        dateToolBar = [[UIToolbar alloc]init];
        [dateToolBar setItems:bArray animated:NO];
        [dateToolBar setBarStyle:UIBarButtonSystemItemAction];
        [pickerGroupView addSubview: myDatePicker];
        [pickerGroupView addSubview:dateToolBar];
        toolBarInUse = dateToolBar;
        datePickerInUse = YES;
        dateToolBar.translucent = NO;
        dateToolBar.barTintColor = [UIColor blackColor]
        ;
        
        [[[self view]window] addSubview:pickerGroupView];
        CGPoint recr = CGPointMake(0.0, 0.0);
        recr.y = pickerGroupView.frame.origin.y;
        recr.x = pickerGroupView.frame.origin.x;
        
        
        CGSize rect = [dateToolBar sizeThatFits:CGSizeZero];
        
        CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
        
        
        
        
       
        dateToolBar.frame = CGRectMake(recr.x, recr.y, rect.width, rect.height);
        myDatePicker.frame = CGRectMake(0.0, recr.y + dateToolBar.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        
        
        
        //SIZE PICKER GROUP VIEW TO FRAME AND START FRAME
        CGSize pickerGroupSize = [pickerGroupView sizeThatFits:CGSizeZero];
        CGRect startRect;
        
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
            if ([self interfaceOrientation] == UIDeviceOrientationLandscapeLeft) {
                startRect = CGRectMake(-screenRect.size.height, screenRect.origin.y + (pickerGroupSize.width/2)- [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                pickerGroupView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
            }
            else{
                startRect = CGRectMake(screenRect.size.height, screenRect.origin.y+ (pickerGroupSize.width/2)- [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                pickerGroupView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
            }
        }
        else
            startRect = CGRectMake(screenRect.size.width/2 - myDatePicker.frame.size.width/2, screenRect.origin.y + screenRect.size.height, pickerGroupSize.width, pickerGroupSize.height);
        pickerGroupView.frame = startRect;

        //compute ENDING FRAME 
        
        CGRect pickRect;
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad)
        {
            if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
                if ([self interfaceOrientation] == UIDeviceOrientationLandscapeLeft)
                    pickRect = CGRectMake(screenRect.origin.x - myDatePicker.frame.size.height - 2*dateToolBar.frame.size.height, screenRect.origin.y + myDatePicker.frame.size.width/2 - [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                
                else
                    pickRect = CGRectMake(screenRect.origin.x + (2*myDatePicker.frame.size.height), screenRect.origin.y + myDatePicker.frame.size.width/2 -1.5*[UIApplication sharedApplication].statusBarFrame.size.width+2.0, pickerGroupSize.height, pickerGroupSize.width);
            }
            else
            pickRect = CGRectMake(screenRect.size.width/2 - myDatePicker.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - myDatePicker.frame.size.height - dateToolBar.frame.size.height, pickerGroupSize.width, pickerGroupSize.height);
        }
        else
            pickRect = CGRectMake(0.0, screenRect.origin.y +screenRect.size.height - myDatePicker.frame.size.height - dateToolBar.frame.size.height , pickerGroupSize.width, pickerGroupSize.height);
       
        
        
        
        pickerGroupView.backgroundColor = [UIColor whiteColor
                                           ];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        
        
        [UIView setAnimationDelegate:self];
        pickerGroupView.frame = pickRect;
        
         
       
        
        [[self view]setAlpha:0.5];
        [[self view]setBackgroundColor:[UIColor blackColor]];
        [[self navigationItem]setRightBarButtonItem:nil];
        [[self navigationItem]setLeftBarButtonItem:nil];
        [UIView commitAnimations];
        
    }
    
}
-(BOOL)shouldAutorotate
{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    if (datePickerInUse == YES)
    {
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation]))
    {
        if (([self interfaceOrientation]) == UIDeviceOrientationLandscapeLeft)
        {
            pickerGroupView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
            pickerGroupView.frame = CGRectMake(screenRect.origin.x - myDatePicker.frame.size.height -2*toolBarInUse.frame.size.height, screenRect.origin.y + myDatePicker.frame.size.width/2 - toolBarInUse.frame.size.height/2 - 6.0, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
            
        }
        else if (([self interfaceOrientation]) == UIDeviceOrientationLandscapeRight)
        {
            pickerGroupView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5) ;
            pickerGroupView.frame = CGRectMake(screenRect.origin.x + (2*myDatePicker.frame.size.height), screenRect.origin.y + myDatePicker.frame.size.width/2 -toolBarInUse.frame.size.height/2 - 6.0, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        }
    }
    else if (UIDeviceOrientationIsPortrait([self interfaceOrientation]))
    {
        if (fromInterfaceOrientation == UIDeviceOrientationLandscapeLeft)
        {
            pickerGroupView.transform = CGAffineTransformMakeRotation(M_PI * 2.0);
            pickerGroupView.frame = CGRectMake(screenRect.size.width/2 - myDatePicker.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - myDatePicker.frame.size.height - toolBarInUse.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        }
        else if (fromInterfaceOrientation == UIDeviceOrientationLandscapeRight)
        {
            pickerGroupView.transform = CGAffineTransformMakeRotation(-M_PI * 2.0);
            pickerGroupView.frame = CGRectMake(screenRect.size.width/2 - myDatePicker.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - myDatePicker.frame.size.height - toolBarInUse.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        }
    }
    }
    
    else
    {
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
            if (([self interfaceOrientation]) == UIDeviceOrientationLandscapeLeft) {
                pickerGroupView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
                pickerGroupView.frame = CGRectMake(screenRect.origin.x - pickerViewInUse.frame.size.height - 2*toolBarInUse.frame.size.height, screenRect.origin.y + pickerViewInUse.frame.size.width/2 - (toolBarInUse.frame.size.height * 0.5)-6.0, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
            }
            else if (([self interfaceOrientation]) == UIDeviceOrientationLandscapeRight)
            {
                pickerGroupView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5) ;
                pickerGroupView.frame = CGRectMake(screenRect.origin.x + (2*pickerViewInUse.frame.size.height), screenRect.origin.y + pickerViewInUse.frame.size.width/2 -toolBarInUse.frame.size.height/2  - 6.0, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
            }
        }
        else if (UIDeviceOrientationIsPortrait([self interfaceOrientation]))
        {
            if (fromInterfaceOrientation == UIDeviceOrientationLandscapeLeft)
            {
                pickerGroupView.transform = CGAffineTransformMakeRotation(M_PI * 2.0);
                pickerGroupView.frame = CGRectMake(screenRect.size.width/2 - pickerViewInUse.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - pickerViewInUse.frame.size.height - toolBarInUse.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
            }
            else if (fromInterfaceOrientation == UIDeviceOrientationLandscapeRight)
            {
                pickerGroupView.transform = CGAffineTransformMakeRotation(-M_PI * 2.0);
                pickerGroupView.frame = CGRectMake(screenRect.size.width/2 - pickerViewInUse.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - pickerViewInUse.frame.size.height - toolBarInUse.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
            }
        }
        
    }

            
}
-(void)typeDone:(id)sender
{
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    CGRect endFrame = self.pickerGroupView.frame;
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
        if ([self interfaceOrientation] == UIDeviceOrientationLandscapeRight) 
            endFrame.origin.x += 760.0;
        else
        endFrame.origin.x -= 760.0;
    }
    else
    endFrame.origin.y = screenRect.origin.y + screenRect.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(slideDownDidStop:)];
    [[self view]setAlpha:1.0];
    [[self view]setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    self.pickerGroupView.frame = endFrame;
    
    [item setTimeCreated:myDatePicker.date];
    
    [UIView commitAnimations];
    [[self navigationItem]setRightBarButtonItem:rightBarButton animated:NO];
    [[self navigationItem]setLeftBarButtonItem:leftBarButton animated:NO];
}
-(void)slideDownDidStop:(id)sender
{
    [self.pickerGroupView removeFromSuperview];
    self.pickerGroupView = nil;
    
    [[self tableView]reloadData];
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        [n setTitle:@"Enter Your Data!"];
        rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveData:)];
        [n setRightBarButtonItem:rightBarButton];
        leftBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        [n setLeftBarButtonItem:leftBarButton];
        
        
    }
    return self;
}

-(void)saveData:(id)sender
{
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:dismissBlock];
}
-(id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"OutputDataViewCell" bundle:nil];
    [[self tableView]registerNib:nib forCellReuseIdentifier:@"OutputDataViewCell"];
    self.tableView.rowHeight = 152.0;
    
}


-(void)cancel:(id)sender
{
    [[OutputLogItemStore sharedStore]removeItem:item];
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:dismissBlock];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int cot = [[[[OutputLogItemStore sharedStore]outputLogItemContainer]outputLogItems]count] - 1;
    
    OutputLogItem *i = [[[[OutputLogItemStore sharedStore]outputLogItemContainer]outputLogItems] objectAtIndex:cot];
    
    
    OutputDataViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutputDataViewCell"];
    [cell setController:self];
    [cell setTableView:tableView];
    [[cell typeField]setText:[i typeOutput]];
    
    
    
    [[cell qualityField]setText:[i qualityOutput]];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    NSString *dateString = [formatter stringFromDate:[i timeCreated]];
    [[cell timeField]setText:dateString];
    if (counter == 0) {
    int divisor = RAND_MAX/5;
    int retval;
    do{
        retval = rand()/divisor;
    }while (retval >5);
    
    if (retval % 5 == 0) {
        [[cell randomImage]setImage:[UIImage imageNamed:@"AwardCase.png"]];
    }
    else if (retval % 5 == 1)
        [[cell randomImage]setImage:[UIImage imageNamed:@"warningIcon.png"]];
    else if (retval % 5 == 2)
        [[cell randomImage]setImage:[UIImage imageNamed:@"starsPS.png"]];
    else if (retval %5 ==3)
        [[cell randomImage]setImage:[UIImage imageNamed:@"otherHelpfulIcon.png"]];
    else
        [[cell randomImage]setImage:[UIImage imageNamed:@"explosionPhone.png"]];
        counter++;
    }
   
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    int count = [[[OutputLogItemStore sharedStore]itemContainer]count];
    int totalItems = [[[OutputLogItemStore sharedStore]itemContainer]count];
    
    OutputLogItemContainer *itemer = [[[OutputLogItemStore sharedStore]itemContainer]objectAtIndex:totalItems -1];
    
    
    NSComparisonResult result = [item.typeOutput compare:@"Pee accident"];
    NSComparisonResult result1 = [item.typeOutput compare:@"Pee"];
    NSComparisonResult poopResult = [item.typeOutput compare:@"Poop"];
    if (result == NSOrderedSame && item.typeOutput != nil && [[[[OutputLogItemStore sharedStore]outputLogItemContainer]outputLogItems] containsObject:item])
        [[[OutputLogItemStore sharedStore]outputLogItemContainer]setDidHavePeeAccident:YES];
    else if (poopResult == NSOrderedSame && item.typeOutput != nil&& [[[[OutputLogItemStore sharedStore]outputLogItemContainer]outputLogItems] containsObject:item])
    {
        [[[OutputLogItemStore sharedStore]outputLogItemContainer]setDidPoopToday:YES];
        for (int i = count-1; i > -1; i--)
        {
            OutputLogItemContainer *itemContainer = [[[OutputLogItemStore sharedStore]itemContainer]objectAtIndex:i];
            
            if (itemContainer.didPoopToday == NO || itemContainer.alreadySetPoopAward ==YES)
                break;
            itemer = itemContainer;
            
        }
        OutputLogItemContainer *otherContainer = [[[OutputLogItemStore sharedStore]itemContainer]lastObject];
        NSDate *containerDate = otherContainer.dateCreated;
        NSTimeInterval timeSinceAccident = [itemer.dateCreated timeIntervalSinceDate:containerDate];
        double daysSinceLastAccident = (0-timeSinceAccident)/86400.0;
        
        if (daysSinceLastAccident > 4.0  && otherContainer.alreadySetPoopAward == NO)
        {
            item.infoType = @"poopStar";
            [[OutputLogItemStore sharedStore]alreadySetPoopAward];
            NSNotification *note = [NSNotification notificationWithName:@"newPoopMeritBadge" object:nil];
            [[NSNotificationCenter  defaultCenter]postNotification:note];
        }

    }
    
    else if (result1 == NSOrderedSame && item.typeOutput !=nil&& [[[[OutputLogItemStore sharedStore]outputLogItemContainer]outputLogItems] containsObject:item])
    {
        
        for (int i = count-1; i > -1; i--)
        {
            OutputLogItemContainer *itemContainer = [[[OutputLogItemStore sharedStore]itemContainer]objectAtIndex:i];
            
            if (itemContainer.didHavePeeAccident == YES ||itemContainer.alreadySetPeeAward ==YES)
                break;
            itemer = itemContainer;
            
        }
        OutputLogItemContainer *otherContainer = [[[OutputLogItemStore sharedStore]itemContainer]lastObject];
        NSDate *containerDate = otherContainer.dateCreated;
        NSTimeInterval timeSinceAccident = [itemer.dateCreated timeIntervalSinceDate:containerDate];
        double daysSinceLastAccident = (0-timeSinceAccident)/86400.0;
        if (daysSinceLastAccident > 3.0 && otherContainer.alreadySetPeeAward == NO )
            
        {
            item.infoType = @"Dryness";
            [[OutputLogItemStore sharedStore]alreadySetPeeAward];
            NSNotification *note = [NSNotification notificationWithName:@"newPeeMeritBadge" object:nil];
            [[NSNotificationCenter  defaultCenter]postNotification:note];
        }
    }
    counter = 0;
}

@end
