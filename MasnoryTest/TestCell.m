//
//  TestCell.m
//  MasnoryTest
//
//  Created by lilei on 17/3/2.
//  Copyright © 2017年 李磊www. All rights reserved.
//

#import "TestCell.h"
#import "Masonry.h"

@interface TestCell ()

@property (nonatomic,strong) UIImageView *logoIv;
@property (nonatomic,strong) UILabel *contentLb;

@end


@implementation TestCell


-(UIImageView *)logoIv{
    if (!_logoIv) {
        _logoIv = [UIImageView new];
        [self.contentView addSubview:_logoIv];
        [_logoIv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(10);
            make.width.equalTo(90);
            make.height.equalTo(110);
        }];
    }
    return _logoIv;
}

- (UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [UILabel new];
        [self.contentView addSubview:_contentLb];
        [_contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.right.bottom.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.logoIv.mas_bottom).offset(10);
        }];
        _contentLb.numberOfLines = 0;
    }
    return _contentLb;
}

- (void)configCellWithImageStr:(NSString *)imageStr contentStr:(NSString *)content{
    self.logoIv.image = [UIImage imageNamed:imageStr];
    self.contentLb.text = content;
}

@end
