//
//  ViewController.m
//  MasnoryTest
//
//  Created by 李磊 on 2017/2/17.
//  Copyright © 2017年 李磊www. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "TestCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
                请打开不同的注释，查看不同的效果
    
    
    //  三种添加约束的方法比较
//    [self compareMethods];
 
    //  Masonry基本使用  更新/重置约束  动画效果
//    [self baseUsage];
    
    //  控件居中
//    [self horizontalCenter];
    
    // 等间距
//    [self equalSpacing];
    
    // scrollView
//    [self scrollViewTest];
    
    // cell自适应高度
    [self cellAutoHeight];
    
}


#pragma mark 系统方法/VFL/Masnory比较
- (void)compareMethods{
    
    // 创建一个子视图，添加到父视图上面
    UIView *view= [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    //给视图添加约束之前必须先将该视图添加到俯视图上否则会crash
    [self.view addSubview:view];
    
    /*
     // 方法一：系统方法
     //禁用autoresizing
     view.translatesAutoresizingMaskIntoConstraints = NO;
     //底部约束对象
     NSLayoutConstraint *topCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:100];
     // 左边约束(基于父控件)
     NSLayoutConstraint *leftCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20];
     // 右边约束(基于父控件)
     NSLayoutConstraint *rightCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20];
     [self.view addConstraints:@[topCos,leftCos,rightCos]];
     // 高度约束(自身)
     NSLayoutConstraint *heightCos = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1.0 constant:50];
     [view addConstraint:redHeightCos];
     */
    
    /*
     //方法二：VFL语言实现约束
     //禁用autoresizing
     view.translatesAutoresizingMaskIntoConstraints = NO;
     // 水平方向
     NSArray *hCos = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[view]-20-|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(view)];
     [self.view addConstraints:hCos];
     //竖直方向
     NSArray *vCos = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view(==50)]" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(view)];
     [self.view addConstraints:vCos];
     */
    
    // 方法三： masnory
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(@100);// 方向上的约束 默认相对于父视图
        make.height.equalTo(@50);
    }];
    

}


#pragma mark 更新约束
- (void)updateConstraints:(UITapGestureRecognizer *)tap{
    UIView *blueView = tap.view;
    [blueView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(blueView.superview).multipliedBy(0.8);
    }];
    // 告诉约束需要更新，但不会立即更新，
    [blueView.superview setNeedsUpdateConstraints];
    // 检测当前视图及其子视图是否需要更新约束
    [blueView.superview updateConstraintsIfNeeded];
    [UIView animateWithDuration:3 animations:^{
        // 立即更新约束
        [blueView.superview layoutIfNeeded];
    }];
}

#pragma mark 重置约束
- (void)remarkConstraints:(UITapGestureRecognizer *)tap{
    UIView *blueView = tap.view;
    [blueView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(blueView.superview).offset(-10);
        make.width.equalTo(blueView.superview).multipliedBy(0.5);
    }];
    // 告诉约束需要更新，但不会立即更新，
    [blueView.superview setNeedsUpdateConstraints];
    // 检测当前视图及其子视图是否需要更新约束
    [blueView.superview updateConstraintsIfNeeded];
    [UIView animateWithDuration:3 animations:^{
        // 立即更新约束
        [blueView.superview layoutIfNeeded];
    }];
}


#pragma mark Masonry基本使用  更新/重置约束  动画效果
- (void)baseUsage{
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    UIEdgeInsets padding1 =  UIEdgeInsetsMake(20, 20, 20, 20);
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        //         方法一
        //        make.right.equalTo( self.view.mas_right).offset(-20);
        //        make.left.equalTo(self.view).offset(20);//默认相对方向为你想要设置的方向
        //        make.top.equalTo(redView.superview).offset(20);
        //        make.bottom.equalTo(-20);//默认相对视图为父视图
        //         方法二
        //        make.top.left.equalTo(20);// 可同时设置多个约束
        //        make.right.bottom.equalTo(-20);
        //        方法三
        //        make.top.left.right.bottom.equalTo(self.view).insets(padding1);
        //         方法四
        make.edges.equalTo(padding1);//设置内边距
    }];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [redView addSubview:blueView];
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(redView);
        make.size.equalTo(redView).dividedBy(2.0);//父视图宽度的一半
        //等价于make.size.equalTo(redView).multipliedBy(0.5);
    }];
    
    
    UIView *orangeView = [UIView new];
    orangeView.backgroundColor = [UIColor orangeColor];
    [blueView addSubview:orangeView];
    UIView *purpleView = [UIView new];
    purpleView.backgroundColor = [UIColor purpleColor];
    [blueView addSubview:purpleView];
    UIView *greenView = [UIView new];
    greenView.backgroundColor = [UIColor greenColor];
    [blueView addSubview:greenView];
    UIEdgeInsets padding2 = UIEdgeInsetsMake(15, 10, 15, 10);
    [orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(blueView).insets(padding2);
        make.right.equalTo(purpleView.mas_left).offset(padding2);
        make.width.equalTo(purpleView.mas_width);
        make.height.equalTo(@[purpleView,greenView]);
        make.bottom.equalTo(greenView.mas_top).insets(padding2);
    }];
    [purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(blueView).insets(padding2);
    }];
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(blueView).insets(padding2);
    }];
    
    //更新约束
    //    [blueView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateConstraints:)]];
    
    
    [blueView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remarkConstraints:)]];
    

}

#pragma mark 控件水平居中
- (void)horizontalCenter{
    UIView *supView = [UIView new];
    supView.backgroundColor = [UIColor redColor];
    [self.view addSubview:supView];
    
    UIView *leftView = [UIView new];
    leftView.backgroundColor = [UIColor orangeColor];
    [supView addSubview:leftView];
    
    UIView *rightView = [UIView new];
    rightView.backgroundColor = [UIColor greenColor];
    [supView addSubview:rightView];
    
    [supView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);//设置父视图居中
    }];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(supView);//设置上左下对齐父视图
        make.size.equalTo(CGSizeMake(80, 40));//设置尺寸
        make.right.equalTo(rightView.mas_left).offset(-10);//设置间距
    }];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(supView);//设置右上下对齐父视图 (配合leftView就可以确定superView的宽高了)
        make.size.equalTo(leftView);
    }];
}


#pragma mark 等间距
- (void)equalSpacing{
    
    NSMutableArray *array = @[].mutableCopy;
    for (NSInteger i = 0; i<4; i++) {
        UIView *view = [UIView new];
        [self.view addSubview:view];
        view.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
        [array addObject:view];
    }
    /*
     方法一：指定间距大小，拉伸view的宽度
     参数1、设置方向 MASAxisTypeHorizontal水平方向,MASAxisTypeVertical竖直方向
     参数2、间距大小
     参数3、最左边间距大小
     参数4、最右边间距大小
    */
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:10 tailSpacing:20];
    [array mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.height.equalTo(100);
    }];
    
    /*
     方法二：指定view宽度，等分间距
     参数2、view的宽度
     其余参数同上
     */
//    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:20 tailSpacing:20];
//    [array mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.view);
//        make.height.equalTo(100);
//    }];
}


#pragma mark scrollView
- (void)scrollViewTest{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        //设置边距相对于scrollView的约束
        //（自己的见解：contentView的edges相对scrollView的edges 实际上被拉伸的宽高是相对于scrollView的contentSize的）
        make.edges.equalTo(scrollView);
        //因为上面的宽高是相对于contentSize的  所以为0  这里需要设置contentView的宽度约束后  scrollView的contentSize.width就会拉伸
        make.width.equalTo(scrollView);
    }];
    
    NSMutableArray *lastArray;
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i<99; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
        [contentView addSubview:view];
        [array addObject:view];

        if ((i+1)%3 == 0) { //一行分三个  最后一行如果不足三个则忽略
            [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:50 leadSpacing:20 tailSpacing:20];
            [array mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(50);
                make.top.equalTo(lastArray.count?((UIView *)lastArray[0]).mas_bottom:contentView).offset(10);
            }];
            lastArray = array.mutableCopy;
            array = [NSMutableArray array];
        }
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 这里设置contentView的底部约束等于最后一排视图底部约束后  contentView的高度就确定了  scrollView的contentSize.height就会拉伸
        make.bottom.equalTo(((UIView *)lastArray[0]).mas_bottom);
    }];

}
#pragma mark 自适应cell高度
NSMutableArray *_dataArray;
- (void)cellAutoHeight{
    
    NSArray *array = @[@"两栖蛙蛙教育平台",
                       @"两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台",
                       @"两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台",
                       @"两栖蛙蛙教育平台两栖蛙蛙教育平台",
                       @"两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台",
                       @"两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台",
                       @"两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台两栖蛙蛙教育平台"];
    _dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i<200; i++) {
        [_dataArray addObject:array[arc4random()%array.count]];
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.estimatedRowHeight = 100;//一个估算值
//    tableView.rowHeight = UITableViewAutomaticDimension;//可以不设置，ios8之后默认值
    [tableView registerClass:[TestCell class] forCellReuseIdentifier:@"TestCell"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestCell"];
    [cell configCellWithImageStr:@"logo" contentStr:_dataArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [tableView fd_heightForCellWithIdentifier:@"TestCell" cacheByIndexPath:indexPath configuration:^(TestCell *cell) {
        // 这里调用cell子视图赋值的方法
        [cell configCellWithImageStr:@"logo" contentStr:_dataArray[indexPath.row]];
    }];
}


@end
