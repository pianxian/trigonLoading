//
//  StgLoadingView.m
//  stockGold
//
//  Created by alreadyGona on 2019/7/17.
//  Copyright © 2019 alreadyGona. All rights reserved.
//

#import "StgLoadingView.h"

@interface StgLoadingView ()
@property (nonatomic,strong) UIImageView *redImageView;
@property (nonatomic,strong) UIImageView *greenImageView;
@property (nonatomic,assign) CGAffineTransform redImageTransform;
@property (nonatomic,assign) CGAffineTransform greenImgeTransform;
@property (nonatomic,assign) BOOL isFinish;
@end
#define cordioWidth 20
static StgLoadingView *stgload = nil;
@implementation StgLoadingView

-(UIImageView *)redImageView{
    if (!_redImageView) {
        _redImageView = [[UIImageView alloc] init];
        _redImageView.image = [UIImage imageNamed:@"triangle_red"];
        _redImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _redImageView;
}
-(UIImageView *)greenImageView{
    if (!_greenImageView) {
        _greenImageView = [[UIImageView alloc] init];
        _greenImageView.image = [UIImage imageNamed:@"triangle_green"];
        _greenImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _greenImageView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)initView{
    [self addSubview:self.redImageView];
    self.backgroundColor = [UIColor colorWithRed:248/255.f green:248.f/255.f blue:248.f/255.f alpha:1];
    [self addSubview:self.greenImageView];
    [self.redImageView setFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/2 -cordioWidth/2, cordioWidth *0.866, cordioWidth)];
    [self.greenImageView setFrame:CGRectMake(self.frame.size.width/2- cordioWidth *0.866, self.frame.size.height/2 -cordioWidth/2, cordioWidth *0.866, cordioWidth)];
}
+(StgLoadingView *)shareLoadingView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stgload = [[self alloc] initWithFrame:CGRectMake(0, 0, 100.f, 100.f)];
        stgload.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)/2, CGRectGetHeight([UIScreen mainScreen].bounds)/2);
        stgload.layer.cornerRadius = 10;
        stgload.layer.shadowColor = [UIColor redColor].CGColor;
        stgload.layer.shadowOffset = CGSizeMake(5, 5);
        stgload.layer.shadowRadius = 10;
        stgload.layer.shadowOpacity = .5;
    });
    return stgload;
}

-(void)loadShow{
    _isFinish = NO;
    [self startLoadAnimation];
}
-(void)loadHide{
    _isFinish = YES;
    [self stopAnimation];
}
-(void)willRemoveSubview:(UIView *)subview{
    [super willRemoveSubview:subview];
    [self loadHide];
}

-(void)startLoadAnimation{
    if (_isFinish)return;
    [UIView animateWithDuration:.25 animations:^{
        self.redImageView.transform = CGAffineTransformMakeTranslation(0, cordioWidth/2);
        self.greenImageView.transform = CGAffineTransformMakeTranslation(0, -cordioWidth/2);
        self.redImageTransform = self.redImageView.transform;
        self.greenImgeTransform = self.greenImageView.transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.25 animations:^{
            self.greenImageView.transform = CGAffineTransformTranslate(self.redImageTransform, cordioWidth *0.866, -cordioWidth/2);
            self.redImageView.transform = CGAffineTransformTranslate(self.greenImgeTransform, -cordioWidth *0.866, cordioWidth/2);
            self.redImageTransform = self.redImageView.transform;
            self.greenImgeTransform = self.greenImageView.transform;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.25 animations:^{
                self.redImageView.transform = CGAffineTransformTranslate(self.redImageTransform, cordioWidth *0.866, -cordioWidth/2);
                self.greenImageView.transform = CGAffineTransformTranslate(self.greenImgeTransform, -cordioWidth *0.866, cordioWidth/2);
                self.redImageTransform = self.redImageView.transform;
                self.greenImgeTransform = self.greenImageView.transform;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:.25 animations:^{
                    self.redImageView.transform = CGAffineTransformTranslate(self.redImageTransform, 0, cordioWidth/2);
                    self.greenImageView.transform = CGAffineTransformTranslate(self.greenImgeTransform, 0, -cordioWidth/2);
                    self.redImageTransform = self.redImageView.transform;
                    self.greenImgeTransform = self.greenImageView.transform;
                } completion:^(BOOL finished) {
                    [self stopAnimation];
                    [self startLoadAnimation];
                }];
            }];
        }];
    }];
}

-(void)stopAnimation{
    self.redImageView.transform = CGAffineTransformIdentity;
    self.greenImageView.transform = CGAffineTransformIdentity;
    self.redImageTransform = CGAffineTransformIdentity;
    self.greenImgeTransform = CGAffineTransformIdentity;
}





@end
