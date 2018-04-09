//
//  ReadTextView.h
//  ReadDemo
//
//  Created by 夏远全 on 2018/3/29.
//  Copyright © 2018年 夏远全. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadingEaasyTextView : UIScrollView

@property (nonatomic, assign) CGFloat realHeight;

//开始着色
-(void)startRenderColor;

//创建字板
+(instancetype)createReadTextViewWithContentArray:(NSArray *)contentArray pinYinArray:(NSArray *)pinYinArray;

@end
