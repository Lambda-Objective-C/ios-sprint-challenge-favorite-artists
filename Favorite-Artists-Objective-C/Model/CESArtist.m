//
//  CESArtist.m
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESArtist.h"

@implementation CESArtist

- (instancetype)initWithArtistName:(NSString *)name biography:(NSString *)bio yearFormed:(int)year
{
    if (self = [super init])
    {
        _artistName = name;
        _artistBio = bio;
        _formedYear = year;
    }
    return self;
}


@end
