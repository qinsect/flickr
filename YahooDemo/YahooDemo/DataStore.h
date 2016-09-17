//
//  DataStore.h
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/12/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MovieType) {
    MT_NOW_PLAYING,
    MT_TOP_RATE
};

@protocol DataStoreDelegate <NSObject>

- (void) dataUpdate:(NSArray*) data dataType:(MovieType) movieType;

@end

@interface DataStore : NSObject

+(DataStore*) sharedInstance;
-(NSArray*) getMovies:(void(^)(NSArray* array)) complationHandler type:(MovieType)movieType force:(BOOL)force;

-(NSArray*) filterMoviesByKeyWord:(NSString*) keyWord movieType:(MovieType)movieType;

@end
