//
//  LogItemContainer.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogItemContainer : NSObject <NSCoding>

{
    NSMutableArray *logItems;
}

@property (nonatomic,retain)NSMutableArray *logItems;
@property (nonatomic,retain)NSDate *dateCreated;
@property (nonatomic) BOOL alreadySetFiberAward;
@property (nonatomic) BOOL alreadySetFluidAward;
@property (nonatomic) int pendingPoopBadges;
@property (nonatomic) int pendingPeeBadges;
@property (nonatomic) int pendingFiberBadges;
@property (nonatomic) int pendingFluidBadges;


@end
