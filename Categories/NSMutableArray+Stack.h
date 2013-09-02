//
//  NSMutableArray+Stack.h
//  JCSDK
//
//  Created by James Cervone on 9/2/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)

- (void)push:(id)item;
- (id)pop;

@end
