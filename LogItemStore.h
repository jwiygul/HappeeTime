//
//  LogItemStore.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogItem.h"
#import "LogItemContainer.h"

@interface LogItemStore : NSObject

{
    NSMutableArray *itemContainer;
    LogItemContainer *logItemContainer;
    
    
}
+(LogItemStore *)sharedStore;
-(BOOL)goBack:(int)i;
-(BOOL)goForward:(int)i;
-(LogItemContainer *)logItemContainer;
-(NSMutableArray *)itemContainer;
-(NSString *)itemArchivePath;
-(BOOL)saveChanges;
-(LogItem *)createItem;
-(void)removeItem:(LogItem *)i;
-(void)setFiberAward;
-(void)setFluidAward;
-(int)countFiberAwardsSet;
-(int)countFluidTypesSet;
-(void)setCurrentItemContainer;
-(void)setPendingPoopBadges:(int)number;
-(void)setPendingPeeBadges:(int)number;
-(void)setPendingFiberBadges:(int)number;
-(void)setPendingFluidBadges:(int)number;
-(void)clearData;
@end
