//
//  ViewController.m
//  CADisplayLinkDemo
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 com. All rights reserved.
//
#define IMAGE_COUNT 18

#import "ViewController.h"
@interface ViewController ()
{
    int _index;
    CALayer *_layer;
}
@property (nonatomic, strong) NSMutableArray *imageArr;


@end

@implementation ViewController
-(NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
        for (int i = 0; i < IMAGE_COUNT; i++) {
            NSString *string = [NSString stringWithFormat:@"DOVE %i",i];
            UIImage *subImage = [UIImage imageNamed:string];
            [_imageArr addObject:subImage];
        }
    }
    return _imageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self useUIImageViewAnimationImages];
    
    [self useCADisplayLink];
}

/**
 *
 *  CADisplayLink
 *
 */
-(void)useCADisplayLink{
    
    _layer=[[CALayer alloc]init];
    _layer.bounds=CGRectMake(0, 0, 87, 32);
    _layer.position=CGPointMake(160, 284);
    [self.view.layer addSublayer:_layer];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateImage)];
    displayLink.frameInterval = 60.0 / 19.0;
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

-(void)updateImage{
    UIImage *image = self.imageArr[_index];
    _layer.contents = (id)image.CGImage;//更新图片
    _index = (_index + 1) % IMAGE_COUNT;
}
/**
 *
 *  设置UIImageView的animationImages属性让形成动画
 *
 */
-(void)useUIImageViewAnimationImages{
    UIImage *image = [UIImage imageNamed:@"DOVE 1"];
    UIImageView *birdView = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - image.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2 - image.size.height / 2, image.size.width, image.size.height)];
    [self.view addSubview:birdView];
    
    //将所有的鸟图片添加到显示图片视图
    [birdView setAnimationImages:self.imageArr];
    //动画持续时间
    [birdView setAnimationDuration:1.0];
    //设置动画的重复次数  默认是1次,0代表无数次
    [birdView setAnimationRepeatCount:0];
    //开启动画
    [birdView startAnimating];
    
}
@end
