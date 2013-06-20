//
//  UITableViewCell+JCIBExtensions.m
//  JCSDK
//
//  Created by James Cervone on 6/19/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "UITableViewCell+JCIBExtensions.h"

@implementation UITableViewCell (JCIBExtensions)

+ (id)cellObject
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] objectAtIndex:0];
}

+ (CGFloat)cellHeight
{
    return CGRectGetHeight([[self cellObject] frame]);
}

@end
