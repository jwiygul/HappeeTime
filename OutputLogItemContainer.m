//
//  OutputLogItemContainer.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "OutputLogItemContainer.h"

@implementation OutputLogItemContainer
@synthesize dateCreated,didHavePeeAccident,outputLogItems,alreadySetPeeAward, alreadySetPoopAward,didPoopToday;

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:outputLogItems forKey:@"outputLogItems"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeBool:didHavePeeAccident forKey:@"didHavePeeAccident"];
    [aCoder encodeBool:alreadySetPeeAward forKey:@"alreadySetPeeAward"];
    [aCoder encodeBool:alreadySetPoopAward forKey:@"alreadySetPoopAward"];
    [aCoder encodeBool:didPoopToday forKey:@"didPoopToday"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        outputLogItems = [aDecoder decodeObjectForKey:@"outputLogItems"];
        dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
        didHavePeeAccident = [aDecoder decodeBoolForKey:@"didHavePeeAccident"];
        alreadySetPeeAward = [aDecoder decodeBoolForKey:@"alreadySetPeeAward"];
        didPoopToday = [aDecoder decodeBoolForKey:@"didPoopToday"];
        alreadySetPoopAward = [aDecoder decodeBoolForKey:@"alreadySetPoopAward"];
    }
    return self;
}

@end
