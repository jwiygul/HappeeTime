//
//  ProgramInfoViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "ProgramInfoViewController.h"

@implementation ProgramInfoViewController
@synthesize textView,scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"ProgramInfoViewController" bundle:nibBundleOrNil];
    if (self) {
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReading:)];
        [n setLeftBarButtonItem:doneButton];
        
        [n setTitle:@"About HapPee Time!"];
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
    
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.frame];
	self.textView.textColor = [UIColor blackColor];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        textView.font =[UIFont boldSystemFontOfSize:16.0];
    }
    else
	textView.font =[UIFont boldSystemFontOfSize:14.0];
	self.textView.delegate = self;
	self.textView.backgroundColor = [UIColor whiteColor];
	
	
    
    self.textView.text = @"Welcome to HapPee Time!  With this application, we hope we can help focus you and your child on good bathroom habits, as well as bring to light the foods and behaviors that can lead to problems with going to the bathroom. \n \n \nThere are three different parts to the HapPee Time application.\n\n1) The Intake Page, where you record all the things that go into your body.\n\n2) The Output Page, or what comes out of your body.\n\n3) The Awards Page, where all the badges you have won for doing good things are recorded. \n\n Touch any of the icons on the home page, and you'll get a more in-depth explanation of each of these pages. \n\n\n This application was designed to help young patients record their eating and bathroom behaviors, so their doctors can help them help themselves. To do that, you can mail all the records you entered whenever you want, to anyone you want.  Just simply tap the icon at the top left of the screen, enter in the email address of the person you want to send it to, tap done, and you are done (remember you have to have your default email already set up on your device for this to work!).\n\nWe hope you find our application helpful, and encourage any feedback (good or bad!) that you might have. Since this application encourages certain types of behavior, it should only be used under the guidance of a physician.  It is designed for children 8-10 years old, since that is the group most commonly affected by urinating problems.  Older and younger children can use HapPee Time, of course.  Just make sure you speak to a doctor before you do, even if your child is 8-10 years of age.\n\n\nDISCLAIMER:This application is not intended as a substitute for treatment from a physician for any medical condition.  This application should be used in conjunction with consultation with a health care provider.  This application is provided \"as is\" and no warranty is expressed or implied.  This application is designed for children aged 8 to 10 years, including the award goals, and use of this application by users not within that age range should be only be considered after instruction by a health care provider.  This application is intended to incentivize recording of dietary and elimination behaviors in children.";
    textView.tag = 1;
	self.textView.scrollEnabled = YES;
	self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	
	
	
	[self.view addSubview: textView];
    [[self textView]setEditable:NO];
}

@end
