//
//  BristolView.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BristolView : UIView
{
    NSString *title;
    UIImage *image;
}
@property (nonatomic,retain)NSString *title;
@property (nonatomic, retain)UIImage *image;

+(CGFloat)viewWidth;
+(CGFloat)viewHeight;

@end
