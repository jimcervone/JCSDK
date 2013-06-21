//
//  JCZipCode.m
//  JCSDK
//
//  Created by James Cervone on 6/19/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import "JCZipCode.h"

typedef NSString JCRegexPattern;

//JCRegexPattern * const JCRegexPatternUS = @"\\d{5}([ \\-]\\d{4})?";
JCRegexPattern * const JCRegexPatternUS = @"[1-9]\\d{4}([ \\-]\\d{4})?";
JCRegexPattern * const JCRegexPatternMX = @"\\d{5}";
JCRegexPattern * const JCRegexPatternCA = @"[ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJ-NPRSTV-Z][ ]?\\d[ABCEGHJ-NPRSTV-Z]\\d";
JCRegexPattern * const JCRegexPatternAU = @"\\d{4}";
JCRegexPattern * const JCRegexPatternES = @"\\d{5}";

@interface JCZipCode ()

@property (nonatomic, readwrite) NSString *zipCodeString;

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
        return self;
    }
    else
    {
        return nil;
    }        
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

@end
