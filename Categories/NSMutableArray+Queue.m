//
//  NSMutableArray+Queue.m
//  JCSDK
//
//  Created by James Cervone on 9/2/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "NSMutableArray+Queue.h"

@implementation NSMutableArray (Queue)

- (void)enqueue:(id)item
{
    [self insertObject:item atIndex:0];
}

- (id)dequeue
{
    id item = [self lastObject];
    [self removeLastObject];
    return item;
}

@end
