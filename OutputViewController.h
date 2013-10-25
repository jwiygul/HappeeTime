//
//  OutputViewController.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import "UroAppAppDelegate.h"
@interface OutputViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, ADBannerViewDelegate, BannerViewContainer>
{
    int orientationNumber;
}
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIToolbar *toolBar;
@property (strong, nonatomic) UIToolbar *topToolBar;
@property (strong,nonatomic) UIBarButtonItem *leftTopToolBarButtonItem;
@property (strong,nonatomic) UIBarButtonItem *barItemForward;
@property (strong,nonatomic) UIBarButtonItem *dateButton;
@property (strong,nonatomic) UIBarButtonItem *addButton;
@property (strong, nonatomic)UIBarButtonItem *editButton;

@end
