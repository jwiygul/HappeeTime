//
//  OutputLogCell.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "OutputLogCell.h"

@implementation OutputLogCell
@synthesize timeLabel,amountLabel,infoImage,controller,tableView;
- (IBAction)seeInfoBehindImage:(id)sender {
    NSString *selector = NSStringFromSelector(_cmd);
    selector = [selector stringByAppendingString:@"atIndexPath:"];
    SEL newSelector = NSSelectorFromString(selector);
    NSIndexPath *indexPath = [[self tableView]indexPathForCell:self];
    
    if (indexPath) {
        if ([[self controller]respondsToSelector:newSelector])
        {
            [[self controller]performSelector:newSelector withObject:sender withObject:indexPath];
        }
    }
    
    
}

-(void)setCharacterWithInfoType:(NSString *)infoType
{
    if (infoType == nil)
    {
        infoImage.image = nil;
    }
    
    if (infoType != nil)
    {
        NSComparisonResult result = [infoType compare:@"Dryness"];
        NSComparisonResult poopResult = [infoType compare:@"poopStar"];
        if (result == NSOrderedSame)
        {
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                infoImage.image = [UIImage imageNamed:@"FlushiPad.png"];
            else
                infoImage.image = [UIImage imageNamed:@"FlushiPhone.png"];
        }
        else if (poopResult == NSOrderedSame)
        {
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
                infoImage.image = [UIImage imageNamed:@"PoopiPad.png"];
            else
                infoImage.image = [UIImage imageNamed:@"PoopiPhone.png"];
        }
    }
}

@end
