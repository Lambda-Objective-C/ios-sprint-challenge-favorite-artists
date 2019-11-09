//
//  CESArtistDetailVC.h
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CESArtistController;
@class CESArtist;

@interface CESArtistDetailVC : UIViewController <UISearchBarDelegate>

@property CESArtistController *controller;
@property CESArtist *artist;
@property int *count;

@end

