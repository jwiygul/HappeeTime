//
//  BristolView.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "BristolView.h"

@implementation BristolView

@synthesize title,image;

const CGFloat kViewWidth = 200;
const CGFloat kViewHeight = 44;

+ (CGFloat)viewWidth
{
    return kViewWidth;
}

+ (CGFloat)viewHeight
{
    return kViewHeight;
}

- (id)initWithFrame:(CGRect)frame
{
	// use predetermined frame size
	self = [super initWithFrame:CGRectMake(0.0, 0.0, kViewWidth, kViewHeight)];
	if (self)
	{
		self.backgroundColor = [UIColor clearColor];	// make the background transparent
	}
	return self;
}

- (void)drawRect:(CGRect)rect
{
	// draw the image and title using their draw methods
	CGFloat yCoord = (self.bounds.size.height - self.image.size.height)/2;
	CGPoint point = CGPointMake(10.0, yCoord);
	[self.image drawAtPoint:point];
	
	yCoord = (self.bounds.size.height) / 2;
	point = CGPointMake(10.0 + self.image.size.width + 10.0, yCoord);
	[self.title drawAtPoint:point
                   forWidth:self.bounds.size.width
                   withFont:[UIFont systemFontOfSize:12.0]
                minFontSize:12.0 actualFontSize:NULL lineBreakMode:NSLineBreakByCharWrapping baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
}

// Enable accessibility for this view.
- (BOOL)isAccessibilityElement
{
	return YES;
}

// Return a string that describes this view.
- (NSString *)accessibilityLabel
{
	return self.title;
}


@end
