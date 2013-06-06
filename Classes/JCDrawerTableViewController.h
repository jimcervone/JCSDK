//
//  JCDrawerTableViewController.h
//  JCDrawerTableView
//
//  Created by James Cervone on 6/5/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JCDrawerTableViewDataSource <NSObject>

@required

- (NSInteger)drawerTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)drawerTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (UITableViewCell *)drawerTableView:(UITableView *)tableView drawerCellForSection:(NSInteger)section;
- (CGFloat)drawerTableView:(UITableView *)tableView heightForDrawerCellInSection:(NSInteger)section;

- (NSInteger)numberOfSectionsInDrawerTableView:(UITableView *)tableView;

@end

@protocol JCDrawerTableViewDelegate <NSObject>

@optional
- (void)drawerTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)drawerTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)drawerTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)drawerTableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

- (UIView *)drawerTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)drawerTableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

@end

@interface JCDrawerTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) UITableViewRowAnimation tableViewRowAnimation;
@property (nonatomic) UITableViewScrollPosition tableViewScrollPosition;

#pragma mark - Initialization Methods
- (id)init;
- (id)initWithTableViewRowAnimation:(UITableViewRowAnimation)animation scrollPosition:(UITableViewScrollPosition)scrollPosition;

#pragma mark - Getter Method For Selected Index Path
- (NSIndexPath *)selectedIndexPath;

@end
