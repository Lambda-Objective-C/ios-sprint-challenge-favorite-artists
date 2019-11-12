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

@property (nonatomic, readonly, copy) NSArray<CESArtist *> *artists;

- (void)loadArtists;
- (void)addArtist:(CESArtist *)aArtist;
- (void)removeArtist:(CESArtist *)aArtist;
@end


