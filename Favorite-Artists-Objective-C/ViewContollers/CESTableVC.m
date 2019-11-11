//
//  CESTableVC.m
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESTableVC.h"
#import "CESArtistDetailVC.h"
#import "CESArtist.h"
#import "CESArtistController.h"

@interface CESTableVC ()

@property CESArtistController *artistContoller;

@end




@implementation CESTableVC

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        self.artistContoller = [[CESArtistController alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.artistContoller)
    {
        self.artistContoller = [[CESArtistController alloc] init];
        self.artist = [[CESArtist alloc] init];
    }
    [self.tableView reloadData];
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.artistContoller.artists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    CESArtist *artist = self.artistContoller.artists[indexPath.row];
    cell.textLabel.text = artist.artistName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)artist.formedYear];
    
    return cell;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ViewArtist"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CESArtistDetailVC *detailVC = segue.destinationViewController;
        detailVC.controller = self.artistContoller;
        detailVC.artist = [self.artistContoller.artists objectAtIndex:indexPath.row];
    } else if ([segue.identifier isEqualToString:@"AddNewArtist"])
    {
        CESArtistDetailVC *detailVC = segue.destinationViewController;
        detailVC.controller = self.artistContoller;
    }
    
}


@end
