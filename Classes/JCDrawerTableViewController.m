//
//  JCDrawerTableViewController.m
//  JCDrawerTableView
//
//  Created by James Cervone on 6/5/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "JCDrawerTableViewController.h"

@interface JCDrawerTableViewController () <JCDrawerTableViewDataSource, JCDrawerTableViewDelegate>

@property (nonatomic, readwrite) NSIndexPath *selectedIndexPath;

@end

@implementation JCDrawerTableViewController

#pragma mark - Initializers
- (id)init
{
    if (!(self = [super init])) return nil;
    
    [self setTableViewRowAnimation:UITableViewRowAnimationNone];
    [self setTableViewScrollPosition:UITableViewScrollPositionNone];
    
    return self;
}

- (id)initWithTableViewRowAnimation:(UITableViewRowAnimation)animation scrollPosition:(UITableViewScrollPosition)scrollPosition
{
    if (!(self = [super init])) return nil;
    
    [self setTableViewRowAnimation:animation];
    [self setTableViewScrollPosition:scrollPosition];
    
    return self;
}

#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSInteger drawerCount = 0;
    if ([self selectedIndexPath] != nil)
        if ([[self selectedIndexPath] section] == section)
            drawerCount++;
    
    NSInteger numberOfRowsInSection = [self drawerTableView:tableView numberOfRowsInSection:section];
    return numberOfRowsInSection+drawerCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *originalIndexPath = indexPath;
    if ([self selectedIndexPath] != nil)
    {
        NSIndexPath *drawerIndexPath = [NSIndexPath indexPathForRow:([[self selectedIndexPath] row]+1)
                                                          inSection:[[self selectedIndexPath] section]];
        if ([indexPath isEqual:drawerIndexPath])
            return [self drawerTableView:tableView drawerCellForSection:[indexPath section]];
        
        else if ([indexPath row] > [[self selectedIndexPath] row]+1)
            originalIndexPath = [NSIndexPath indexPathForRow:([indexPath row]-1) inSection:[indexPath section]];
    }
    UITableViewCell *cell = [self drawerTableView:tableView cellForRowAtIndexPath:originalIndexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self numberOfSectionsInDrawerTableView:tableView];
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *newDrawerIndexPath = [NSIndexPath indexPathForRow:([indexPath row]+1)
                                                         inSection:[indexPath section]];
    NSArray *newDrawerIndexPathArray = [NSArray arrayWithObject:newDrawerIndexPath];
    
    if ([self selectedIndexPath] == nil)
    {
        //  open new drawer
        [self setSelectedIndexPath:indexPath];
        [tableView insertRowsAtIndexPaths:newDrawerIndexPathArray withRowAnimation:[self tableViewRowAnimation]];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:[self tableViewScrollPosition] animated:YES];
        
        //  call delegate method
        [self drawerTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
        NSIndexPath *previousDrawerIndexPath = [NSIndexPath indexPathForRow:([[self selectedIndexPath] row]+1)
                                                                  inSection:[[self selectedIndexPath] section]];
        NSArray *previousDrawerIndexPathArray = [NSArray arrayWithObject:previousDrawerIndexPath];
        
        if ([[self selectedIndexPath]isEqual:indexPath])
        {
            //  close already-open drawer
            [self setSelectedIndexPath:nil];
            [tableView deleteRowsAtIndexPaths:previousDrawerIndexPathArray withRowAnimation:[self tableViewRowAnimation]];
            
            //  call delegate method
            [self drawerTableView:tableView didSelectRowAtIndexPath:indexPath];
        }
        else if ([previousDrawerIndexPath isEqual:indexPath] == NO)
        {
            //  close already-open drawer
            [self setSelectedIndexPath:nil];
            [tableView deleteRowsAtIndexPaths:previousDrawerIndexPathArray withRowAnimation:[self tableViewRowAnimation]];
            
            //  decrement for the case of row being below previous drawer
            if ([previousDrawerIndexPath row] < [indexPath row])
            {                
                newDrawerIndexPath = [NSIndexPath indexPathForRow:([newDrawerIndexPath row]-1)
                                                        inSection:[newDrawerIndexPath section]];
                newDrawerIndexPathArray = [NSArray arrayWithObject:newDrawerIndexPath];
                
                indexPath = [NSIndexPath indexPathForRow:([indexPath row]-1) inSection:[indexPath section]];
            }
            
            //  open new drawer
            [self setSelectedIndexPath:indexPath];
            [tableView insertRowsAtIndexPaths:newDrawerIndexPathArray withRowAnimation:[self tableViewRowAnimation]];
            
            //  call delegate method
            [self drawerTableView:tableView didSelectRowAtIndexPath:indexPath];
        }
        //else - do nothing
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self selectedIndexPath] != nil)
    {
        NSIndexPath *drawerIndexPath = [NSIndexPath indexPathForRow:([[self selectedIndexPath] row]+1)
                                                                  inSection:[[self selectedIndexPath] section]];
        if ([indexPath isEqual:drawerIndexPath])
            return [self drawerTableView:tableView heightForDrawerCellInSection:[indexPath section]];
    }
    return [self drawerTableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self drawerTableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [self drawerTableView:tableView heightForFooterInSection:section];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self drawerTableView:tableView viewForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [self drawerTableView:tableView viewForFooterInSection:section];
}

#pragma mark - Default Methods
- (NSInteger)numberOfSectionsInDrawerTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)drawerTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)drawerTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)drawerTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (CGFloat)drawerTableView:(UITableView *)tableView heightForDrawerCellInSection:(NSInteger)section
{
    NSLog(@"ERROR: No implementation of -drawerTableView:heightForDrawerCellInSection:");
    return 0;
}

- (UITableViewCell *)drawerTableView:(UITableView *)tableView drawerCellForSection:(NSInteger)section
{
    NSLog(@"ERROR: No implementation of -drawerTableView:drawerCellForSection:");
    return nil;
}

- (void)drawerTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}

- (UITableViewCell *)drawerTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ERROR: No implementation of -drawerTableView:cellForRowAtIndexPath");
    return nil;
}

- (NSInteger)drawerTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
