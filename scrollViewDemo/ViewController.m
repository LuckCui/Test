//
//  ViewController.m
//  scrollViewDemo
//
//  Created by CuiJianZhou on 16/4/28.
//  Copyright © 2016年 CJZ. All rights reserved.
//

#import "ViewController.h"
#import "CJZPageView.h"
#import "oneViewController.h"
#import "twoViewController.h"
#import "threeViewController.h"
#import "fourViewController.h"

#define scrW [UIScreen mainScreen].bounds.size.width
#define scrH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<CJZPageViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong) oneViewController *oneVc;
@property (nonatomic, strong) twoViewController *twoVc;
@property (nonatomic, strong) threeViewController *threeVc;
@property (nonatomic, strong) fourViewController *fourVc;
@property (nonatomic, strong) NSMutableArray *buts;
@property (nonatomic, strong) CJZPageView *pageView;
@property (nonatomic, strong) UIView *diXian;

//
@property (nonatomic, assign) UITableView *tab;
@property (nonatomic, assign) NSInteger NUM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpCJZPageView];
    [self setUpScrollView];
    NSLog(@"ddddddd");
 
    
    
    NSLog(@"333");
}

- (void)setUpScrollView {
    
    //创建UIScrollView
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, scrW, scrH)];
    self.scroll = scroll;
    scroll.delegate = self;
    //拖动的时候，马上到下一个View，不会中间停留
    scroll.pagingEnabled = YES;
    //滚动区域
    scroll.contentSize = CGSizeMake(self.dataArray.count * scrW, scrH);
    //是否显示滚动条
    scroll.showsVerticalScrollIndicator = FALSE;
    scroll.showsHorizontalScrollIndicator = FALSE;

    [self.view addSubview:scroll];
    
    /**
     * 把控制器的View添加到ScrollView里面
     */
    self.oneVc = [[oneViewController alloc]init];
    self.oneVc.view.frame = CGRectMake(0, 0, scrW, scrH);
    
    self.twoVc = [[twoViewController alloc]init];
    self.twoVc.view.frame = CGRectMake(1 * scrW, 0, scrW, scrH);
    
    self.threeVc = [[threeViewController alloc]init];
    self.threeVc.view.frame = CGRectMake(2 * scrW, 0, scrW, scrH);
    
    self.fourVc = [[fourViewController alloc]init];
    self.fourVc.view.frame = CGRectMake(3 * scrW , 0, scrW, scrH);

    
    [self addChildViewController:self.oneVc];
    [self addChildViewController:self.twoVc];
    [self addChildViewController:self.threeVc];
    [self addChildViewController:self.fourVc];
    
    [self.scroll addSubview:self.oneVc.view];
    [self.scroll addSubview:self.twoVc.view];
    [self.scroll addSubview:self.threeVc.view];
    [self.scroll addSubview:self.fourVc.view];
    
}

#pragma mark =---- 创建CJZPageView ----=
- (void)setUpCJZPageView{
    
    CJZPageView *page  = [[CJZPageView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40) dataArray:self.dataArray];
    page.delegate = self;
    self.pageView = page;
    self.buts = page.buts;
    self.diXian = page.diXian;
    [self.view addSubview:page];

}

#pragma mark =---- CJZPageView的代理方法 ----=
- (void)didPageViewWith:(NSInteger)index {
    
    //根据当前的索引跳转控制器
    CGPoint offset = self.scroll.contentOffset;
    offset.x = index * self.scroll.frame.size.width;
    [self.scroll setContentOffset:offset animated:YES];
    
    //改变CJZ按钮的选择状态
    [self.buts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *but = obj;
        
        if (idx == index) {
            but.selected = YES;
        } else {
            but.selected = NO;
        }
        
    }];
    
    [self scroll:index];

}


#pragma mark =---- CJZPageView的标题根据这个数据的对象决定 ----=
- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray arrayWithObjects:@"view1",@"view2",@"view3",@"view4" ,nil];
    }
    
    return _dataArray;
    
}

- (NSMutableArray *)buts {
    
    if (_buts == nil) {
        
        _buts = [NSMutableArray array];
    }
    
    return _buts;
    
}

#pragma mark =--- scrollView的代理方法 ---=
//停止拖动scrollView的时候会调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page  = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    [self.buts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *but = obj;
        
        if (idx == page) {
            but.selected = YES;
        } else {
            but.selected = NO;
        }
        
    }];
    
    //每个控件的宽度
    CGFloat viewW = self.view.frame.size.width / 3;
    CGFloat viewH = 40;

    [self scroll:page];

    [UIView animateWithDuration:0.2 animations:^{
        self.diXian.frame = CGRectMake(page * viewW, viewH - 2,viewW, 2);
        
    }];
}

#pragma mark =---- 根据当前拖动的索引，CJZPageView也跟着滚动 ----=
- (void)scroll:(NSInteger)page{
    
    //每个控件的宽度
    CGFloat viewW = self.view.frame.size.width / 3;
    CGPoint offset = self.pageView.scrollView.contentOffset;
    if (page == 2) {
        offset.x = (page - 1)  * viewW;
        [self.pageView.scrollView setContentOffset:offset animated:YES];
    } else if (page == 1) {
        offset.x = self.pageView.scrollView.frame.origin.x;
        [self.pageView.scrollView setContentOffset:offset animated:YES];
    } else if (page == 3) {
        return;
    }
    
}

@end
