//
//  AwardCell.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "AwardCell.h"

@implementation AwardCell
@synthesize imageOne,imageTwo,imageThree,imageFour,imageFive;
-(void)setFive:(UIImage *)image
{
    imageFive.image = image;
}
-(void)setOne:(UIImage *)image
{
    imageOne.image = image;
    
}
-(void)setTwo:(UIImage *)image
{
    imageTwo.image = image;
    
}
-(void)setThree:(UIImage *)image
{
    imageThree.image = image;
}
-(void)setFour:(UIImage *)image
{
    imageFour.image = image;
}

@end
