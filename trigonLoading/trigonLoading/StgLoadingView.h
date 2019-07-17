//
//  StgLoadingView.h
//  stockGold
//
//  Created by alreadyGona on 2019/7/17.
//  Copyright © 2019 alreadyGona. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StgLoadingView : UIView
+(StgLoadingView *)shareLoadingView;
-(void)loadShow;
-(void)loadHide;
@end

NS_ASSUME_NONNULL_END
