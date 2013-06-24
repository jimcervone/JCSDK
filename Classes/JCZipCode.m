//
//  JCZipCode.m
//  JCSDK
//
//  Created by James Cervone on 6/19/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "JCZipCode.h"

JCCountryName * const JCCountryNameUS = @"United States";
JCCountryCode * const JCCountryCodeUS = @"US";
//JCRegexPattern * const JCRegexPatternUS = @"\\d{5}([ \\-]\\d{4})?";
JCRegexPattern * const JCRegexPatternUS = @"[1-9]\\d{4}([ \\-]\\d{4})?";

JCCountryName * const JCCountryNameMX = @"Mexico";
JCCountryCode * const JCCountryCodeMX = @"MX";
JCRegexPattern * const JCRegexPatternMX = @"\\d{5}";

JCCountryName * const JCCountryNameCA = @"Canada";
JCCountryCode * const JCCountryCodeCA = @"CA";
JCRegexPattern * const JCRegexPatternCA = @"[ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJ-NPRSTV-Z][ ]?\\d[ABCEGHJ-NPRSTV-Z]\\d";

JCCountryName * const JCCountryNameAU = @"Australia";
JCCountryCode * const JCCountryCodeAU = @"AU";
JCRegexPattern * const JCRegexPatternAU = @"\\d{4}";

JCCountryName * const JCCountryNameES = @"Spain";
JCCountryName * const JCCountryCodeES = @"ES";
JCRegexPattern * const JCRegexPatternES = @"\\d{5}";

@interface JCZipCode ()

@property (nonatomic, readwrite) NSString *zipCodeString;
@property (nonatomic, readwrite) JCCountry country;

@end

@implementation JCZipCode

+ (id)zipCodeWithString:(NSString *)string forCountry:(JCCountry)country
{
    return [[[self class] alloc] initWithZipCodeString:string forCountry:country];
}

- (id)initWithZipCodeString:(NSString *)inputString forCountry:(JCCountry)country
{
    if (!(self = [super init])) return nil;
    
    NSString *zipString = [inputString uppercaseString];
    JCRegexPattern *regexPattern = [self regexPatternForCountry:country];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexPattern
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
    else
    {
        return nil;
    }
}

- (NSString *)countryCode
{
    return [self codeForCountry:[self country]];
}

- (NSString *)countryName
{
    return [self nameForCountry:[self country]];
}

- (NSString *)regexPatternForCountry:(JCCountry)country
{
    switch (country)
    {
        case JCCountryUS:
            return JCRegexPatternUS;
            break;
            
        case JCCountryMX:
            return JCRegexPatternMX;
            break;
            
        case JCCountryCA:
            return JCRegexPatternCA;
            break;
            
        case JCCountryAU:
            return JCRegexPatternAU;
            break;
            
        case JCCountryES:
            return JCRegexPatternES;
            break;
            
        default:
            break;
    }
}

- (JCCountryName *)nameForCountry:(JCCountry)country
{
    switch (country)
    {
        case JCCountryUS:
            return JCCountryNameUS;
            break;
            
        case JCCountryMX:
            return JCCountryNameMX;
            break;
            
        case JCCountryCA:
            return JCCountryNameCA;
            break;
            
        case JCCountryAU:
            return JCCountryNameAU;
            break;
            
        case JCCountryES:
            return JCCountryNameES;
            break;
            
        default:
            break;
    }
}

- (JCCountryCode *)codeForCountry:(JCCountry)country
{
    switch (country) {
        case JCCountryUS:
            return JCCountryCodeUS;
            break;
            
        case JCCountryMX:
            return JCCountryCodeMX;
            break;
            
        case JCCountryCA:
            return JCCountryCodeCA;
            break;
            
        case JCCountryAU:
            return JCCountryCodeAU;
            break;
            
        case JCCountryES:
            return JCCountryCodeES;
            break;
            
        default:
            break;
    }
}

@end
