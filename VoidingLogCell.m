//
//  VoidingLogCell.m
//  UroApp
//
//  Created by Jeremy Wiygul on 10/29/12.
//  Copyright (c) 2012 Jeremy Wiygul. All rights reserved.
//

#import "VoidingLogCell.h"

@implementation VoidingLogCell
@synthesize timeLabel,typeLabel,whatLabel,amountLabel,infoImage,controller, tableView;

-(void)setCharacter:(UIImage *)image withInfoType:(NSString *)infoType
{
    if (image == nil)
    {
        infoImage.image = nil;
    }
    else
        infoImage.image = image;

    
}


- (IBAction)seeInfoBehindImage:(id)sender
{
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
@end
