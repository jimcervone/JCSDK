//
//  JCZipCode.h
//  JCSDK
//
//  Created by James Cervone on 6/19/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString JCRegexPattern;
typedef NSString JCCountryName;
typedef NSString JCCountryCode;

typedef void(^JCErrorCallbackBlock)();

//  2-digit codes based on ISO 3166-1 alpha-2 country codes.
typedef enum {
    JCCountryUS,
    JCCountryMX,
    JCCountryCA,
    JCCountryAU,
    JCCountryES
} JCCountry;

@interface JCZipCode : NSObject

@property (nonatomic, readonly, getter = stringValue) NSString *zipCodeString;
@property (nonatomic, readonly) JCCountry country;

+ (id)zipCodeWithString:(NSString *)string forCountry:(JCCountry)country;

- (JCCountryName *)countryName;
- (JCCountryCode *)countryCode;

@end
