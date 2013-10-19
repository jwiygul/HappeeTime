//
//  ProgramInfoViewController.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ProgramInfoViewController : UIViewController <UITextViewDelegate>

@property (nonatomic,retain)UITextView *textView;
@property (nonatomic,retain)UIScrollView *scrollView;
-(void)layoutScrollPages;

@end
