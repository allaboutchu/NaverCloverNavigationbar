//
//  ViewController.m
//  NaverCloverNavigationBar
//
//  Created by KIMDONGUK on 2018. 6. 16..
//  Copyright © 2018년 godeun. All rights reserved.
//

#define kNavigationBarTitle @"Title"

#import "ViewController.h"

const double NAVIGATION_HEIGHT = 44.0;

@interface ViewController () {
    UILabel *navigationLabel;
    UIImageView *pointImageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    
    navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, statusBarRect.size.height, self.view.frame.size.width, NAVIGATION_HEIGHT)];
    [navigationLabel setText:kNavigationBarTitle];
    [navigationLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [navigationLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:navigationLabel];
    [navigationLabel setAlpha:0.0f];
    [navigationLabel setHidden:YES];
    
    UIScrollView *formScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, statusBarRect.size.height + navigationLabel.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
    [formScrollView setBackgroundColor:[UIColor whiteColor]];
    [formScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100)];
    [formScrollView setDelegate:self];
    [self.view addSubview:formScrollView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, formScrollView.contentSize.width, NAVIGATION_HEIGHT)];
    [headerView setTag:100];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    [formScrollView addSubview:headerView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, formScrollView.contentSize.width, NAVIGATION_HEIGHT)];
    [topLabel setText:kNavigationBarTitle];
    [topLabel setFont:[UIFont boldSystemFontOfSize:30.0f]];
    [headerView addSubview:topLabel];
    
    UIView *formView = [[UIView alloc] initWithFrame:CGRectMake(0.0, topLabel.frame.origin.y + topLabel.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [formView setBackgroundColor:[UIColor whiteColor]];
    [formScrollView addSubview:formView];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    [contentLabel setText:@"contentLabel"];
    [contentLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [formView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(formView.mas_top).with.offset(20);
        make.left.equalTo(formView.mas_left);
        make.right.equalTo(formView.mas_right);
    }];
    
    UILabel *subContentLabel = [[UILabel alloc] init];
    [subContentLabel setText:@"subContentLabel"];
    [subContentLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [formView addSubview:subContentLabel];
    [subContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).with.offset(20);
        make.left.equalTo(contentLabel.mas_left);
        make.right.equalTo(contentLabel.mas_right);
    }];
    
    pointImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80.0f, navigationLabel.frame.origin.y + navigationLabel.frame.size.height, 80.0f, 60.0f)];
    [pointImageView setContentMode:UIViewContentModeScaleAspectFit];
    [pointImageView setImage:[UIImage imageNamed:@"edward"]];
    [self.view addSubview:pointImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (navigationLabel.frame.origin.y + 9 < scrollView.contentOffset.y) {
        if (navigationLabel.alpha == 0.0f) {
            [UIView animateWithDuration:0.2f animations:^{
                [self->navigationLabel setAlpha:1.0f];
                [self->navigationLabel setHidden:NO];
            }];
        }
    } else {
        if (navigationLabel.alpha == 1.0f) {
            [UIView animateWithDuration:0.2f animations:^{
                [self->navigationLabel setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self->navigationLabel setHidden:YES];
            }];
        }
    }
    
    // Scroll Up
    //if (scrollView.contentOffset.y > 0) {
    //}
    
    // Scroll Down
    if (scrollView.contentOffset.y < 0) {
        UIView *headerView = [self.view viewWithTag:100];
        [headerView setFrame:CGRectMake(0.0, scrollView.contentOffset.y, headerView.bounds.size.width, headerView.bounds.size.height)];
    }
    
    CGFloat offset =+ scrollView.contentOffset.y;
    CGFloat percentage = offset / NAVIGATION_HEIGHT;

    [self->pointImageView setAlpha:(1.f - percentage)];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (scrollView.contentOffset.y < 25) {
            [scrollView setContentOffset:CGPointZero animated:YES];
        } else if (scrollView.contentOffset.y < NAVIGATION_HEIGHT) {
            [scrollView setContentOffset:CGPointMake(0.0, navigationLabel.frame.size.height) animated:YES];
        }
    }
}

@end
