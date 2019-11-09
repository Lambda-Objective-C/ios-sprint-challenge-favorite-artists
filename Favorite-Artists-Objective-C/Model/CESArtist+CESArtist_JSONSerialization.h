//
//  CESArtist+CESArtist_JSONSerialization.h
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESArtist.h"
#import "TargetConditionals.h"
#if !TARGET_OS_IOS
#import <AppKit/AppKit.h>
#endif

@interface CESArtist (CESArtist_JSONSerialization)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)artistData;


@end


