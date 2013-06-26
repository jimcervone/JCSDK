//
//  JCZipCode.m
//  JCSDK
//
//  Created by James Cervone on 6/19/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "JCZipCode.h"

#pragma mark JCZipCode
@interface JCZipCode ()

@property (nonatomic, readwrite) NSString *zipCodeString;
@property (nonatomic, readwrite) JCCountry *country;

@end

@implementation JCZipCode

+ (id)zipCodeWithString:(NSString *)string forCountry:(JCCountry *)country
{
    return [[[self class] alloc] initWithZipCodeString:string forCountry:country];
}

- (id)initWithZipCodeString:(NSString *)inputString forCountry:(JCCountry *)country
{
    if (!(self = [super init])) return nil;
    
    NSString *zipString = [inputString uppercaseString];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:[country regex]
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    NSRange range = [regex rangeOfFirstMatchInString:zipString
                                             options:0
                                               range:NSMakeRange(0, [zipString length])];
    
    
    if (range.length == [zipString length] && range.location == 0)
    {
        [self setZipCodeString:zipString];
        [self setCountry:country];
        return self;
    }
    
    return nil;
}

@end

#pragma mark - JCCountry

JCCountryName * const JCCountryNameUS = @"United States";
JCRegexPattern * const JCRegexPatternUS = @"\\d{5}([ \\-]\\d{4})?";

JCCountryName * const JCCountryNameCA = @"Canada";
JCRegexPattern * const JCRegexPatternCA = @"[ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJ-NPRSTV-Z][ ]?\\d[ABCEGHJ-NPRSTV-Z]\\d";

JCCountryName * const JCCountryNameMX = @"Mexico";
JCRegexPattern * const JCRegexPatternMX = @"\\d{5}";

JCCountryName * const JCCountryNameAU = @"Australia";
JCRegexPattern * const JCRegexPatternAU = @"\\d{4}";

JCCountryName * const JCCountryNameES = @"Spain";
JCRegexPattern * const JCRegexPatternES = @"\\d{5}";

@interface JCCountry ()

@property (nonatomic, readwrite) JCCountryCode *code;
@property (nonatomic, readwrite) JCCountryName *name;
@property (nonatomic, readwrite) JCRegexPattern *regex;

@end

@implementation JCCountry

+ (id)countryWithCode:(JCCountryCode *)code
{
    JCCountry *country = [[JCCountry alloc] init];
    
    if ([code isEqualToString:JCCountryCodeUS])
    {
        [country setCode:code];
        [country setName:JCCountryNameUS];
        [country setRegex:JCRegexPatternUS];
    }
    else if ([code isEqualToString:JCCountryCodeCA])
    {
        [country setCode:code];
        [country setName:JCCountryNameCA];
        [country setRegex:JCRegexPatternCA];
    }
    else if ([code isEqualToString:JCCountryNameMX])
    {
        [country setCode:code];
        [country setName:JCCountryNameMX];
        [country setRegex:JCRegexPatternMX];
    }
    else if ([code isEqualToString:JCCountryCodeAU])
    {
        [country setCode:code];
        [country setName:JCCountryNameAU];
        [country setRegex:JCRegexPatternAU];
    }
    else if ([code isEqualToString:JCCountryCodeES])
    {
        [country setCode:code];
        [country setName:JCCountryNameES];
        [country setRegex:JCRegexPatternES];
    }
    
    return country;
}

//all countries
+ (NSArray *)allCountries
{
    static NSArray *countries;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        countries = @[[JCCountry countryWithCode:JCCountryCodeUS],
                      [JCCountry countryWithCode:JCCountryCodeCA],
                      [JCCountry countryWithCode:JCCountryCodeMX],
                      [JCCountry countryWithCode:JCCountryCodeAU],
                      [JCCountry countryWithCode:JCCountryCodeES]];
    });
    return countries;
}

@end
