//
//  BookObject.h
//  Cambio
//
//  Created by Paul Castronova on 9/10/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookObject : NSObject
{

}

@property (nonatomic, strong) NSString *m_pTMXFileName;
@property (nonatomic, strong) NSString *m_pBookTitleString;
@property (nonatomic, strong) NSString *m_pBookDescString;
@property (nonatomic, strong) NSString *m_pBookIconImageString;
@property (nonatomic, strong) NSString *m_pBookImageString;
@property (nonatomic, strong) NSString *m_pBookPriceString;

@end
