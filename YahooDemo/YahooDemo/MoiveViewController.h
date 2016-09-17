//
//  ViewController.h
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/12/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface MoiveViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) MovieType movieType;

@end

