//
//  NSMutableArray+Stack.m
//  JCSDK
//
//  Created by James Cervone on 9/2/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

#pragma mark - Necessary Stack Methods
- (void)push:(id)item
{
    [self addObject:item];
}

- (id)pop
{
    id item = [self lastObject];
    [self removeLastObject];
    return item;
}

#pragma mark - Other Contextually Useful Methods
- (id)top
{
    return [self lastObject];
}

@end
