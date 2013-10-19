//
//  MailViewController.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <MessageUI/MessageUI.h>
#import "UroAppAppDelegate.h"
@interface MailViewController :
UIViewController <UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate,BannerViewContainer>

{
    UITableView *tableViewFiber;
    int pageNumber;
}
@property (strong,nonatomic)UITableView *tableViewFiber;
@property (strong, nonatomic)UITableView *tableViewFluid;
@property (strong, nonatomic)UITableView *tableViewPee;
@property (strong, nonatomic)UITableView *tableViewPoop;
@property (strong,nonatomic)UIToolbar *toolBar;
@property (nonatomic)int leavingPageNumber;
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)UIPageControl *pageControl;




@end
