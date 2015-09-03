//
//  TMXParser.m
//  Cambio
//
//  Created by Paul Castronova on 6/8/15.


#import "TMXParser.h"

@implementation TMXParser

+ (NSArray *)arrayForTMXString:(NSString *)content error:(NSError **)error
{
    
    NSDictionary *parseData = [XMLParser dictionaryForXMLString:content error:error];
    
    //NSLog(@"parseData : %@", parseData);
    
    NSArray *tuArray = [[[parseData objectForKey:@"tmx"] objectForKey:@"body"] objectForKey:@"tu"];
    
    //NSLog(@"tuArray : %@", tuArray);
    if (tuArray == NULL) {
        return NULL;
    }
    
    NSMutableArray *tmxDataArray = NULL;
    
    if ([tuArray count] > 0) {
        tmxDataArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [tuArray count]; i++) {
            NSDictionary *tuDictionary = [tuArray objectAtIndex:i];
            
            TMXData *tmxData = [[TMXData alloc] init];
            tmxData.datatype = [tuDictionary objectForKey:@"datatype"];
            tmxData.tuid = [tuDictionary objectForKey:@"tuid"];
            tmxData.tuvArray = [tuDictionary objectForKey:@"tuv"];
            
            [tmxDataArray addObject:tmxData];
        }
    }
    
    return tmxDataArray;
}

@end