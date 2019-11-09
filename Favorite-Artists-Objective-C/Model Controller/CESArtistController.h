//
//  CESArtistController.h
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CESArtist.h"

typedef void (^CESArtistControllerCompletetionBlock)(CESArtist *, NSError *);

@interface CESArtistController : NSObject

#pragma mark - Fetch Artists
- (void)fetchArtistWithName:(NSString *)artistName
            completionBlock:(CESArtistControllerCompletetionBlock)completionBlock;

@property NSMutableArray *artists;
- (NSMutableArray *)artistsArray;

- (CESArtist *)objectInArtistsAtIndex:(NSUInteger)index;

- (void)addArtistWithName:(NSString *)name
                artistBio:(NSString *)bio
               yearFormed:(int)year;

- (void)update:(CESArtist *)artist
withArtistName:(NSString *)name
     biography:(NSString *)bio
    yearFormed:(int)year;


@end


