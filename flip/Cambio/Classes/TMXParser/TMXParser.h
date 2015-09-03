//
//  TMXParser.h
//  Cambio
//
//  Created by Paul Castronova on 6/8/15.


#import <Foundation/Foundation.h>

#import "XMLParser.h"
#import "TMXData.h"

@interface TMXParser : NSObject

+ (NSArray *)arrayForTMXString:(NSString *)string error:(NSError **)error;

@end
