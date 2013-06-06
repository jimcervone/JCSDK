//
//  JCViewController.m
//  JCDrawerTableView
//
//  Created by James Cervone on 6/5/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "JCViewController.h"

@interface JCViewController () <JCDrawerTableViewDataSource, JCDrawerTableViewDelegate>

@property (nonatomic) NSArray *sampleArray;

@end

@implementation JCViewController

- (id)init
{
    if (!(self = [super initWithTableViewRowAnimation:UITableViewRowAnimationFade
                                       scrollPosition:UITableViewScrollPositionMiddle])) return nil;
    
    NSArray *arr = [NSArray arrayWithObjects:@"This is number one", @"dis is numba two", @"Cupertino3",@"Nerdcore Rap", nil];
    [self setSampleArray:arr];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JCDrawerTableViewDataSource Methods
- (NSInteger)drawerTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self sampleArray] count];
}

- (UITableViewCell *)drawerTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [[cell textLabel] setText:[[self sampleArray] objectAtIndex:[indexPath row]]];
    
    return cell;
}

#pragma mark - JCDrawerTableViewDelegate Methods
- (CGFloat)drawerTableView:(UITableView *)tableView heightForDrawerCellInSection:(NSInteger)section
{
    return CGRectGetHeight([[self drawerCell] frame]);
}

- (UITableViewCell *)drawerTableView:(UITableView *)tableView drawerCellForSection:(NSInteger)section
{
    return [self drawerCell];
}

@end
