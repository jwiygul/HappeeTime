//
//  AwardsInfoViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 11/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "AwardsInfoViewController.h"

@interface AwardsInfoViewController ()

@end

@implementation AwardsInfoViewController

-(id)init
{
    self = [super initWithNibName:@"IntakeInfoViewController" bundle:nil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReading:)];
        self.title = @"Awards Page Info";
        [n setLeftBarButtonItem:doneButton];
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
            textView.frame = CGRectMake(0.0, screenRect.origin.y, screenRect.size.width + [UIApplication sharedApplication].statusBarFrame.size.width, screenRect.size.height);
        }
        else
            textView.frame = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width, screenRect.size.height+[UIApplication sharedApplication].statusBarFrame.size.height);
        textView.font =[UIFont boldSystemFontOfSize:16.0];
    }
    else
    {
        textView.frame = CGRectMake(0.0, screenRect.origin.y-[UIApplication sharedApplication].statusBarFrame.size.height, screenRect.size.width, screenRect.size.height);
        textView.font= [UIFont boldSystemFontOfSize:14.0];
        
    }
    textView.pagingEnabled = YES;
    [textView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
   
    
    textView.text = @"You've selected the Awards Page Icon.\n\nThe Awards Page, which you can find by its tab bar (at the bottom of the application), is where all the great things you have done are kept so you can see for yourself!  The coolest thing about HapPee Time (at least we think so) is that just by doing what your doctor asked you to do, you can win awards - And if you are like us, you like awards!  \n\nSpecifically, there are four types of awards you can win: \nTHE ROCKBREAKER-\nYou win this award when you eat more than 25 grams of fiber a day.  Eating fiber is important because it helps push all the other food you eat through your body, so you don't get constipated.  What's constipation?  That's when you don't poop enough, and the poop builds up inside.  This can make you feel bad, but it can also make it hard to know when to pee, when to poop, and, well, you probably get the picture.\n\nTHE THUMBS UP - \nYou win this award when you drink more than 40 ounces of fluid in a day.  If fiber is really important to keep constipation away, fluid is SUPER important. Almost everyone who has pooping (and peeing) problems doesn't drink enough fluid.  We know-it doesn't make sense.  But not drinking enough fluid makes the poop hard, and when it's hard, it doesn't come out easily.  Heard enough?  Well, keep drinking!\n\nTHE TOILET FLUSH - \nYou win this award when you go at least 3 days without a wetting accident.  For many of you using this application, this is the whole reason you are doing this in the first place.  So you may focus on this award.  But don't forget the others!  You get better by doing everything better.\n\nMR. CONSISTENCY - \nYou win this award for going poop at least 4 days in a row.  \n\nRemember, the whole point of the application is to help people go to the bathroom better, so focus on the recording, and not the winning (although winning is good - and fun!).  You'll be able to keep count of the awards you've won as you use the application in the Awards Page-so you'll know what you're doing well, and what you need to work on.  We hope everyone finds our application helpful, and we wish everyone all the awards in the world!\n\n";
    
	textView.pagingEnabled = NO;
	textView.delegate = self;
    [textView setEditable:NO];
    
    
}


@end
