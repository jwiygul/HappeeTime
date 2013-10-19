//
//  LogItemStore.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "LogItemStore.h"

@implementation LogItemStore

+(LogItemStore *)sharedStore
{
    static LogItemStore *sharedStore = nil;
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
    return [documentDirectory stringByAppendingPathComponent:@"logItems8.archive"];
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
            logItemContainer = [[LogItemContainer alloc]init];
            logItemContainer.logItems = [[NSMutableArray alloc]init];
            NSDate *todaysDate = [[NSDate alloc]init];
            logItemContainer.dateCreated =todaysDate;
            [itemContainer addObject:logItemContainer];
        }
        else
        {
            LogItemContainer *lic = [itemContainer objectAtIndex:[itemContainer count]-1];
            NSDate *todaysDate = [[NSDate alloc]init];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            NSString *lastDate = [formatter stringFromDate:lic.dateCreated];
            NSString *todaysDateString = [formatter stringFromDate:todaysDate];
            NSComparisonResult result = [lastDate compare:todaysDateString];
            if (result == NSOrderedSame){
                logItemContainer = [itemContainer objectAtIndex:[itemContainer count]-1];
                [itemContainer replaceObjectAtIndex:[itemContainer count]-1 withObject:logItemContainer];
            }
            else
            {
                logItemContainer = [[LogItemContainer alloc]init];
                logItemContainer.dateCreated = [[NSDate alloc]init];
                logItemContainer.logItems = [[NSMutableArray alloc]init];
                [itemContainer addObject:logItemContainer];
                
            }
        }
    }
    return self;
}

-(LogItem *)createItem
{
    LogItem *newItem = [[LogItem alloc]init];
    [[logItemContainer logItems] addObject:newItem];
    NSDate *d = [NSDate date];
    [newItem setDateCreated:d];
    return newItem;
}


-(NSMutableArray *)itemContainer
{
    return itemContainer;
}
-(LogItemContainer *)logItemContainer
{
    return logItemContainer;
}
-(void)removeItem:(LogItem *)i
{
    [logItemContainer.logItems removeObjectIdenticalTo:i];
    
    int count =0;
    int count1 = 0;
    NSComparisonResult result = [i.typeIntake compare:@"Fiber"];
    if (result == NSOrderedSame && i.typeIntake !=nil)
    {
        
        for (int i = 0; i < [logItemContainer.logItems count]; i++)
        {
            LogItem *itemcount =[logItemContainer.logItems objectAtIndex:i];
             NSComparisonResult result = [itemcount.typeIntake compare:@"Fiber"];
            if (result == NSOrderedSame  && itemcount.typeIntake !=nil)
                count += [itemcount.amountIntake intValue];
        }
        if (count <=25){
            if (logItemContainer.alreadySetFiberAward == YES && logItemContainer.alreadySetFiberAward !=nil)
            {
                logItemContainer.alreadySetFiberAward = NO;
                NSNotification *note = [NSNotification notificationWithName:@"fiberMeritBadgeGone" object:nil];
                [[NSNotificationCenter  defaultCenter]postNotification:note];
            }
        }
    }
    
    else if (result ==NSOrderedAscending &&i.typeIntake !=nil)
    {
        for (int i = 0; i < [logItemContainer.logItems count]; i++)
        {
            LogItem *itemcount =[logItemContainer.logItems objectAtIndex:i];
            NSComparisonResult result = [itemcount.typeIntake compare:@"Drink"];
            if (result == NSOrderedSame && itemcount.typeIntake!=nil)
                count1 += [itemcount.amountIntake intValue];
        }
        if (count1 <=40)
        {
            if (logItemContainer.alreadySetFluidAward == YES  && logItemContainer.alreadySetFluidAward !=nil)
            {
                logItemContainer.alreadySetFluidAward = NO;
                NSNotification *note = [NSNotification notificationWithName:@"fluidMeritBadgeGone" object:nil];
                [[NSNotificationCenter  defaultCenter]postNotification:note];
            }
            
        }
    }
    
}
-(void)clearData
{
    int numberOfLogItemContainers = [itemContainer count];
    LogItemContainer *container;
    for (int i = 0; i <numberOfLogItemContainers; i++)
    {
        container = [itemContainer objectAtIndex:i];
        [container.logItems removeAllObjects];
    }
    LogItemContainer *newContainer= [itemContainer lastObject];
    
    [itemContainer removeAllObjects];
    [itemContainer addObject:newContainer];
    [newContainer setAlreadySetFiberAward:NO];
    [newContainer setAlreadySetFluidAward:NO];
    [self saveChanges];
    NSNotification *note = [NSNotification notificationWithName:@"dataCleared" object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:note];
    NSNotification *note1 = [NSNotification notificationWithName:@"badgesSeen" object:nil];
    [[NSNotificationCenter  defaultCenter]postNotification:note1];
}
-(BOOL)goBack:(int)i
{
    int counter = [itemContainer count]-i;
    
    if (counter >=0)
    {
        logItemContainer = [itemContainer objectAtIndex:[itemContainer count]-i];
        return YES;
    }
    return NO;
}

-(BOOL)goForward:(int)i
{
    
    int counter = [itemContainer count]-i;
    if (counter < 0) {
        logItemContainer = [itemContainer objectAtIndex:0];
        return NO;
    }
    if (counter >=[itemContainer count])
    {
        logItemContainer = [itemContainer objectAtIndex:[itemContainer count]-1];
    }
    else{
        logItemContainer = [itemContainer objectAtIndex:[itemContainer count]-i];
    }
    return YES;
}
-(void)setFiberAward
{
    
    logItemContainer.alreadySetFiberAward = YES;
    
}

-(void)setFluidAward
{
    logItemContainer.alreadySetFluidAward = YES;
}
-(int)countFiberAwardsSet
{
    int count = [itemContainer count];
    int numberOfTypesSet = 0;
    for (int i =0; i<count; i++)
    {
        LogItemContainer *logItemContainerCounter = [itemContainer objectAtIndex:i];
        if (logItemContainerCounter.alreadySetFiberAward == YES)
            numberOfTypesSet++;
    }
    return numberOfTypesSet;
}
-(int)countFluidTypesSet
{
    int count = [itemContainer count];
    int numberOfTypesSet = 0;
    for (int i =0; i<count; i++)
    {
        LogItemContainer *logItemContainerCounter = [itemContainer objectAtIndex:i];
        if (logItemContainerCounter.alreadySetFluidAward == YES)
            numberOfTypesSet++;
    }
    return numberOfTypesSet;
}
-(void)setCurrentItemContainer
{
    logItemContainer = [[LogItemContainer alloc]init];
    logItemContainer.dateCreated = [[NSDate alloc]init];
    logItemContainer.logItems = [[NSMutableArray alloc]init];
    [itemContainer addObject:logItemContainer];
}
-(void)setPendingPoopBadges:(int)number
{

    LogItemContainer *container = [itemContainer objectAtIndex:0];
    if (number ==0) {
        container.pendingPoopBadges = 0;
    }
    else if (number == 1)
        container.pendingPoopBadges++;
    else if (number ==2)
        container.pendingPoopBadges--;
    [itemContainer setObject:container atIndexedSubscript:0];
}
-(void)setPendingPeeBadges:(int)number
{
    LogItemContainer *container = [itemContainer objectAtIndex:0];
    if (number ==0) {
        container.pendingPeeBadges = 0;
    }
    else if (number == 1)
        container.pendingPeeBadges++;
    else if (number ==2)
        container.pendingPeeBadges--;
    [itemContainer setObject:container atIndexedSubscript:0];
}
-(void)setPendingFiberBadges:(int)number
{
    LogItemContainer *container = [itemContainer objectAtIndex:0];
    if (number ==0) {
        container.pendingFiberBadges = 0;
    }
    else if (number == 1)
        container.pendingFiberBadges++;
    else if (number ==2)
        container.pendingFiberBadges--;
    [itemContainer setObject:container atIndexedSubscript:0];
}
-(void)setPendingFluidBadges:(int)number
{
    LogItemContainer *container = [itemContainer objectAtIndex:0];
    if (number ==0) {
        container.pendingFluidBadges = 0;
    }
    else if (number == 1)
        container.pendingFluidBadges++;
    else if (number ==2)
        container.pendingFluidBadges--;
    [itemContainer setObject:container atIndexedSubscript:0];
}
@end

