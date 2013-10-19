//
//  MenuPageViewController.h
//  UroApp
//
//  Created by Jeremy Wiygul on 11/26/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <MessageUI/MessageUI.h>
#import "UroAppAppDelegate.h"
@interface MenuPageViewController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate,BannerViewContainer>
- (IBAction)showIntakeInfoPage:(id)sender;
- (IBAction)showOutputInfoPage:(id)sender;
- (IBAction)showMedalsInfoPage:(id)sender;
- (IBAction)showInfo:(id)sender;
- (IBAction)showMail:(id)sender;
- (IBAction)clearData:(id)sender;

@end
