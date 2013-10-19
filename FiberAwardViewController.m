//
//  FiberAwardViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "FiberAwardViewController.h"


@implementation FiberAwardViewController

-(id)init
{
    self = [super initWithNibName:@"FiberAwardViewController" bundle:nil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReading:)];
        [n setLeftBarButtonItem:doneButton];
        self.title = @"RockBreaker!";
    }
    return self;
}

-(void)doneReading:(id)sender
{
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadView
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    
    UIView *view = [[UIView alloc]initWithFrame:rect];
    
    [self setView:view];
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    UITextView *textView = [[UITextView alloc]init];
    
   
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation]))
    {
        
            textView.frame = CGRectMake(screenRect.size.width/8, screenRect.origin.y, screenRect.size.width/2, screenRect.size.height/6-(2*[UIApplication sharedApplication].statusBarFrame.size.width)+5.0);
        
    }
    else
        textView.frame = CGRectMake(screenRect.size.width/15, screenRect.origin.y - [UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width/1.65, screenRect.size.height/6-(2*[UIApplication sharedApplication].statusBarFrame.size.height)+5.0);
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DinosaurThumbsUP.png"]];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [imageView addSubview:textView];
    
    
    [[self view]addSubview:imageView];
   
    if (UIDeviceOrientationIsLandscape([self interfaceOrientation]))
    {
        imageView.frame = CGRectMake(0.0, 0.0, screenRect.size.width+ [UIApplication sharedApplication].statusBarFrame.size.width, screenRect.size.height);
    }
    else
        imageView.frame = CGRectMake(0.0, 0.0, screenRect.size.width, screenRect.size.height+ [UIApplication sharedApplication].statusBarFrame.size.height);
    }
    
    
    
    else
    {
        textView.frame = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width, screenRect.size.height);
        [[self view]addSubview:textView];
    }
    textView.font = [UIFont fontWithName:@"Arial" size:14.0];
    textView.text = @"You won the ROCKBREAKER!  You ate at least 25 grams of fiber today.  Fiber is something that helps beat CONSTIPATION.  And constipation can make it hard to know when you need to pee.  So if you eat more fiber, you can go to the bathroom more regularly!";

    textView.delegate = self;
    [textView setEditable:NO];


   
    
    
	}

@end
