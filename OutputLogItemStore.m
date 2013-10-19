//
//  OutputLogItemStore.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "OutputLogItemStore.h"

@implementation OutputLogItemStore
+(OutputLogItemStore *)sharedStore
{
    static OutputLogItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil]init];
    }
    return sharedStore;
}
+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}
-(NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"outputLogItems.archive"];
}

-(BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    return [NSKeyedArchiver archiveRootObject:itemContainer toFile:path];
}
-(id)init
{
    self = [super init];
    if (self)
    {
        NSString *path = [self itemArchivePath];
        
        itemContainer = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        if (!itemContainer)
        {
            itemContainer = [[NSMutableArray alloc]init];
            outputLogItemContainer = [[OutputLogItemContainer alloc]init];
            outputLogItemContainer.outputLogItems = [[NSMutableArray alloc]init];
            NSDate *todaysDate = [[NSDate alloc]init];
            outputLogItemContainer.dateCreated =todaysDate;
            [itemContainer addObject:outputLogItemContainer];
            [outputLogItemContainer setAlreadySetPeeAward:NO];
            [outputLogItemContainer setDidHavePeeAccident:NO];
            [outputLogItemContainer setAlreadySetPoopAward:NO];
        }
        else
        {
            OutputLogItemContainer *lic = [itemContainer objectAtIndex:[itemContainer count]-1];
            
            NSDate *todaysDate = [[NSDate alloc]init];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            NSString *lastDate = [formatter stringFromDate:lic.dateCreated];
            NSString *todaysDateString = [formatter stringFromDate:todaysDate];
            NSComparisonResult result = [lastDate compare:todaysDateString];
            if (result == NSOrderedSame){
                outputLogItemContainer = [itemContainer objectAtIndex:[itemContainer count]-1];
                [itemContainer replaceObjectAtIndex:[itemContainer count]-1 withObject:outputLogItemContainer];
             
                            }
            else
            {
                outputLogItemContainer = [[OutputLogItemContainer alloc]init];
                outputLogItemContainer.dateCreated = [[NSDate alloc]init];
                outputLogItemContainer.outputLogItems = [[NSMutableArray alloc]init];
                [itemContainer addObject:outputLogItemContainer];
                [outputLogItemContainer setAlreadySetPeeAward:NO];
                [outputLogItemContainer setDidHavePeeAccident:NO];
                [outputLogItemContainer setAlreadySetPoopAward:NO];
                
            }
        }
        
        
    }
    return self;
}

-(OutputLogItem *)createItem
{
    OutputLogItem *newItem = [[OutputLogItem alloc]init];
    [[outputLogItemContainer outputLogItems] addObject:newItem];
    NSDate *d = [NSDate date];
    [newItem setDateCreated:d];
    return newItem;
}


-(NSMutableArray *)itemContainer
{
    return itemContainer;
}
-(OutputLogItemContainer *)outputLogItemContainer
{
    return outputLogItemContainer;
}
-(void)removeItem:(OutputLogItem *)i
{
    [outputLogItemContainer.outputLogItems removeObjectIdenticalTo:i];
    BOOL previousWetness = NO;
    int count = [outputLogItemContainer.outputLogItems count];
    NSComparisonResult result = [i.typeOutput compare:@"Pee accident"];
    NSComparisonResult peeResult = [i.typeOutput compare:@"Pee"];
    NSComparisonResult poopResult = [i.typeOutput compare:@"Poop"];
    OutputLogItem *nextItem = [[OutputLogItem alloc]init];
    
    if (result ==NSOrderedSame && i.typeOutput != nil)
    {
        
        for (int y = 0; y < count; y++)
        {
            nextItem = [outputLogItemContainer.outputLogItems objectAtIndex:y];
            NSComparisonResult nextResult = [nextItem.typeOutput compare:@"Pee accident"];
            if (nextResult ==NSOrderedSame && nextItem.typeOutput !=nil)
            {
                previousWetness = YES;
                break;
            }
        }
        if (previousWetness == NO)
            outputLogItemContainer.didHavePeeAccident = NO;
    }
    if (peeResult == NSOrderedSame && i.typeOutput != nil)
    {
        NSComparisonResult nextResult = [i.infoType compare:@"Dryness"];
        if (nextResult == NSOrderedSame && i.infoType !=nil && outputLogItemContainer.alreadySetPeeAward == YES && outputLogItemContainer.alreadySetPeeAward !=nil) {
            outputLogItemContainer.alreadySetPeeAward = NO;
            NSNotification *note = [NSNotification notificationWithName:@"peeMeritBadgeGone" object:nil];
            [[NSNotificationCenter  defaultCenter]postNotification:note];
        }
    }
    if (poopResult == NSOrderedSame && i.typeOutput != nil) {
        NSComparisonResult nextResult = [i.infoType compare:@"poopStar"];
        if (nextResult == NSOrderedSame && i.infoType != nil && outputLogItemContainer.alreadySetPoopAward == YES && outputLogItemContainer.alreadySetPoopAward !=nil) {
            outputLogItemContainer.alreadySetPoopAward = NO;
            NSNotification *note = [NSNotification notificationWithName:@"poopMeritBadgeGone" object:nil];
            [[NSNotificationCenter  defaultCenter]postNotification:note];
        }
    }
}
-(void)alreadySetPeeAward
{
    outputLogItemContainer.alreadySetPeeAward = YES;
}

-(void)alreadySetPoopAward
{
    outputLogItemContainer.alreadySetPoopAward = YES;
}
-(BOOL)goBack:(int)i
{
    int counter = [itemContainer count]-i;
    
    if (counter >=0)
    {
        outputLogItemContainer = [itemContainer objectAtIndex:[itemContainer count]-i];
        return YES;
    }
    return NO;
}

-(BOOL)goForward:(int)i
{
    
    int counter = [itemContainer count]-i;
    if (counter < 0) {
        outputLogItemContainer = [itemContainer objectAtIndex:0];
        return NO;
    }
    
    if (counter >=[itemContainer count])
    {
        outputLogItemContainer = [itemContainer objectAtIndex:[itemContainer count]-1];
    }
    else{
        outputLogItemContainer = [itemContainer objectAtIndex:[itemContainer count]-i];
    }
    return YES;
}
-(void)clearData
{
    int numberOfLogItemContainers = [itemContainer count];
    OutputLogItemContainer *container;
    for (int i = 0; i <numberOfLogItemContainers; i++)
    {
        container = [itemContainer objectAtIndex:i];
        [container.outputLogItems removeAllObjects];
    }
    OutputLogItemContainer *newContainer= [itemContainer lastObject];
    
    [itemContainer removeAllObjects];
    [itemContainer addObject:newContainer];
  
    [self saveChanges];
}
-(int)countPeeAwardsSet
{
    int count = [itemContainer count];
    int numberOfTypesSet = 0;
    for (int i =0; i<count; i++)
    {
        OutputLogItemContainer *outputLogItemContainerCounter = [itemContainer objectAtIndex:i];
        if (outputLogItemContainerCounter.alreadySetPeeAward == YES)
            numberOfTypesSet++;
        
    }
    return numberOfTypesSet;
}

-(int)countPoopAwardsSet
{
    int count = [itemContainer count];
    int numberOfTypesSet = 0;
    for (int i =0; i<count; i++)
    {
        OutputLogItemContainer *outputLogItemContainerCounter = [itemContainer objectAtIndex:i];
        if (outputLogItemContainerCounter.alreadySetPoopAward == YES)
            numberOfTypesSet++;
        
    }
   
    return numberOfTypesSet;
}
-(void)setCurrentItemContainer
{
    outputLogItemContainer = [[OutputLogItemContainer alloc]init];
    outputLogItemContainer.dateCreated = [[NSDate alloc]init];
    outputLogItemContainer.outputLogItems = [[NSMutableArray alloc]init];
    [itemContainer addObject:outputLogItemContainer];
    [outputLogItemContainer setAlreadySetPeeAward:NO];
    [outputLogItemContainer setDidHavePeeAccident:NO];
}
@end
