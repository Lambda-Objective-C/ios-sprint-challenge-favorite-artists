//
//  CESArtistDetailVC.m
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESArtistDetailVC.h"
#import "CESArtist.h"
#import "CESArtistController.h"
#import "CESArtist+CESArtist_JSONSerialization.h"

@interface CESArtistDetailVC ()

@property (weak, nonatomic) IBOutlet UISearchBar *artistSearchBar;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
@property (weak, nonatomic) IBOutlet UILabel *yearFormed;
@property (weak, nonatomic) IBOutlet UITextView *bioTextView;


@end

@implementation CESArtistDetailVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _controller = [[CESArtistController alloc] init];
        _count = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _artistSearchBar.delegate = self;
    [self updateViews];
}

-(void)updateViews {
    self.title = self.artist.artistName ?: @"Add New Artist";
    
    if (!self.isViewLoaded || !self.artist) { return; }
    self.artistName.text = self.artist.artistName;
    self.bioTextView.text = self.artist.artistBio;
    self.yearFormed.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.artist.formedYear];
    NSLog(@"UpdateViews: %@", self.artistName);
}


- (IBAction)saveBtnPressed:(UIBarButtonItem *)sender {
    CESArtist *artist = [[CESArtist alloc] initWithArtistName:self.artistName.text biography:self.bioTextView.text yearFormed:self.artist.formedYear];
    [self.controller addArtist:artist];
      [self.navigationController popViewControllerAnimated:YES];
}

- (void)setArtist:(CESArtist *)artist
{
    if (_artist != artist) {
        _artist = artist;
        [self updateViews];
    }
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)artistSearchBar {
    
    NSLog(@"search for %@", artistSearchBar.text);
    [artistSearchBar resignFirstResponder];
    
    [self.controller fetchArtistWithName:artistSearchBar.text completionBlock:^(CESArtist *artist, NSError *error) {
        if (error) {
            NSLog(@"Unable to fetch artist");
             dispatch_async(dispatch_get_main_queue(), ^{
            self.artistName.text = @"No Results Found, Try another search. ";
             });
            return;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.artist = artist;
                NSLog(@"Artist Result: %@", self.artist);
                [self updateViews];
            });
        }
    }];
}

@end
