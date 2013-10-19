//
//  FluidAwardViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "FluidAwardViewController.h"

@implementation FluidAwardViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"FluidAwardViewController"  bundle:nil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReading:)];
        [n setLeftBarButtonItem:doneButton];
        self.title = @"Thumbs Up!";
    }
    return self;
}
-(void)doneReading:(id)sender
{
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad
{
    CGRect screenRect = [[UIScreen mainScreen]applicationFrame];
    UITextView *textView = [[UITextView alloc]init];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        
        
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
            if ([self interfaceOrientation] == UIDeviceOrientationLandscapeLeft) {
                textView.frame = CGRectMake(screenRect.size.width/8, screenRect.origin.y, screenRect.size.width/2, screenRect.size.height/6-(2*[UIApplication sharedApplication].statusBarFrame.size.width));
            }
            else
                textView.frame = CGRectMake(screenRect.size.width/8, screenRect.origin.y, screenRect.size.width/2, screenRect.size.height/6-(2*[UIApplication sharedApplication].statusBarFrame.size.width));
        }
        else
            textView.frame = CGRectMake(screenRect.size.width/10, screenRect.origin.y - [UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width/1.75, screenRect.size.height/6-(2*[UIApplication sharedApplication].statusBarFrame.size.height)+5.0);
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DinosaurThumbsUP.png"]];
        [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [imageView addSubview:textView];
        
        
        [[self view]addSubview:imageView];
        
        
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
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
    textView.text = @"You won the THUMBS UP!  You drank more than 40 ounces of fluid today, which means you are doing a good job beating CONSTIPATION.  And by drinking lots of fluids – like water, juice and sports drinks like gatorade – you make it a lot harder for CONSTIPATION to beat YOU!";
    textView.delegate = self;
    [textView setEditable:NO];
    
}
-(void)loadView
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    UIView *view = [[UIView alloc]initWithFrame:rect];
    [self setView:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
