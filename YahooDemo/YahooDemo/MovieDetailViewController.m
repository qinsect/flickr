//
//  MovieDetailViewController.m
//  YahooDemo
//
//  Created by Yanfeng Ma on 9/12/16.
//  Copyright © 2016 Yanfeng Ma. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;
//@property (weak, nonatomic) IBOutlet UIView *infoView;
//@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
//@property (weak, nonatomic) IBOutlet UILabel *voteRate;
@property (weak, nonatomic) IBOutlet UILabel *popular;
@property (weak, nonatomic) IBOutlet UILabel *overviewView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleView.text = [self.movie title];
    self.overviewView.text = [self.movie overview];
    self.detailScrollView.delegate = self;
//    self.detailScrollView.minimumZoomScale = 0.25;
//    self.detailScrollView.maximumZoomScale = 2;
//    self.detailScrollView.zoomScale = 0.5;
    
    /*
     override func viewDidLoad() {
     super.viewDidLoad()
     scrollView.delegate = self
     scrollView.minimumZoomScale = 0.25
     scrollView.maximumZoomScale = 2
     
     let image = UIImage(named: "romanesco-broccoli")
     imageView = UIImageView(image: image)
     scrollView.contentSize = image!.size
     scrollView.addSubview(imageView)
     scrollView.zoomScale = 0.5
     }
     
     func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
     return imageView
     }
     */

//    self.overviewLabel.text = [self.movie overview];
//    [self.overviewLabel sizeToFit];
//    
//    CGRect frame = self.infoView.frame;
//    frame.size.height = self.overviewLabel.frame.size.height + self.overviewLabel.frame.origin.y + 10;
//    self.infoView.frame = frame;
//    
//    self.detailScrollView.contentSize = CGSizeMake(self.detailScrollView.frame.size.width, 60 + self.infoView.frame.origin.y + self.infoView.frame.size.height);
//    
//    CGFloat width = self.detailScrollView.bounds.size.width;
//    CGFloat height = self.detailScrollView.bounds.size.height;
//
//    [self.detailScrollView setContentSize:CGSizeMake(width, height)];
//    
//    CGFloat subviewHeight = 120;
//    CGFloat currentViewOffset = 0;
//    
//    while (currentViewOffset < height) {
//        CGRect frame = CGRectMake(0, currentViewOffset, width, subviewHeight);
//
//        //rectByInsetting(dx: 5, dy: 5)
////        CGFloat hue = currentViewOffset/height;
//        UIView* view = [[UIView alloc] initWithFrame:frame];
////        UIView* subview = UIView(frame: frame)
//        view.backgroundColor = [UIColor whiteColor];
//        [self.detailScrollView addSubview: view];
//        
//        currentViewOffset += subviewHeight;
//    }
    
    self.detailScrollView.delegate = self;
//    scrollview.delegate = self
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.detailImageView setImageWithURL:[NSURL URLWithString: [self.movie posterPathDetail]]];
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.detailImageView;
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
