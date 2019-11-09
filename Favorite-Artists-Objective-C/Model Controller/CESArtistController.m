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


@implementation CESArtistController

NSString *baseURLString = @"https://www.theaudiodb.com/api/v1/json/1/search.php?";

- (instancetype)init
{
    self = [super init];
    if (self) {
        _artists = [@[] mutableCopy];
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
            completionBlock(nil, error);
            return;
        }
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error)
        {
            NSLog(@"JSON Error: %@", error);
            completionBlock(nil, error);
            return;
        }
        
        NSArray *jsonDictionary = json[@"artists"];
        
        if (jsonDictionary != (id) [NSNull null])
        {
            CESArtist *artist = [[CESArtist alloc] initWithDictionary:jsonDictionary[0]];
            [self.artists addObject:artist];
            completionBlock(artist, nil);
        }
        NSLog(@"Error: %@", error);
        completionBlock(nil, error);
        
    }];
    [task resume];
}

#pragma mark - Add Artists

- (void)addArtistWithName:(NSString *)name artistBio:(NSString *)bio yearFormed:(int)year
{
    CESArtist *artist = [[CESArtist alloc] initWithArtistName:name biography:bio yearFormed:year];
    [self.artists addObject:artist];
    NSLog(@"Artist created from Controller");
}


- (NSMutableArray *)artistsArray
{
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directory = [searchPath objectAtIndex:0];
    NSArray *filePaths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:directory error:nil];
    
    for (NSString *artist in filePaths)
    {
        NSString *filePath = [[NSString alloc] initWithFormat:@"Documents/@", artist];
        NSString *artistPath = [NSHomeDirectory()stringByAppendingPathComponent:filePath];
        
        NSURL *artistURL = [NSURL fileURLWithPath:artistPath];
        NSData *artistData = [[NSData alloc] initWithContentsOfURL:artistURL];
        
        if (artistData != nil)
        {
            NSDictionary *artistDictionary = [NSJSONSerialization JSONObjectWithData:artistData options:0 error:nil];
            CESArtist *artist = [[CESArtist alloc] initWithDictionary:artistDictionary];
            [self.artists addObject:artist];
        } else {
            NSLog(@"Artist data is nil");
        }
    }
    return self.artists;
}

@end
