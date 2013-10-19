//
//  AwardCell.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AwardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;
@property (weak, nonatomic) IBOutlet UIImageView *imageFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageFive;
-(void)setFive:(UIImage *)image;
-(void)setOne:(UIImage *)image;
-(void)setTwo:(UIImage *)image;
-(void)setThree:(UIImage *)image;
-(void)setFour:(UIImage *)image;

@end
