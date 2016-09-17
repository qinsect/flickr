//
//  DataService.h
//  Instragram
//
//  Created by Yanfeng Ma on 9/14/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject

// sent request from server side
+(void) sentRequest:(NSString*) urlString completionHandler:(void(^)(NSDictionary *dic, NSError* error)) completionHandler retryCounter:(NSInteger) retryCounter;

+(void) fetchNewPlayMovieData: (void(^)(NSDictionary *dic)) completionHandler retry:(BOOL) isRetry;
+(void) fetchTopRateMovieData: (void(^)(NSDictionary *dic)) completionHandler retry:(BOOL) isRetry;
+(void) fetchTrailer:(NSInteger) movieId completionHandler:(void(^)(NSDictionary *dic))  completionHandler retry:(BOOL) isRetry;

+(void) fetchNewPlayMovieData: (void(^)(NSDictionary *dic)) completionHandler;
+(void) fetchTopRateMovieData: (void(^)(NSDictionary *dic)) completionHandler;

@end
