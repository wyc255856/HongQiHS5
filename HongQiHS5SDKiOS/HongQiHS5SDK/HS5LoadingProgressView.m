//
//  HS5LoadingProgressView.m
//  CarApp
//
//  Created by 张三 on 2018/4/20.
//  Copyright © 2018年 freedomTeam. All rights reserved.
//

#import "HS5LoadingProgressView.h"
#import "UIColor+HS5CARUtil.h"
#import "UIView+HS5frameAdjust.h"
#import "HS5CarBundleTool.h"
#import "UIView+HS5CARAdd.h"
#import "HS5CarAppConstant.h"



@interface HS5LoadingProgressView ()
/** 弹窗主内容view */
@property (nonatomic,strong) UIView   *contentView;
/** 提示 label */
@property (nonatomic,strong) UILabel  *tipLabel;

/** 进度条 **/
@property (nonatomic,strong) UIProgressView   *progressView;
/** 进度 label */
@property (nonatomic,strong) UILabel  *progressValueLabel;

/** 显示进度 **/
@property (nonatomic,copy)   NSString *progressValue;


@end

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation HS5LoadingProgressView{
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

/*
 下载弹窗的构造方法
 */
- (instancetype)initProgressView{
    if (self = [super init]) {
        //self.delegate = delegate;
        
        // 接收键盘显示隐藏的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
        
        // UI搭建
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI搭建
/** UI搭建 */
- (void)setUpUI{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
    
    //设置背景
    UIImageView *bgImgView =  [[UIImageView alloc] initWithFrame:self.frame];
    //[bgImgView setImage:[UIImage imageNamed:@"bg_style_1"]];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [bundle URLForResource:@"HS5CarResource" withExtension:@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithURL: bundleURL];
    
    NSString *resName = @"bg_style_1";
    [bgImgView setImage:resourceBundle?[UIImage imageNamed:resName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName]];
    [self addSubview:bgImgView];
    
    //------- 弹窗主内容 -------//
    self.contentView = [[UIView alloc]init];
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, SCREEN_HEIGHT/2*1.2);
    self.contentView.center = self.center;
    [self addSubview:self.contentView];

    UIImageView *imgViewBounceBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _contentView.size.width, _contentView.size.height)];
    
    NSString *resBounceBgName = @"img_classic_setup_projectile_frame2@2x";
    [imgViewBounceBg setImage:resourceBundle?[UIImage imageNamed:resBounceBgName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resBounceBgName]];
    [_contentView addSubview:imgViewBounceBg];
    
    //    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#09497b"];
    //    self.contentView.layer.cornerRadius = 6;
    //    self.contentView.layer.borderWidth = 1;
    //    self.contentView.layer.borderColor = [[UIColor colorWithHexString:@"#1bb2fa"] CGColor];
    
    
    
    //下载中
    UILabel *titleLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, 5*KScale, self.contentView.width, 20*KScale)];
    [self.contentView addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithHexString:@"#dee9f5"];
    titleLabel.text = @"下载中...";
    [_contentView addSubview:titleLabel];

    
    //------- 提示文字 -------//
    self.tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5*KScale+20*KScale+(_contentView.size.height-30*KScale-5*KScale-20*KScale-8)/2-8, self.contentView.width, 16)];
    self.tipLabel.font = [UIFont boldSystemFontOfSize:16];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = [UIColor colorWithHexString:@"#dee9f5"];
    self.tipLabel.text = @"正在下载资源压缩包";
    [self.contentView addSubview:self.tipLabel];
    ;

    //------- 下载图标 -------//
    //UIImage * loadIconImg =  [UIImage imageNamed:@"icon_load"];
//    NSString *resLoadName = @"icon_load";
//    UIImage *loadIconImg =  resourceBundle?[UIImage imageNamed:resLoadName inBundle:resourceBundle compatibleWithTraitCollection:nil]:[UIImage imageNamed:resName];
//
//    UIImageView *loadIconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (self.contentView.frame.size.height - loadIconImg.size.height)/2, loadIconImg.size.width, loadIconImg.size.height)];
//    loadIconView.image = loadIconImg;
//    [self.contentView addSubview:loadIconView];

    
    //------- 进度条 -------//
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10*KScale, _contentView.size.height-30*KScale-4, self.contentView.frame.size.width-(10+10+20)*KScale , 8)];
    self.progressView.layer.masksToBounds = YES;
    self.progressView.layer.cornerRadius = 2;
    //更改进度条高度
    self.progressView.transform = CGAffineTransformMakeScale(0.95f,1.0f);
    
    self.progressView.trackTintColor= [UIColor colorWithHexString:@"#3c4141"];

    self.progressView.progressTintColor= [UIColor colorWithHexString:@"#50ddef"];
    
    [self.contentView addSubview:self.progressView];
    
    
    
    //------- 进度值 -------//
    self.progressValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(10*KScale+self.progressView.size.width+5*KScale, _contentView.size.height-30*KScale-4-7, 50, 14)];
    
    [self.contentView addSubview:self.progressValueLabel];
    self.progressValueLabel.font = [UIFont boldSystemFontOfSize:14];
    //self.progressValueLabel.backgroundColor = [UIColor redColor];
    self.progressValueLabel.textAlignment = NSTextAlignmentCenter;
    self.progressValueLabel.textColor = [UIColor colorWithHexString:@"#dee9f5"];
    self.progressValueLabel.text = @"0%";
    
//    //这个容器 因为进度条的  进度覆盖了轨道 需求轨道是包含在外的 强行添加一个轨道放在进度条上面
//    UIView *containerProView = [[UIView alloc] initWithFrame:CGRectMake(loadIconView.frame.size.width+40+1, (self.contentView.frame.size.height-self.progressView.frame.size.height)/2, self.progressView.frame.size.width-1 , self.progressView.frame.size.height+1)];
//    
//    containerProView.layer.cornerRadius = 5;
//    containerProView.layer.borderWidth = 1;
//    containerProView.layer.borderColor = [[UIColor colorWithHexString:@"#1bb2fa"] CGColor];
//    
//    containerProView.layer.shadowColor = [[UIColor colorWithHexString:@"#1bb2fa"] CGColor];
//    containerProView.layer.shadowOpacity = 1;
//    containerProView.layer.shadowRadius = 5;
//    containerProView.layer.shadowOffset = CGSizeMake(0, 0);
//    [self.contentView addSubview:containerProView];
    
    
}

#pragma mark - 弹出此弹窗
/** 弹出此弹窗 */
- (void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}

#pragma mark - 移除此弹窗
/** 移除此弹窗 */
- (void)dismiss{
    [self removeFromSuperview];
}

/*
 设置progre值方法
 @param value 对应数字 0.0～1.0
 */
- (void) setProgressValue: (float) fValue{
    
    NSString *strTempValue=[NSString stringWithFormat:@"%0.2f", fValue];
    self.progressView.progress= [strTempValue floatValue];
    
    NSString *tempString = @"%";
    self.progressValueLabel.text = [NSString stringWithFormat:@"<%@>", [[NSString stringWithFormat:@"%d",(int)(fValue*100)] stringByAppendingString:tempString]];
    
    // [[NSString stringWithFormat:@"%d",(int)(fValue*100)] stringByAppendingString:tempString]self.progressValueLabel.text= [NSString initWithFormat:@"<%@>", ];
    
    
    
    
}

@end
