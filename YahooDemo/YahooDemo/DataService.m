//
//  DataService.m
//  Instragram
//
//  Created by Yanfeng Ma on 9/14/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import "DataService.h"

@implementation DataService

static NSString* MOVIE_NOW_PLAY_API = @"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";
static NSString* MOVIE_TOP_RATE_API = @"https://api.themoviedb.org/3/movie/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";

// https://api.themoviedb.org/3/movie/278/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed
static NSString* MOVIE_TRAILER_API = @"https://api.themoviedb.org/3/movie/%f/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";

static const NSInteger RETRY_COUNT = 3;
static const NSInteger NO_RETRY_COUNT = 1;

+(void) sentRequest:(NSString*) urlString completionHandler:(void(^)(NSDictionary *dic, NSError* error)) completionHandler retryCounter:(NSInteger) retryCounter{
    
    if (!urlString) {
        completionHandler(nil, nil);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];

    retryCounter--;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData * _Nullable data,
                                                                NSURLResponse * _Nullable response,
                                                                NSError * _Nullable error) {
                                                NSDictionary *responseDictionary;
                                                if (!error) {
                                                    NSError *jsonError = nil;
                                                    responseDictionary =
                                                    [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&jsonError];
                                                    
                                                    if (completionHandler) {
                                                        completionHandler(responseDictionary, jsonError);
                                                    }
                                                } else {
                                                    NSMutableString* str = [NSMutableString stringWithFormat:@"An error occurred: %@", error.description];
                                                    
                                                    if (retryCounter > 0) {
                                                        [str appendString:@", and retry."];
                                                        NSLog(@"%@", str);
                                                        
                                                        [DataService sentRequest:urlString completionHandler:completionHandler retryCounter:retryCounter];
                                                    }
                                                    else {
                                                        [str appendString:@"."];
                                                        NSLog(@"%@", str);
                                                    }
                                                }
                                            }];
    [task resume];
}

+(void) fetchTrailer:(NSInteger) movieId completionHandler:(void(^)(NSDictionary *dic)) completionHandler retry:(BOOL) isRetry{
    [DataService sentRequest:[NSString stringWithFormat:MOVIE_TRAILER_API, movieId] completionHandler:^(NSDictionary* dic, NSError* error){
        completionHandler(dic);
    } retryCounter:(isRetry ? RETRY_COUNT : NO_RETRY_COUNT)];
}

+(void) fetchNewPlayMovieData: (void(^)(NSDictionary *dic)) completionHandler retry:(BOOL) isRetry{
    [DataService sentRequest:MOVIE_NOW_PLAY_API completionHandler:^(NSDictionary* dic, NSError* error){
        completionHandler(dic);
    } retryCounter:(isRetry ? RETRY_COUNT : NO_RETRY_COUNT)];
}

+(void) fetchTopRateMovieData: (void(^)(NSDictionary *dic)) completionHandler retry:(BOOL) isRetry{
    [DataService sentRequest:MOVIE_TOP_RATE_API completionHandler:^(NSDictionary* dic, NSError* error){
        completionHandler(dic);
    } retryCounter:(isRetry ? RETRY_COUNT : NO_RETRY_COUNT)];
}

+(void) fetchNewPlayMovieData: (void(^)(NSDictionary *dic)) completionHandler {
    [DataService fetchNewPlayMovieData:completionHandler retry:false];
}

+(void) fetchTopRateMovieData: (void(^)(NSDictionary *dic)) completionHandler {
    [DataService fetchTopRateMovieData:completionHandler retry:false];
}
@end
