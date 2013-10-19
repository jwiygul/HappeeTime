//
//  OutputLogItem.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OutputLogItem : NSObject <NSCoding>

@property (nonatomic)NSDate *timeCreated;
@property (nonatomic)NSDate *dateCreated;
@property (nonatomic)NSString *typeOutput;
@property (nonatomic)NSString *qualityOutput;
@property (nonatomic)NSString *infoType;

@end
