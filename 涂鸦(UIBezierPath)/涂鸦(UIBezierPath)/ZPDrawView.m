//
//  ZPDrawView.m
//  涂鸦(UIBezierPath)
//
//  Created by apple on 2016/10/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPDrawView.h"

@interface ZPDrawView()

@property (nonatomic, strong) NSMutableArray *totalPathMutableArray;  //这个可变数组里存放着不同的路径，而每个路径又是一个数组，里面存放着形成这一路径的所有点。

@end

@implementation ZPDrawView

#pragma mark ————— 懒加载 —————
- (NSMutableArray *)totalPathMutableArray
{
    if (_totalPathMutableArray == nil)
    {
        _totalPathMutableArray = [NSMutableArray array];
    }
    
    return _totalPathMutableArray;
}

#pragma mark ————— 清屏 —————
- (void)clear
{
    [self.totalPathMutableArray removeAllObjects];
    
    [self setNeedsDisplay];
}

#pragma mark ————— 回退 —————
-(void)back
{
    [self.totalPathMutableArray removeLastObject];
    
    [self setNeedsDisplay];
}

#pragma mark ————— 确定路径的起点 —————
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint startPoint = [touch locationInView:touch.view];
    
    /**
     用户刚开始点击本View的时候就会创建一个贝塞尔路径来存放这个路径中的所有点；
     这个路径对应着这个新创建的贝塞尔路径。
     */
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    //把路径的起点加到这个路径所对应的贝塞尔路径中
    [path moveToPoint:startPoint];
    
    //把这个路径所对应的贝塞尔路径添加到可变数组中
    [self.totalPathMutableArray addObject:path];
    
    //重绘
    [self setNeedsDisplay];
}

#pragma mark ————— 确定路径的拖动点 —————
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:touch.view];
    
    //从可变数组中取出本路径所对应的贝塞尔路径
    UIBezierPath *path = [self.totalPathMutableArray lastObject];
    
    //把路径的拖动点添加到这个路径所对应的贝塞尔路径中
    [path addLineToPoint:point];
    
    //重绘
    [self setNeedsDisplay];
}

#pragma mark ————— 确定路径的终点 —————
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint endPoint = [touch locationInView:touch.view];
    
    //从可变数组中取出本路径所对应的贝塞尔路径
    UIBezierPath *path = [self.totalPathMutableArray lastObject];
    
    //把路径的终点添加到本路径所对应的贝塞尔路径中
    [path addLineToPoint:endPoint];
    
    //重绘
    [self setNeedsDisplay];
}

#pragma mark ————— 绘制 —————
-(void)drawRect:(CGRect)rect
{
    [[UIColor redColor] setStroke];
    
    for (UIBezierPath *path in self.totalPathMutableArray)
    {
        [path stroke];
    }
}

@end
