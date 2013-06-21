//
//  JCZipCode.h
//  JCSDK
//
//  Created by James Cervone on 6/19/13.
//  Copyright (c) 2013 Jim Cervone. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^JCErrorCallbackBlock)();

//  2-digit codes based on ISO 3166-1 alpha-2 country codes.
typedef enum {
    JCCountryUS,
    JCCountryMX,
    JCCountryCA
} JCCountry;

@interface JCZipCode : NSObject

@property (nonatomic, readonly, getter = stringValue) NSString *zipCodeString;

+ (id)zipCodeWithString:(NSString *)string forCountry:(JCCountry)country;

@end
