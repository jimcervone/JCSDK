//
//  JCViewController.m
//  JCZipCode-Sample
//
//  Created by James Cervone on 6/19/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "JCViewController.h"
#import "JCZipCode.h"

@interface JCViewController ()

@end

@implementation JCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadZipCodes];
    
}

- (void)loadZipCodes
{
    JCZipCode *zipCode;
    zipCode = [JCZipCode zipCodeWithString:@"15220" forCountry:JCCountryUS];
    NSLog(@"%@",[zipCode stringValue]);
    
    zipCode = [JCZipCode zipCodeWithString:@"15220-2028" forCountry:JCCountryUS];
    NSLog(@"%@",[zipCode stringValue]);

    zipCode = [JCZipCode zipCodeWithString:@"02145" forCountry:JCCountryUS];
    NSLog(@"%@",[zipCode stringValue]);

    zipCode = [JCZipCode zipCodeWithString:@"123456" forCountry:JCCountryUS];
    NSLog(@"%@",[zipCode stringValue]);
    
    zipCode = [JCZipCode zipCodeWithString:@"12345" forCountry:JCCountryMX];
    NSLog(@"%@",[zipCode stringValue]);
    
    zipCode = [JCZipCode zipCodeWithString:@"A1B 2R4" forCountry:JCCountryCA];
    NSLog(@"%@",[zipCode stringValue]);

}

@end
