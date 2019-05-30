//
//  CJZPageView.m
//  demo
//
//  Created by CuiJianZhou on 16/4/28.
//  Copyright © 2016年 CJZ. All rights reserved.
//

#import "CJZPageView.h"

@interface CJZPageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectButton;

@end


@implementation CJZPageView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSMutableArray *)dataArray {
    
    self.buts = [NSMutableArray array];
    
    if (self = [super initWithFrame:frame]) {
        
        CGFloat viewW =  frame.size.width / 3;
        CGFloat viewH = 40;
       
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
        self.scrollView = scrollView;
        scrollView.delegate = self;
        //scrollView.pagingEnabled = YES;
        scrollView.backgroundColor = [UIColor orangeColor];
        scrollView.contentSize = CGSizeMake(dataArray.count * viewW, viewH);
        scrollView.showsHorizontalScrollIndicator = NO;
        
        //底线
        UIView *diXian = [[UIView alloc]initWithFrame:CGRectMake(0, viewH - 2, viewW, 2)];
        self.diXian = diXian;
        diXian.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:diXian];
        
        for (int i = 0; i < dataArray.count; i++) {
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i * viewW, 0, viewW, viewH)];
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.frame = view.bounds;
            but.tag = i;
            [but setTitle:dataArray[i] forState:UIControlStateNormal];
            [but setTitle:dataArray[i] forState:UIControlStateSelected];
            but.titleLabel.font = [UIFont systemFontOfSize:14];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            if (i == 0) {
                
                but.selected = YES;
                self.selectButton = but;
            }
            
            [self.buts addObject:but];
            [view addSubview:but];
            [scrollView addSubview:view];
        }
        
        [self addSubview:scrollView];
    }
    
    
    return self;
    
}

#pragma mark =--- 按钮点击方法 ---=

- (void)butClick:(UIButton *)button {
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    //改变底线View的位置
    [UIView animateWithDuration:0.5 animations:^{
        self.diXian.frame = CGRectMake(button.tag * button.frame.size.width, self.scrollView.frame.size.height - 2, button.frame.size.width, 2);
        
    }];
    
    //代理
    if ([self.delegate respondsToSelector:@selector(didPageViewWith:)]) {
        
        [self.delegate didPageViewWith:button.tag];
    }

    
}

@end
