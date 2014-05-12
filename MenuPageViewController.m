//
//  MenuPageViewController.m
//  UroApp
//
//  Created by Jeremy Wiygul on 11/26/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "MenuPageViewController.h"
#import "IntakeInfoViewController.h"
#import "OutputInfoViewController.h"
#import "AwardsInfoViewController.h"
#import "ProgramInfoViewController.h"
#import "LogItemStore.h"
#import "OutputLogItemStore.h"

@interface MenuPageViewController ()

@end

@implementation MenuPageViewController
{
    ADBannerView *myBannerView;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Home";
        self.tabBarItem.image = [UIImage imageNamed:@"homeIcon.png"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self view].autoresizesSubviews=YES;
    [self view].autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
- (IBAction)showIntakeInfoPage:(id)sender {
    IntakeInfoViewController *favc = [[IntakeInfoViewController alloc]init];
    UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:favc];
    
    [navCom setModalPresentationStyle:UIModalPresentationFormSheet];
    [navCom setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navCom animated:YES completion:nil];
}

- (IBAction)showOutputInfoPage:(id)sender {
    OutputInfoViewController *favc = [[OutputInfoViewController alloc]init];
    UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:favc];
    
    [navCom setModalPresentationStyle:UIModalPresentationFormSheet];
    [navCom setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navCom animated:YES completion:nil];
}

- (IBAction)showMedalsInfoPage:(id)sender {
    AwardsInfoViewController *favc = [[AwardsInfoViewController alloc]init];
    UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:favc];
    
    [navCom setModalPresentationStyle:UIModalPresentationFormSheet];
    [navCom setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:navCom animated:YES completion:nil];

}

- (IBAction)showInfo:(id)sender {
    ProgramInfoViewController *pvc = [[ProgramInfoViewController alloc]init];
    UINavigationController *navCom = [[UINavigationController alloc]initWithRootViewController:pvc];
    [navCom setModalPresentationStyle:UIModalPresentationFormSheet];
    [navCom setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:navCom animated:YES completion:nil];

}

- (IBAction)showMail:(id)sender {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayMailComposer];
		}
		else{
            NSError *error;
            NSString *errorMessage = [error localizedDescription];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Default email not set up."
                                                                message:errorMessage
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            }
    }

}

- (IBAction)clearData:(id)sender {
    NSError *error;
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to clear all data?  This cannot be undone."
                                                        message:errorMessage
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
    [alertView addButtonWithTitle:@"Clear Data"];
    [alertView show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0) 
        return;
    else if (buttonIndex ==1){
        [[LogItemStore sharedStore]clearData];
        [[OutputLogItemStore sharedStore]clearData];
    }
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)displayMailComposer
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"HapPee Time Info"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *file_Path = [documentsDirectory stringByAppendingPathComponent:@"log.txt"];
   
    
    
    NSMutableString *printString = [NSMutableString stringWithString:@"INTAKE \n"];
    LogItem *otherItem;
    LogItemContainer *logcontainer;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    [timeFormatter setDateStyle:NSDateFormatterNoStyle];
    for (int y = 0; y<[[[LogItemStore sharedStore]itemContainer]count]; y++)//iterate through each logitemcontainer
    {
        logcontainer = [[[LogItemStore sharedStore]itemContainer]objectAtIndex:y];
        [printString appendString:@"Date:"];
        NSString *dateString = [formatter stringFromDate:logcontainer.dateCreated];
        [printString appendString:[NSString stringWithFormat:@"%@\n",dateString]];
        for (int i=0;i<[[logcontainer logItems]count]&&([[logcontainer logItems]count]>0);i++)
        {
            otherItem = [logcontainer.logItems objectAtIndex:i];
            NSComparisonResult drinkResult = [otherItem.typeIntake compare:@"Drink"];
            NSComparisonResult fiberResult = [otherItem.typeIntake compare:@"Fiber"];
            NSString *timeString = [timeFormatter stringFromDate:otherItem.dateCreated];
           
                [printString appendString:[NSString stringWithFormat:@"%@  ",timeString]];
            if (otherItem.typeIntake !=nil) {
                [printString appendString:[NSString stringWithFormat:@"%@  ",otherItem.typeIntake]];
            }
            
            
            if (otherItem.amountIntake !=nil) {
                NSString *amountUnits;
                if (drinkResult == NSOrderedSame) {
                    amountUnits = @"oz";
                }
                else if (fiberResult == NSOrderedSame)
                    amountUnits = @"gms";
                else
                    amountUnits = @"";
                [printString appendString:[NSString stringWithFormat:@"%@%@  ",otherItem.amountIntake,amountUnits]];
                
            }
            
            if (otherItem.whatIntake !=nil) {
                [printString appendString:[NSString stringWithFormat:@"%@   ",otherItem.whatIntake]];
            }
        
            [printString appendString:@"\n"];
            
            
            
        
           
        }
        [printString appendString:@"\n"];
    }
    [printString appendString:@"OUTPUT\n"];
    OutputLogItemContainer *outputLogContainer;
    OutputLogItem *outputLogItem;
    for (int x = 0; x < [[[OutputLogItemStore sharedStore]itemContainer]count]; x++) {
        outputLogContainer = [[[OutputLogItemStore sharedStore]itemContainer]objectAtIndex:x];
        [printString appendString:@"Date:"];
        NSString *outputDateString = [formatter stringFromDate:outputLogContainer.dateCreated];
        [printString appendString:[NSString stringWithFormat:@"%@\n",outputDateString]];
        for (int j = 0; j<[[outputLogContainer outputLogItems]count]; j++)
        {
            outputLogItem = [outputLogContainer.outputLogItems objectAtIndex:j];
            NSComparisonResult poopAccidentResult = [outputLogItem.typeOutput compare:@"Poop accident"];
            NSString *timeString = [timeFormatter stringFromDate:outputLogItem.dateCreated];
            [printString appendString:timeString];
            [printString appendString:@"  "];
            if (outputLogItem.typeOutput !=nil) {
                [printString appendString:outputLogItem.typeOutput];
            }
            if (poopAccidentResult != NSOrderedSame && outputLogItem.qualityOutput != nil) {
                [printString appendString:@" "];
                [printString appendString:outputLogItem.qualityOutput];
            }
                        [printString appendString:@"\n"];
        }
    [printString appendString:@"\n"];
    }
   
    
    
    
    //CREATE FILE
    
    NSError *error;
    
    
    
    NSData *evenMoreData = [NSData dataWithContentsOfFile:file_Path];
    NSString *mimeString = @"text/rtf";
    [picker addAttachmentData:evenMoreData mimeType:mimeString fileName:@"log.txt"];
	[self presentViewController:picker animated:YES completion:nil];
    
}
-(void)showBannerView:(ADBannerView *)bannerView animated:(BOOL)animated
{
    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}
-(void)hideBannerView:(ADBannerView *)bannerView animated:(BOOL)animated
{
   
}
@end
