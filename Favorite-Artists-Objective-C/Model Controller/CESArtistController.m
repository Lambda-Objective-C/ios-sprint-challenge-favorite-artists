//
//  CESArtistController.m
//  Favorite-Artists-Objective-C
//
//  Created by Seschwan on 11/8/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

#import "CESArtistController.h"
#import "CESArtist.h"
#import "CESArtist+CESArtist_JSONSerialization.h"

@interface CESArtistController ()

@property (nonatomic) NSMutableArray<CESArtist *> *internalArtists;

@end


@implementation CESArtistController

NSString *baseURLString = @"https://www.theaudiodb.com/api/v1/json/1/search.php?";

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalArtists = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Fetch Artists
- (void)fetchArtistWithName:(NSString *)artistName completionBlock:(CESArtistControllerCompletetionBlock)completionBlock
{
    NSURLComponents *urlComponets = [[NSURLComponents alloc] initWithString:baseURLString];
    urlComponets.queryItems = @[[NSURLQueryItem queryItemWithName:@"s" value:artistName]];
    NSURL *url = urlComponets.URL;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error fetching artist: %@", error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!results) {
                   NSLog(@"Error decoding json: %@", jsonError);
                   
                   dispatch_async(dispatch_get_main_queue(), ^{
                       completionBlock(nil, jsonError);
                   });
                   
                   return;
               }
        
        //NSLog(@"%@", results);
        
        NSDictionary *searchedArtist = results[@"artists"][0];
        
      CESArtist *newArtist = [[CESArtist alloc] initWithDictionary:searchedArtist];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(newArtist, nil);
            });
    }];
    [task resume];
}

#pragma mark - Add Artists

- (void)loadArtists
{
    NSURL *documentDirectory = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:@"artists.plist"];
    NSMutableArray *artistDictionaries = [[NSDictionary alloc] initWithContentsOfURL:documentDirectory][@"artists"];
    
    for (NSDictionary *dict in artistDictionaries)
    {
        CESArtist *artist = [[CESArtist alloc] initWithDictionary:dict];
        [self.internalArtists addObject:artist];
    }
}

- (void)saveArtist
{
    NSURL *documentDirectory = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:@"artists.plist"];
       
       NSMutableArray *artistDictionaries = [[NSMutableArray alloc] init];
       
       for (CESArtist *artist in self.internalArtists)
       {
           [artistDictionaries addObject:[artist artistDataDictionary]];
       }
       
       NSDictionary *dict = @{@"artists":artistDictionaries};
       
       [dict writeToURL:documentDirectory atomically:YES];
}

- (void)addArtist:(CESArtist *)aArtist
{
    [self.internalArtists addObject:aArtist];
    [self saveArtist];
}

- (void)removeArtist:(CESArtist *)aArtist
{
    [self.internalArtists removeObject:aArtist];
    [self saveArtist];
}

- (NSArray<CESArtist *> *)artists
{
    return [self.internalArtists copy];
}

@end
