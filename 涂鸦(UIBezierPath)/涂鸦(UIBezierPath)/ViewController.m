//
//  ViewController.m
//  涂鸦(UIBezierPath)
//
//  Created by apple on 2016/10/28.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 用贝塞尔路径的做法实现涂鸦目的。
 */
#import "ViewController.h"
#import "ZPDrawView.h"
#import "UIImage+ZPScreenShot.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ZPDrawView *drawView;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark ————— 点击“清屏”按钮 —————
- (IBAction)clear:(id)sender
{
    [self.drawView clear];
}

#pragma mark ————— 点击“回退”按钮 —————
- (IBAction)back:(id)sender
{
    [self.drawView back];
}

#pragma mark ————— 点击“保存”按钮 —————
- (IBAction)save:(id)sender
{
    UIImage *image = [UIImage imageWithCaptureView:self.drawView];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark ————— 保存到系统相册之后的回调方法 —————
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error)
    {
        [MBProgressHUD showError:@"保存失败"];
    }else
    {
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}

@end
