//
//  OutputInfoViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 11/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "OutputInfoViewController.h"

@interface OutputInfoViewController ()

@end

@implementation OutputInfoViewController

-(id)init
{
    self = [super initWithNibName:@"OutputInfoViewController" bundle:nil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReading:)];
        [n setLeftBarButtonItem:doneButton];
        self.title = @"Output Page Info";
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
    [[self view]addSubview:textView];
    if ([UIDevice currentDevice].userInterfaceIdiom ==UIUserInterfaceIdiomPad)
    {
        if (UIDeviceOrientationIsLandscape([self interfaceOrientation])) {
            textView.frame = CGRectMake(0.0, screenRect.origin.y, screenRect.size.width+[UIApplication sharedApplication].statusBarFrame.size.width, screenRect.size.height);
        }
        else
            textView.frame = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width, screenRect.size.height+[UIApplication sharedApplication].statusBarFrame.size.height);
        textView.font =[UIFont boldSystemFontOfSize:16.0];
    }
    else
    {
        textView.frame = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width, screenRect.size.height);
        textView.font =[UIFont boldSystemFontOfSize:14.0];
    }

    
    
    textView.text =@"You've selected the Output Page Icon.\n\nThe Output Page, which you can find by its tab bar (at the bottom of the application), is where you and your child should enter every time they go to the bathroom.  Specifically, there are four things that should be entered: When your child pooped, when they peed, if they wet their pants (or the bed), and if they pooped in their pants.  We know - it's a little embarassing, but its really important for the doctor or nurse taking care of you to know everything that is happening when you are at home.  It's also one of the ways you can earn awards as you record things in HapPee Time-as things get better (which they will!) and there are less accidents, or more days pooping, you will earn awards that will keep you going!\n\nAlso keep in mind that each entry is time stamped, which means when you enter it will be the time it will associated in the log.  However, if you want to enter in something done earlier in the day when you didn't have HapPee Time with you, you can select the time too.\n\n\nYou can win two types of awards with your entries in the Output Page (you can only win one award each per day). 1) The Toilet Flush and 2) Mr. Consistency(How you win these awards is explained in the Awards Page Info page).  When you when these awards, you'll see an image pop up that represents what you've won.  Tap it, and you'll get an explanation of why you won, and motivation to keep going!";
	[textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	textView.delegate = self;
    [textView setEditable:NO];
    
    
}
@end
