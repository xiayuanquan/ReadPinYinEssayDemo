//
//  ReadTextView.m
//  ReadDemo
//
//  Created by 夏远全 on 2018/3/29.
//  Copyright © 2018年 夏远全. All rights reserved.
//

#import "ReadingEaasyTextView.h"
#import <Masonry.h>

#define kScreenWidth   [UIScreen mainScreen].bounds.size.width
#define kFont          [UIFont systemFontOfSize:20]

@interface ReadingEaasyTextView ()
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSArray *pinYinArray;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int     index;
@end

@implementation ReadingEaasyTextView


#pragma mark - life cycle
+(instancetype)createReadTextViewWithContentArray:(NSArray *)contentArray pinYinArray:(NSArray *)pinYinArray{
    
    ReadingEaasyTextView *readView = [[ReadingEaasyTextView alloc] init];
    readView.contentArray = contentArray;
    readView.pinYinArray = pinYinArray;
    [readView setup];
    
    return readView;
}

-(void)setup
{
    [self setDefalut];
    [self addSubViews];
    [self setupSubviewsConstraints];
}

-(void)setDefalut{
    
}

#pragma mark - add subViews
-(void)addSubViews{
    
}


#pragma mark - layout subviews
-(void)setupSubviewsConstraints {
    
    //(子视图采用横向瀑布流布局）
    CGFloat margin = 2.5;
    CGFloat viewHeight = (kFont.pointSize+5) * 2;
    CGFloat sumWidth = 0;
    CGFloat limitWidth = kScreenWidth-2*margin;
    CGFloat viewX = margin;
    CGFloat viewY = margin;
    CGFloat row  = 0;
    
    for (int i=0 ; i<self.contentArray.count; i++) {
        
        //实际宽度
        CGFloat chineseWidth = [self layoutListNameLength:self.contentArray[i]];
        CGFloat pinYinWidth = [self layoutListNameLength:self.pinYinArray[i]];
        CGFloat maxWidth = MAX(chineseWidth, pinYinWidth);
        
        //添加容器
        UIView *containerView = [[UIView alloc] init];
        [self addSubview:containerView];
        
        //添加拼音
        UILabel *pinYinLabel = [[UILabel alloc] init];
        pinYinLabel.textColor = [UIColor grayColor];
        pinYinLabel.font = kFont;
        pinYinLabel.text = self.pinYinArray[i];
        pinYinLabel.textAlignment = NSTextAlignmentCenter;
        [containerView addSubview:pinYinLabel];
        
        //添加汉字
        UILabel *chineseLabel = [[UILabel alloc] init];
        chineseLabel.textColor = [UIColor blackColor];
        chineseLabel.font = kFont;
        chineseLabel.text = self.contentArray[i];
        chineseLabel.textAlignment = NSTextAlignmentCenter;
        [containerView addSubview:chineseLabel];
        
        //设置约束
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(viewHeight));
            make.width.equalTo(@(maxWidth));
            make.left.equalTo(@(viewX));
            make.top.equalTo(@(viewY));
        }];
        [pinYinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(containerView);
            make.height.equalTo(containerView.mas_height).multipliedBy(0.5);
        }];
        [chineseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(containerView);
            make.height.equalTo(containerView.mas_height).multipliedBy(0.5);
        }];

        //计算坐标
        sumWidth += (maxWidth + margin);
        if (i < self.contentArray.count-1) {
            chineseWidth = [self layoutListNameLength:self.contentArray[i+1]];
            pinYinWidth = [self layoutListNameLength:self.pinYinArray[i+1]];
            maxWidth = MAX(chineseWidth, pinYinWidth);
        }
        if (limitWidth - sumWidth >= maxWidth) {  ///不换行
            viewX = sumWidth + margin;
        }
        else{ ///换行
            row++;
            sumWidth = 0;
            viewX = margin;
            if (i==self.contentArray.count-1) {
                row--;
            }
        }
        viewY = (viewHeight + 6*margin)*row + margin;
    }
    
    self.realHeight = viewY + viewHeight + 1.5*margin;
}


#pragma mark - event response
-(void)runTimer{
    
    UIView *containerView = self.subviews[MIN(self.index, self.contentArray.count-1)];
    UILabel *pinYinLabel = containerView.subviews[0];
    UILabel *chineseLabel = containerView.subviews[1];
    pinYinLabel.textColor = chineseLabel.textColor = [UIColor blueColor];
    self.index ++;
    
    if (self.index == self.contentArray.count) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - public methods
-(void)startRenderColor{
    [self.timer fire];
}

#pragma mark - private methods
-(CGFloat)layoutListNameLength:(NSString *)content{
    CGFloat width = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, (kFont.pointSize+5)*2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont} context:nil].size.width+8;
    return width;
}

#pragma mark - getters and setters
-(NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
