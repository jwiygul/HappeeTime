//
//  OutputLogItemStore.h
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutputLogItem.h"
#import "OutputLogItemContainer.h"

@interface OutputLogItemStore : NSObject
{
    NSMutableArray *itemContainer;
    OutputLogItemContainer *outputLogItemContainer;
}

+(OutputLogItemStore *)sharedStore;
-(BOOL)goBack:(int)i;
-(BOOL)goForward:(int)i;
-(OutputLogItemContainer *)outputLogItemContainer;
-(NSMutableArray *)itemContainer;
-(NSString *)itemArchivePath;
-(BOOL)saveChanges;
-(OutputLogItem *)createItem;
-(void)removeItem:(OutputLogItem *)i;
-(void)alreadySetPeeAward;
-(int)countPeeAwardsSet;
-(void)alreadySetPoopAward;
-(int)countPoopAwardsSet;
-(void)setCurrentItemContainer;
-(void)clearData;
@end
