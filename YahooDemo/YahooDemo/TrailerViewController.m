//
//  TrailerViewController.m
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/16/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import "TrailerViewController.h"
#import "YTPlayerView.h"

// https://developers.google.com/youtube/v3/guides/ios_youtube_helper
@interface TrailerViewController ()

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.playerView loadWithVideoId:@"M7lc1UVf-VE"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
