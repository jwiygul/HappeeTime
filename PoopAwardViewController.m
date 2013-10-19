//
//  PoopAwardViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/31/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "PoopAwardViewController.h"

@implementation PoopAwardViewController


-(id)init
{
    self = [super initWithNibName:@"PoopAwardViewController" bundle:nil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReading:)];
        [n setLeftBarButtonItem:doneButton];
        self.title = @"Mr./Ms. Consistency!";
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
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
            
            textView.frame = CGRectMake(screenRect.size.width/15, screenRect.origin.y, screenRect.size.width/1.65, screenRect.size.height/6-(2*[UIApplication sharedApplication].statusBarFrame.size.width)+5.0);
            
        }
        else
            textView.frame = CGRectMake(screenRect.size.width/15, screenRect.origin.y - [UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width/1.65, screenRect.size.height/6-(2*[UIApplication sharedApplication].statusBarFrame.size.height));
        
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
    textView.text =@"You won MR./MS. CONSISTENCY!  You've pooped at least 4 days in a row.  When poop stays inside for a long time, it can get hard and push on your bladder, making it hard to control when and where you pee.  So if you're pooping well, you're probably peeing well, too.  So congrats!";
	
	textView.delegate = self;
    [textView setEditable:NO];
    
    
}

@end
