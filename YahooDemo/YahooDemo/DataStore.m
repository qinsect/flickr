//
//  DataStore.m
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/12/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import "DataStore.h"
#import "Movie.h"
#import "DataService.h"

@interface DataStore ()

@property (nonatomic) NSMutableDictionary* dic;

@end

@implementation DataStore

static NSString* MOVIE_PLAYING = @"movice_playing";
static NSString* TOP_RATE = @"top_rate";

-(instancetype) init {
    if (self == [super init]) {
        // build dataService in here
        self.dic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+(DataStore*) sharedInstance
{
    static DataStore *dataStore;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataStore = [[DataStore alloc] init];
    });
    
    return dataStore;
}

-(NSString*) type2NameString:(MovieType) movieType {
    if (movieType == MT_TOP_RATE) {
        return TOP_RATE;
    }
    else if (movieType == MT_NOW_PLAYING) {
        return MOVIE_PLAYING;
    }
    return nil;
}

-(NSArray*) filterMoviesByKeyWord:(NSString*) keyWord movieType:(MovieType)movieType {
    NSString* key = [self type2NameString:movieType];
    if (key) {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        for (Movie* item in [_dic objectForKey:key]) {
            if ([item containKeyWord:keyWord]) {
                [array addObject:item];
            }
        }
        return array;
    }
    return nil;
}

-(NSArray*) getMovies:(void(^)(NSArray* array)) complationHandler type:(MovieType)movieType force:(BOOL)force {
    
    if (!force) {
        NSString* key = [self type2NameString:movieType];
        if(_dic && [_dic objectForKey:key]) {
            return [_dic objectForKey:key];
        }
    }
    
    if (movieType == MT_NOW_PLAYING) {
        [DataService fetchNewPlayMovieData:^(NSDictionary *dic) {
                NSArray* array = [dic objectForKey:@"results"];
                NSMutableArray* movieArray = [[NSMutableArray alloc] init];
                for (NSDictionary* item in array) {
                    [movieArray addObject:[[Movie alloc] init:item]];
                }
                [self.dic setObject:movieArray forKey:MOVIE_PLAYING];
                
                if(complationHandler){
                    complationHandler(movieArray);
                }
            }];
    }
    else if (movieType == MT_TOP_RATE) {
            [DataService fetchTopRateMovieData:^(NSDictionary *dic) {
                NSArray* array = [dic objectForKey:@"results"];
                NSMutableArray* movieArray = [[NSMutableArray alloc] init];
                for (NSDictionary* item in array) {
                    [movieArray addObject:[[Movie alloc] init:item]];
                }
                [self.dic setObject:movieArray forKey:TOP_RATE];
                
                if(complationHandler){
                    complationHandler(movieArray);
                }
            }];
    }
    
    return nil;
}

// always call api directly
-(NSArray*) getMovieTrailer:(NSInteger)movieId complationHandler:(void(^)(NSArray* array)) complationHandler type:(MovieType)movieType {
    return nil;
}

@end
