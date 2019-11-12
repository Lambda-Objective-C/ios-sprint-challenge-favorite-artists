//
//  CESArtist.h
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CESArtist : NSObject

#pragma mark - Properties
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *artistBio;
@property (nonatomic) int formedYear;

#pragma mark - Methods
- (instancetype)initWithArtistName:(NSString *)name
                         biography:(NSString *)bio
                        yearFormed:(int)year;

@end


