//
//  LogItem.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "LogItem.h"

@implementation LogItem
@synthesize amountIntake,typeIntake, whatIntake, dateCreated,timeCreated,infoType;


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:amountIntake forKey:@"amountIntake"];
    [aCoder encodeObject:typeIntake forKey:@"typeIntake"];
    [aCoder encodeObject:whatIntake forKey:@"whatIntake"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:timeCreated forKey:@"timeCreated"];
    [aCoder encodeObject:infoType forKey:@"infoType"];
    
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setAmountIntake:[aDecoder decodeObjectForKey:@"amountIntake"]];
        [self setDateCreated:[aDecoder decodeObjectForKey:@"dateCreated"]];
        [self setTimeCreated:[aDecoder decodeObjectForKey:@"timeCreated"]];
        [self setTypeIntake:[aDecoder decodeObjectForKey:@"typeIntake"]];
        [self setWhatIntake:[aDecoder decodeObjectForKey:@"whatIntake"]];
        [self setInfoType:[aDecoder decodeObjectForKey:@"infoType"]];
        ;
    }
    return self;
}

@end
