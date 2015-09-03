//
//  XMLParser.h
//  Cambio
//
//  Created by Paul Castronova on 6/6/15.


#import <Foundation/Foundation.h>

extern NSString *const kXMLReaderTextNodeKey;

@interface XMLParser : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError *errorPointer;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;

@end
