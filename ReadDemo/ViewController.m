//
//  ViewController.m
//  ReadDemo
//
//  Created by 夏远全 on 2018/3/29.
//  Copyright © 2018年 夏远全. All rights reserved.
//

#import "ViewController.h"
#import "ReadingEaasyTextView.h"
#import <Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) ReadingEaasyTextView   *textView;
@property (nonatomic, strong) NSMutableArray         *chineseArray;
@property (nonatomic, strong) NSMutableArray         *pinYinArray;
@end

@implementation ViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self setupDefaultValue];
    [self setupSubviews];
    [self setupSubviewsConstraints];
}


-(void)setupNavigation
{
    self.title = @"朗读";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始朗读" style:UIBarButtonItemStylePlain target:self action:@selector(startRead)];
}

-(void)setupDefaultValue
{
    self.chineseArray = [NSMutableArray array];
    self.pinYinArray = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        [self.chineseArray addObjectsFromArray:@[@"中",@"国",@"人",@"的",@"幸",@"福",@"。"]];
        [self.pinYinArray addObjectsFromArray:@[@"zhong",@"guo",@"ren",@"de",@"xing",@"fu",@""]];
    }

}

-(void)setupSubviews
{
    [self.view addSubview:self.textView];
}

#pragma mark - layout subviews
-(void)setupSubviewsConstraints {
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat hight = [UIScreen mainScreen].bounds.size.height;
    self.textView.contentSize = CGSizeMake(width, MAX(hight, self.textView.realHeight));
}

#pragma mark - load data

#pragma mark - delegate methods

#pragma mark - event response
-(void)startRead{
    [self.textView startRenderColor];
}

#pragma mark - public methods

#pragma mark - private methods

#pragma mark - getters and setters
-(ReadingEaasyTextView *)textView{
    if (!_textView) {
        _textView = [ReadingEaasyTextView createReadTextViewWithContentArray:self.chineseArray pinYinArray:self.pinYinArray];
    }
    return _textView;
}


@end
