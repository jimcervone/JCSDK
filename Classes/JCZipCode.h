//
//  JCZipCode.h
//  JCSDK
//
//  Created by James Cervone on 6/19/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//
//  2-digit codes based on ISO 3166-1 alpha-2 country codes.

#import <Foundation/Foundation.h>

#if TARGET_OS_IPHONE
#import <UIKit/UITextInputTraits.h>
#endif

@class JCZipCode;
@class JCCountry;

#pragma mark JCZipcode
@interface JCZipCode : NSObject

@property (nonatomic, readonly, getter = stringValue) NSString *zipCodeString;
@property (nonatomic, readonly) JCCountry *country;

+ (id)zipCodeWithString:(NSString *)string forCountry:(JCCountry *)country;

@end

#pragma mark - JCCountry
typedef NSString JCCountryCode;
typedef NSString JCCountryName;
typedef NSString JCRegexPattern;

extern JCCountryCode * const JCCountryCodeUS;
extern JCCountryCode * const JCCountryCodeMX;
extern JCCountryCode * const JCCountryCodeCA;
extern JCCountryCode * const JCCountryCodeAU;
extern JCCountryCode * const JCCountryCodeES;
extern JCCountryCode * const JCCountryCodeGB;

@interface JCCountry : NSObject

+ (id)countryWithCode:(JCCountryCode *)code;
+ (NSArray *)allCountries;
- (BOOL)isEqual:(id)object;

@property (nonatomic, readonly) JCCountryCode *code;
@property (nonatomic, readonly) JCCountryName *name;
@property (nonatomic, readonly) JCRegexPattern *regex;

#if TARGET_OS_IPHONE
@property (nonatomic, readonly) UIKeyboardType keyboardType;
#endif

@end
