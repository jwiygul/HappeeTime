//
//  IntakeViewController.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iAd/iAd.h>
#import "LogItemStore.h"
#import "VoidingLogCell.h"
#import "DataViewController.h"
#import "VoidingLogCell.h"
#import "UroAppAppDelegate.h"
@class LogItem;

@interface IntakeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ADBannerViewDelegate, BannerViewContainer>

{
    int orientationNumber;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UIToolbar *topToolBar;
@property (strong,nonatomic) UIBarButtonItem *leftTopToolBarButtonItem;
@property (strong,nonatomic) UIBarButtonItem *barItemForward;
@property (strong,nonatomic) UIBarButtonItem *dateButton;
@property (strong,nonatomic) UIBarButtonItem *addButton;
@property (strong, nonatomic)UIBarButtonItem *editButton;
@property (strong,nonatomic)LogItem *item;


@end
