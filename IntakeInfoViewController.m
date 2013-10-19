//
//  IntakeInfoViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 11/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "IntakeInfoViewController.h"

@interface IntakeInfoViewController ()

@end

@implementation IntakeInfoViewController

-(id)init
{
    self = [super initWithNibName:@"IntakeInfoViewController" bundle:nil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReading:)];
        [n setLeftBarButtonItem:doneButton];
        self.title = @"Intake Page Info";
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
            textView.frame = CGRectMake(0.0, screenRect.origin.y, screenRect.size.width +[UIApplication sharedApplication].statusBarFrame.size.width, screenRect.size.height);
        }
        else
            textView.frame = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width, screenRect.size.height+[UIApplication sharedApplication].statusBarFrame.size.height);
        textView.font =[UIFont boldSystemFontOfSize: 16.0];
    }
    else
    {
        textView.frame = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width, screenRect.size.height);
        textView.font =[UIFont boldSystemFontOfSize:14.0];
    }
    
    [textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    textView.scrollEnabled = YES;
    textView.text =@"You've selected the Intake Page Icon.\n\nThe Intake Page, which you can find by its tab bar (at the bottom of the application), is where you or your child should record all of the things they eat and drink.  When you go there, you'll see a + sign at the top left - that's the button you push to add something to your log.  Things are broken down into three parts: Food, Drink, and Fiber.  It also gives you the chance to enter in what exactly you took in (chicken? water? tea?).  Try to record everything, even if it means multiple entries at the same time. We also want to know how much you took in, specifically how much fluid you are drinking.\n\nWe made Fiber a separate category because it's so important for pooping regularly.  Why is it important?  Well, touch the Awards Page Icon(the medal icon at the bottom of the menu page), and you'll find out.  \n\nAlso keep in mind that each entry is time stamped, which means when you enter it will be the time it will associated in the log.  However, if you want to enter in something eaten earlier in the day when you didn't have HapPee Time with you, you can select the time too. \n\n\nYou can win two types of awards with your entries in the Intake Page. 1) The RockBreaker and 2) The Thumbs Up (how you win these awards is explained in the Awards Page Info page).  When you win these awards, you'll see an image pop up that represents what you've won.  Tap it, and you'll get an explanation of why you won, and motivation to keep going!  You can only win one of each a day, so eating twice the amount of fiber or drinking twice the amount of fluid will give you a tummy ache, but no more awards!";
	
	textView.delegate = self;
  
    [textView setEditable:NO];
    
    
}
@end
