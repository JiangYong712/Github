//
//  BookObject.m
//  Cambio
//
//  Created by Paul Castronova on 9/10/15.
//  Copyright (c) 2015 Paul Castronova. All rights reserved.
//

#import "BookObject.h"

@interface BookObject ()


@end


@implementation BookObject

@synthesize m_pTMXFileName;
@synthesize m_pBookTitleString;
@synthesize m_pBookDescString;
@synthesize m_pBookIconImageString;
@synthesize m_pBookImageString;
@synthesize m_pBookPriceString;

- (id)init
{
    if (self = [super init])
    {
        m_pTMXFileName = NULL;
        m_pBookTitleString = NULL;
        m_pBookDescString = NULL;
        m_pBookIconImageString = NULL;
        m_pBookImageString = NULL;
        m_pBookPriceString = NULL;
        
    }
    return self;
}


@end
