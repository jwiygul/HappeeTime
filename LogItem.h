//
//  LogItem.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogItem : NSObject<NSCoding>

@property (nonatomic) NSNumber *amountIntake;
@property (nonatomic) NSString *typeIntake;
@property (nonatomic) NSString *whatIntake;
@property (nonatomic) NSDate *dateCreated;
@property (nonatomic) NSDate *timeCreated;

@property (nonatomic) NSString *infoType;

@end
