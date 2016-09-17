//
//  MovieCells.h
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/12/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieCells : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;

@end
