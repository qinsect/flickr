//
//  Movie.m
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/12/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import "Movie.h"

@implementation Movie

//https://image.tmdb.org/t/p/w92/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg

-(instancetype) init:(NSDictionary*) dic {
    if (self == [super init]) {
        self.title = [dic objectForKey:@"title"];
        self.posterPath = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w92%@", [dic objectForKey:@"poster_path"]];
        self.posterPathDetail = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w342%@", [dic objectForKey:@"poster_path"]];
        self.overview = [dic objectForKey:@"overview"];
    }
    return self;
}

-(BOOL) containKeyWord:(NSString*) keyWord {
    if ([self.title rangeOfString:keyWord options:NSCaseInsensitiveSearch].location != NSNotFound) {
        return YES;
    }
    else if ([self.overview rangeOfString:keyWord options:NSCaseInsensitiveSearch].location != NSNotFound) {
        return YES;
    }
    return NO;
}
@end
