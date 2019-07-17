//
//  ViewController.m
//  trigonLoading
//
//  Created by alreadyGona on 2019/7/17.
//

#import "ViewController.h"
#import "StgLoadingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:[StgLoadingView shareLoadingView]];
    [[StgLoadingView shareLoadingView] loadShow];
}


@end
