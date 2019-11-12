//
//  CESArtist+CESArtist_JSONSerialization.m
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESArtist+CESArtist_JSONSerialization.h"
#import "CESArtist.h"
#import "TargetConditionals.h"
#if !TARGET_OS_IOS
#import <AppKit/AppKit.h>
#endif

@implementation CESArtist (CESArtist_JSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        NSString *artistName = [dictionary objectForKey:@"strArtist"];
        NSString *biography = [dictionary objectForKey:@"strBiographyEN"];
        int formedYear = [[dictionary objectForKey:@"intFormedYear"] intValue];
        
        self = [self initWithArtistName:artistName biography:biography yearFormed:formedYear];
    }
    return self;
}

- (NSDictionary *)artistDataDictionary
{
    return @{@"strBiographyEN": self.artistBio, @"strArtist": self.artistName, @"intFormedYear":[[NSNumber alloc] initWithInt:self.formedYear]};
}


@end
