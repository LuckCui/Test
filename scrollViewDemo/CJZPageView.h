//
//  CJZPageView.h
//  demo
//
//  Created by CuiJianZhou on 16/4/28.
//  Copyright © 2016年 CJZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CJZPageViewDelegate <NSObject>

@optional
- (void)didPageViewWith:(NSInteger)index;

@end


@interface CJZPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSMutableArray *)dataArray;

@property (nonatomic, weak) id <CJZPageViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *buts;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *diXian;

@end
