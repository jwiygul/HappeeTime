//
//  UroAppAppDelegate.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@protocol BannerViewContainer <NSObject>

- (void)showBannerView:(ADBannerView *)bannerView animated:(BOOL)animated;
- (void)hideBannerView:(ADBannerView *)bannerView animated:(BOOL)animated;

@end
@interface UroAppAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,
    ADBannerViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
