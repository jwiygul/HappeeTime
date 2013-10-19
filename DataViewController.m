//
//  DataViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "DataViewController.h"
#import "LogItemStore.h"
#import "FiberAmountPickerDataSource.h"
#import "DrinkTypePickerSource.h"


@implementation DataViewController
@synthesize dismissBlock, myPickerView, item, pickerGroupView,myDatePicker;
@synthesize amountPickerDataSource,whatPickerDataSource,pickerDataSource,fiberPickerDataSource, drinkTypePickerSource;
@synthesize rightBarButton,leftBarButton;
@synthesize typeToolBar,timeToolBar,whatToolBar,amountToolBar,toolBarInUse,pickerViewInUse,datePickerInUse;

static int counter = 0;
-(void)showTypeIntakePicker:(id)sender atIndexPath:(NSIndexPath *)path
{
    
    if (self.pickerGroupView.superview == nil) {
        
        myPickerView = [[UIPickerView alloc]init];
        [myPickerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
        
        pickerDataSource = [[PickerDataSource alloc]init];
        [myPickerView setDataSource:pickerDataSource];
        [myPickerView setDelegate:pickerDataSource];
        
        [pickerDataSource setItem:item];
        
        
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
        typeToolBar.translucent = NO;
        typeToolBar.barTintColor = [UIColor blackColor];
        [[[self view]window] addSubview:pickerGroupView];
        
        
        CGSize rect = [typeToolBar sizeThatFits:CGSizeZero];
        
        CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
        
        
                
        CGPoint recr = CGPointMake(0.0, 0.0);
        recr.x = pickerGroupView.frame.origin.x;
        recr.y = pickerGroupView.frame.origin.y;
        typeToolBar.frame = CGRectMake(recr.x, recr.y, rect.width, rect.height);
        myPickerView.frame = CGRectMake(0.0, recr.y + typeToolBar.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        
        // create STARTING FRAME
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
-(void)showTimePicker:(id)sender atIndexPath:(NSIndexPath *)path
{
    if (self.pickerGroupView.superview == nil) {
        myDatePicker = [[UIDatePicker alloc]init];
         [myDatePicker setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
        myDatePicker.datePickerMode = UIDatePickerModeTime;
        
        
        
        pickerGroupView = [[UIView alloc]initWithFrame:[[self view]frame]];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(typeDone:)];
        [bbi setTintColor:[UIColor whiteColor]];
        NSArray *bArray = [NSArray arrayWithObjects:bbi, nil];
        timeToolBar = [[UIToolbar alloc]init];
        [timeToolBar setItems:bArray animated:NO];
        [timeToolBar setBarStyle:UIBarButtonSystemItemAction];
        [pickerGroupView addSubview: myDatePicker];
        [pickerGroupView addSubview:timeToolBar];
        toolBarInUse = timeToolBar;
        datePickerInUse = YES;
        timeToolBar.translucent = NO;
        timeToolBar.barTintColor = [UIColor blackColor];
        [[[self view]window] addSubview:pickerGroupView];
        
        
        CGSize rect = [timeToolBar sizeThatFits:CGSizeZero];
        
        CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
        
        
        CGPoint recr = CGPointMake(0.0, 0.0);
        recr.y = pickerGroupView.frame.origin.y;
        recr.x = pickerGroupView.frame.origin.x;
        
        timeToolBar.frame = CGRectMake(recr.x, recr.y, rect.width, rect.height);
        myDatePicker.frame = CGRectMake(0.0, recr.y + timeToolBar.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        
        //STARTING FRAME
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
                    pickRect = CGRectMake(screenRect.origin.x - myDatePicker.frame.size.height - 2*timeToolBar.frame.size.height, screenRect.origin.y + myDatePicker.frame.size.width/2 - [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                
                else
                    pickRect = CGRectMake(screenRect.origin.x + (2*myDatePicker.frame.size.height), screenRect.origin.y + myDatePicker.frame.size.width/2 -1.5*[UIApplication sharedApplication].statusBarFrame.size.width+2.0, pickerGroupSize.height, pickerGroupSize.width);
            }
            else
                pickRect = CGRectMake(screenRect.size.width/2 - myDatePicker.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - myDatePicker.frame.size.height - timeToolBar.frame.size.height, pickerGroupSize.width, pickerGroupSize.height);
        }
        else
            pickRect = CGRectMake(0.0, screenRect.origin.y +screenRect.size.height - myDatePicker.frame.size.height - timeToolBar.frame.size.height , pickerGroupSize.width, pickerGroupSize.height);
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
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    if (datePickerInUse == YES) {
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
            if (([self interfaceOrientation]) == UIDeviceOrientationLandscapeLeft) {
                pickerGroupView.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
                pickerGroupView.frame = CGRectMake(screenRect.origin.x - myDatePicker.frame.size.height - 2*toolBarInUse.frame.size.height, screenRect.origin.y + myDatePicker.frame.size.width/2 - toolBarInUse.frame.size.height/2 - 6.0, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
                
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
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation]))
        {
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

-(void)slideDownDidStop:(id)sender
{
    [self.pickerGroupView removeFromSuperview];
    self.pickerGroupView = nil;
    [[self tableView]reloadData];
}
- (void)showWhatIntakePicker:(id)sender atIndexPath:(NSIndexPath *)path
{
    
    if (self.pickerGroupView.superview == nil) {
        myPickerView = [[UIPickerView alloc]init];
        NSComparisonResult result = [item.typeIntake compare:@"Fiber"];
        if (result == NSOrderedAscending && item.typeIntake != nil) {
            drinkTypePickerSource = [[DrinkTypePickerSource alloc]init];
            [myPickerView setDataSource:drinkTypePickerSource];
            [myPickerView setDelegate:drinkTypePickerSource];
            [drinkTypePickerSource setItem:item];
        }
        else if (result == NSOrderedDescending && item.typeIntake != nil)
        {
            whatPickerDataSource = [[WhatPickerDataSource alloc]init];
            [myPickerView setDataSource:whatPickerDataSource];
            [myPickerView setDelegate:whatPickerDataSource];
            [whatPickerDataSource setItem:item];
        }
        else{
            
            return;
        }
        
        [myPickerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
        
        
        pickerGroupView = [[UIView alloc]initWithFrame:[[self view]frame]];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(typeDone:)];
        [bbi setTintColor:[UIColor whiteColor]];
        NSArray *bArray = [NSArray arrayWithObjects:bbi, nil];
        whatToolBar = [[UIToolbar alloc]init];
        [whatToolBar setItems:bArray animated:NO];
        [whatToolBar setBarStyle:UIBarButtonSystemItemAction];
        [pickerGroupView addSubview: myPickerView];
        
        [pickerGroupView addSubview:whatToolBar];
        toolBarInUse = whatToolBar;
        datePickerInUse = NO;
        whatToolBar.translucent =NO;
        whatToolBar.barTintColor = [UIColor blackColor];
        [[[self view]window] addSubview:pickerGroupView];
        CGSize rect = [whatToolBar sizeThatFits:CGSizeZero];
        
        CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
        
        
        CGPoint recr = CGPointMake(0.0, 0.0);
        
        recr.x = pickerGroupView.frame.origin.x;
        recr.y = pickerGroupView.frame.origin.y;
        
        
        whatToolBar.frame = CGRectMake(recr.x, recr.y, rect.width, rect.height);
        myPickerView.frame = CGRectMake(0.0, recr.y + whatToolBar.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        
        //STARTING FRAME
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
                    pickRect = CGRectMake(screenRect.origin.x - myPickerView.frame.size.height - 2*typeToolBar.frame.size.height, screenRect.origin.y + myPickerView.frame.size.width/2- [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                
                
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

-(void)showAmountIntakePicker:(id)sender atIndexPath:(NSIndexPath *)path
{
    if (self.pickerGroupView.superview == nil) {
        myPickerView = [[UIPickerView alloc]init];
        NSComparisonResult result = [item.typeIntake compare:@"Fiber"];
        if (item.typeIntake !=nil)
        {
            if (result ==NSOrderedSame) {
                fiberPickerDataSource = [[FiberAmountPickerDataSource alloc]init];
                [myPickerView setDataSource:fiberPickerDataSource];
                [myPickerView setDelegate:fiberPickerDataSource];
                [fiberPickerDataSource setItem:item];
            }
            else if (result == NSOrderedAscending){
                amountPickerDataSource = [[AmountPickerDataSource alloc]init];
                [myPickerView setDataSource:amountPickerDataSource];
                [myPickerView setDelegate:amountPickerDataSource];
                [amountPickerDataSource setItem:item];
            }
            else
                return;
        }
        else
            return;
       
        [myPickerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin];
        
        pickerGroupView = [[UIView alloc]initWithFrame:[[self view]frame]];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemDone target:self action:@selector(typeDone:)];
        [bbi setTintColor:[UIColor whiteColor]];
        NSArray *bArray = [NSArray arrayWithObjects:bbi, nil];
        amountToolBar = [[UIToolbar alloc]init];
        [amountToolBar setItems:bArray animated:NO];
        [amountToolBar setBarStyle:UIBarButtonSystemItemAction];
        [pickerGroupView addSubview: myPickerView];
        [pickerGroupView addSubview:amountToolBar];
        toolBarInUse = amountToolBar;
        pickerViewInUse = myPickerView;
        datePickerInUse = NO;
        [[[self view]window] addSubview:pickerGroupView];
        
        CGSize rect = [amountToolBar sizeThatFits:CGSizeZero];
        
        CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
        
        
        CGPoint recr = CGPointMake(0.0, 0.0);
        
        recr.x = pickerGroupView.frame.origin.x;
        recr.y = pickerGroupView.frame.origin.y;
        
        
        amountToolBar.frame = CGRectMake(recr.x, recr.y, rect.width, rect.height);
        amountToolBar.translucent = NO;
        amountToolBar.barTintColor =[UIColor blackColor];
        myPickerView.frame = CGRectMake(0.0, recr.y + amountToolBar.frame.size.height, pickerGroupView.frame.size.width, pickerGroupView.frame.size.height);
        
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
                    pickRect = CGRectMake(screenRect.origin.x - myPickerView.frame.size.height - 2*amountToolBar.frame.size.height, screenRect.origin.y + myPickerView.frame.size.width/2 - [UIApplication sharedApplication].statusBarFrame.size.width-8.0, pickerGroupSize.height, pickerGroupSize.width);
                
                else
                    pickRect = CGRectMake(screenRect.origin.x + (2*myPickerView.frame.size.height), screenRect.origin.y + myPickerView.frame.size.width/2 -1.5*[UIApplication sharedApplication].statusBarFrame.size.width+2.0, pickerGroupSize.height, pickerGroupSize.width);
            }
            else
                pickRect = CGRectMake(screenRect.size.width/2 - myPickerView.frame.size.width/2, screenRect.origin.y +screenRect.size.height  - myPickerView.frame.size.height - amountToolBar.frame.size.height, pickerGroupSize.width, pickerGroupSize.height);
        }
        else
            pickRect = CGRectMake(0.0, screenRect.origin.y +screenRect.size.height - myPickerView.frame.size.height - amountToolBar.frame.size.height, pickerGroupSize.width, pickerGroupSize.height);
        
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


-(void)cancel:(id)sender
{
    [[LogItemStore sharedStore]removeItem:item];
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:dismissBlock];
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
    
    UINib *nib = [UINib nibWithNibName:@"DataViewCell" bundle:nil];
    [[self tableView]registerNib:nib forCellReuseIdentifier:@"DataViewCell"];
    self.tableView.rowHeight = 169.0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    int cot = [[[[LogItemStore sharedStore]logItemContainer]logItems]count] - 1;
    
    LogItem *i = [[[[LogItemStore sharedStore]logItemContainer]logItems] objectAtIndex:cot];
    
    
    DataViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DataViewCell"];
    [cell setController:self];
    [cell setTableView:tableView];
    NSNumber *amount = [i amountIntake];
    if (amount == NULL) {
        [[cell amountText]setText:@""];
    }
    else
    {
        NSComparisonResult result = [i.typeIntake compare:@"Fiber"];
        if (result == NSOrderedSame)
            [[cell amountText]setText:[NSString stringWithFormat:@"%@ gm", amount]];
        else if (result ==NSOrderedAscending)
            [[cell  amountText]setText:[NSString stringWithFormat:@"%@ oz", amount]];
        else
            [[cell amountText]setText:@"n/a"];
    }
    if (counter == 0)
    {
        int divisor = RAND_MAX/5;
        int retval;
        do{
            retval = rand()/divisor;
        }while (retval >5);
        if (retval % 5 == 0)
            [[cell randomImage]setImage:[UIImage imageNamed:@"HPThumbsUpiPhone.png"]];
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
    
    [[cell whatText]setText:[i whatIntake]];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    NSString *dateString = [formatter stringFromDate:[i timeCreated]];
    [[cell timeText]setText:dateString];
    [[cell typeText]setText:[i typeIntake]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    NSArray *itemsArray = [[NSArray alloc]initWithArray:[[[LogItemStore sharedStore]logItemContainer]logItems]];
    int count =0;
    int count1 = 0;
    NSComparisonResult result = [item.typeIntake compare:@"Fiber"];
    if (result == NSOrderedSame && item.typeIntake !=nil&& [[[[LogItemStore sharedStore]logItemContainer]logItems] containsObject:item])
    {
        for (int i = 0; i < [itemsArray count]; i++)
        {
            LogItem *itemcount = [[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i];
            NSComparisonResult result = [itemcount.typeIntake compare:@"Fiber"];
            if (result == NSOrderedSame && itemcount.typeIntake !=nil)
            {
                count += [itemcount.amountIntake intValue];
            }
            
        }
        
        if (count >25 &&[[[LogItemStore sharedStore]logItemContainer]alreadySetFiberAward] !=YES)
        {
            [item setInfoType:@"Football"];
            [[LogItemStore sharedStore]setFiberAward];
            NSNotification *note = [NSNotification notificationWithName:@"newFiberMeritBadge" object:nil];
            [[NSNotificationCenter  defaultCenter]postNotification:note];
            
        }
        
    }
    
    
    else if (result == NSOrderedAscending && item.typeIntake != nil&& [[[[LogItemStore sharedStore]logItemContainer]logItems] containsObject:item])
    {
        
        for (int i = 0; i < [itemsArray count]; i++)
        {
            LogItem *itemcount = [[[[LogItemStore sharedStore]logItemContainer]logItems]objectAtIndex:i];
            NSComparisonResult result = [itemcount.typeIntake compare:@"Drink"];
            if (result == NSOrderedSame && itemcount.typeIntake !=nil)
            {
                count1 += [itemcount.amountIntake intValue];
            }
            
        }
        
        if (count1 > 40 &&[[[LogItemStore sharedStore]logItemContainer]alreadySetFluidAward] !=YES)
        {
            [item setInfoType:@"Basketball"];
            [[LogItemStore sharedStore]setFluidAward];
            NSNotification *note = [NSNotification notificationWithName:@"newFluidMeritBadge" object:nil];
            [[NSNotificationCenter  defaultCenter]postNotification:note];
            
        }
        
    }
    counter = 0;
}

@end
