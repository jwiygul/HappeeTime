//
//  OutputLogItem.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "OutputLogItem.h"

@implementation OutputLogItem
@synthesize typeOutput,qualityOutput,timeCreated,dateCreated,infoType;

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:typeOutput forKey:@"typeOutput"];
    [aCoder encodeObject:qualityOutput forKey:@"qualityOutput"];
    [aCoder encodeObject:timeCreated forKey:@"timeCreated"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:infoType forKey:@"infoType"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init] ;
    if (self) {
        [self setTypeOutput:[aDecoder decodeObjectForKey:@"typeOutput"]];
        [self setQualityOutput:[aDecoder decodeObjectForKey:@"qualityOutput"]];
        [self setTimeCreated:[aDecoder decodeObjectForKey:@"timeCreated"]];
        [self setDateCreated:[aDecoder decodeObjectForKey:@"dateCreated"]];
        [self setInfoType:[aDecoder decodeObjectForKey:@"infoType"]];
    }
    return self;
}

@end
