//
//  LogItemContainer.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "LogItemContainer.h"

@implementation LogItemContainer

@synthesize logItems,dateCreated,alreadySetFiberAward,alreadySetFluidAward,pendingFiberBadges,pendingFluidBadges,pendingPeeBadges, pendingPoopBadges;
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        logItems = [aDecoder decodeObjectForKey:@"logItems"];
        dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        alreadySetFiberAward = [aDecoder decodeBoolForKey:@"alreadySetFiberAward"];
        alreadySetFluidAward = [aDecoder decodeBoolForKey:@"alreadySetFluidAward"];
        pendingFiberBadges = [aDecoder decodeIntForKey:@"pendingFiberBadges"];
        pendingFluidBadges = [aDecoder decodeIntForKey:@"pendingFluidBadges"];
        pendingPeeBadges = [aDecoder decodeIntForKey:@"pendingPeeBadges"];
        pendingPoopBadges = [aDecoder decodeIntForKey:@"pendingPoopBadges"];
        
        if (!logItems) {
            logItems = [[NSMutableArray alloc]init];
        }
        if (!dateCreated) {
            dateCreated = [[NSDate alloc]init];
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:logItems forKey:@"logItems"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeInt:pendingFiberBadges forKey:@"pendingFiberBadges"];
    [aCoder encodeInt:pendingFluidBadges forKey:@"pendingFluidBadges"];
    [aCoder encodeInt:pendingPeeBadges forKey:@"pendingPeeBadges"];
    [aCoder encodeInt:pendingPoopBadges forKey:@"pendingPoopBadges"];
    [aCoder encodeBool:alreadySetFiberAward forKey:@"alreadySetFiberAward"];
    [aCoder encodeBool:alreadySetFluidAward forKey:@"alreadySetFluidAward"];
    
}

@end
