//
//  CESTableVC.h
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CESArtist.h"
#import "CESArtistController.h"


@interface CESTableVC : UITableViewController

@property CESArtist *artist;
@property (nonatomic)CESArtistController *controller;

@end


