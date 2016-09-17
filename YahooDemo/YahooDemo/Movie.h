//
//  Movie.h
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/12/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 "poster_path": "/tgfRDJs5PFW20Aoh1orEzuxW8cN.jpg",
 "adult": false,
 "overview": "Arthur Bishop thought he had put his murderous past behind him when his most formidable foe kidnaps the love of his life. Now he is forced to travel the globe to complete three impossible assassinations, and do what he does best, make them look like accidents.",
 "release_date": "2016-08-25",
 "genre_ids": [
 80,
 28,
 53
 ],
 "id": 278924,
 "original_title": "Mechanic: Resurrection",
 "original_language": "en",
 "title": "Mechanic: Resurrection",
 "backdrop_path": "/3oRHlbxMLBXHfMqUsx1emwqiuQ3.jpg",
 "popularity": 24.229983,
 "vote_count": 244,
 "video": false,
 "vote_average": 4.52
 */

@interface Movie : NSObject

@property (nonatomic, copy) NSString *posterPath;
@property (nonatomic, copy) NSString *posterPathDetail;
@property (nonatomic) BOOL *adult;
@property (nonatomic, copy) NSString *overview;
@property (nonatomic, copy) NSDate *releaseDate;
@property (nonatomic, copy) NSArray *genreIds;
@property (nonatomic) NSInteger *id;
@property (nonatomic, copy) NSString *originalTitle;
@property (nonatomic, copy) NSString *originalLanguage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *backdropPath;
@property (nonatomic) BOOL *video;
@property (nonatomic) NSInteger *voteCount;
@property (nonatomic) NSInteger *voteAverage;
//@property (nonatomic) CGFloat popularity;


-(instancetype) init:(NSDictionary*) dic;
-(BOOL) containKeyWord:(NSString*) keyWord;

@end
