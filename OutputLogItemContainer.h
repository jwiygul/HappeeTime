//
//  OutputLogItemContainer.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OutputLogItemContainer : NSObject <NSCoding>

{
    NSMutableArray *outPutLogItems;
}
@property (nonatomic, retain)NSMutableArray *outputLogItems;
@property (nonatomic,retain)NSDate *dateCreated;
@property (nonatomic) BOOL didHavePeeAccident;
@property (nonatomic) BOOL alreadySetPeeAward;
@property (nonatomic) BOOL didPoopToday;
@property (nonatomic) BOOL alreadySetPoopAward;

@end
