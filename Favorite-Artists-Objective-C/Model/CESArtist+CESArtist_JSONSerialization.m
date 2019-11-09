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

- (NSDictionary *)artistData
{
    NSMutableDictionary *artistData = [NSMutableDictionary dictionary];
    
    NSString *stringYearFormed = @(self.formedYear).stringValue;
    
    [artistData setObject:self.artistName forKey:@"strArtist"];
    [artistData setObject:self.artistBio forKey:@"strBiographyEN"];
    [artistData setObject:stringYearFormed forKey:@"intFormedYear"];
    
    NSDictionary *artistDataDictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.artistName, @"strArtist",self.artistBio, @"strBiographyEN", stringYearFormed, @"intFormedYear", nil];
    
    
    return artistDataDictionary;
}


@end
