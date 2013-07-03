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
JCCountryCode * const JCCountryCodeUS = @"US";

JCCountryName * const JCCountryNameCA = @"Canada";
JCRegexPattern * const JCRegexPatternCA = @"[ABCEGHJKLMNPRSTVXY]\\d[ABCEGHJ-NPRSTV-Z][ ]?\\d[ABCEGHJ-NPRSTV-Z]\\d";
JCCountryCode * const JCCountryCodeCA = @"CA";

JCCountryName * const JCCountryNameMX = @"Mexico";
JCRegexPattern * const JCRegexPatternMX = @"\\d{5}";
JCCountryCode * const JCCountryCodeMX = @"MX";

JCCountryName * const JCCountryNameAU = @"Australia";
JCRegexPattern * const JCRegexPatternAU = @"\\d{4}";
JCCountryCode * const JCCountryCodeAU = @"AU";

JCCountryName * const JCCountryNameES = @"Spain";
JCRegexPattern * const JCRegexPatternES = @"\\d{5}";
JCCountryCode * const JCCountryCodeES = @"ES";

JCCountryName * const JCCountryNameGB = @"United Kingdom";
JCRegexPattern * const JCRegexPatternGB = @"GIR[ ]?0AA|((AB|AL|B|BA|BB|BD|BH|BL|BN|BR|BS|BT|CA|CB|CF|CH|CM|CO|CR|CT|CV|CW|DA|DD|DE|DG|DH|DL|DN|DT|DY|E|EC|EH|EN|EX|FK|FY|G|GL|GY|GU|HA|HD|HG|HP|HR|HS|HU|HX|IG|IM|IP|IV|JE|KA|KT|KW|KY|L|LA|LD|LE|LL|LN|LS|LU|M|ME|MK|ML|N|NE|NG|NN|NP|NR|NW|OL|OX|PA|PE|PH|PL|PO|PR|RG|RH|RM|S|SA|SE|SG|SK|SL|SM|SN|SO|SP|SR|SS|ST|SW|SY|TA|TD|TF|TN|TQ|TR|TS|TW|UB|W|WA|WC|WD|WF|WN|WR|WS|WV|YO|ZE)(\\d[\\dA-Z]?[ ]?\\d[ABD-HJLN-UW-Z]{2}))|BFPO[ ]?\\d{1,4}";
JCCountryCode * const JCCountryCodeGB = @"GB";

@interface JCCountry ()

@property (nonatomic, readwrite) JCCountryCode *code;
@property (nonatomic, readwrite) JCCountryName *name;
@property (nonatomic, readwrite) JCRegexPattern *regex;

#if TARGET_OS_IPHONE
@property (nonatomic, readwrite) UIKeyboardType keyboardType;
#endif

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
#if TARGET_OS_IPHONE
        [country setKeyboardType:UIKeyboardTypeNumberPad];
#endif
    }
    else if ([code isEqualToString:JCCountryCodeCA])
    {
        [country setCode:code];
        [country setName:JCCountryNameCA];
        [country setRegex:JCRegexPatternCA];
#if TARGET_OS_IPHONE
        [country setKeyboardType:UIKeyboardTypeNamePhonePad];
#endif
    }
    else if ([code isEqualToString:JCCountryCodeMX])
    {
        [country setCode:code];
        [country setName:JCCountryNameMX];
        [country setRegex:JCRegexPatternMX];
#if TARGET_OS_IPHONE
        [country setKeyboardType:UIKeyboardTypeNumberPad];
#endif
    }
    else if ([code isEqualToString:JCCountryCodeAU])
    {
        [country setCode:code];
        [country setName:JCCountryNameAU];
        [country setRegex:JCRegexPatternAU];
#if TARGET_OS_IPHONE
        [country setKeyboardType:UIKeyboardTypeNumberPad];
#endif
    }
    else if ([code isEqualToString:JCCountryCodeES])
    {
        [country setCode:code];
        [country setName:JCCountryNameES];
        [country setRegex:JCRegexPatternES];
#if TARGET_OS_IPHONE
        [country setKeyboardType:UIKeyboardTypeNumberPad];
#endif
    }
    else if ([code isEqualToString:JCCountryCodeGB])
    {
        [country setCode:code];
        [country setName:JCCountryNameGB];
        [country setRegex:JCRegexPatternGB];
#if TARGET_OS_IPHONE
        [country setKeyboardType:UIKeyboardTypeNamePhonePad];
#endif
    }
    
    return country;
}

+ (NSArray *)allCountries
{
    static NSArray *countries;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        countries = @[[JCCountry countryWithCode:JCCountryCodeUS],
                      [JCCountry countryWithCode:JCCountryCodeCA],
                      [JCCountry countryWithCode:JCCountryCodeMX],
                      [JCCountry countryWithCode:JCCountryCodeAU],
                      [JCCountry countryWithCode:JCCountryCodeES],
                      [JCCountry countryWithCode:JCCountryCodeGB]];
    });
    return countries;
}

- (BOOL)isEqual:(id)object
{
    if (![object isMemberOfClass:[JCCountry class]]) return NO;
    JCCountry *otherCountry = (JCCountry *)object;
    return [[self code] isEqualToString:[otherCountry code]];
}

@end
