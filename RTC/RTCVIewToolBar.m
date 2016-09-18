//
//  RTCVIewToolBar.m
//  Linkdood
//
//  Created by VRV2 on 16/9/14.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import "RTCVIewToolBar.h"
#import "RTCButton.h"
#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height
#define kRTCRate        ([UIScreen mainScreen].bounds.size.width / 320.0)
// 底部按钮容器的高度
#define kContainerH     (180 * kRTCRate)
// 每个按钮的宽度
#define kBtnW           (60 * kRTCRate)
@interface RTCVIewToolBar ()

@property(nonatomic,assign) CGRect oldFrame;

@end

@implementation RTCVIewToolBar
+(instancetype)RTCVIewToolBarInstance{
    NSArray *buddleArray = [[NSBundle mainBundle] loadNibNamed:@"RTCViewToolBar" owner:nil options:nil];
    if (buddleArray.count == 0 || !buddleArray) {
        return nil;
    }
    return [buddleArray firstObject];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self  = [super initWithCoder:aDecoder];
    if (self) {
        [self setUpUI];
        self.frame = CGRectMake(0, kScreenHeight - kContainerH, kScreenWidth, kContainerH);
        self.oldFrame = self.frame;
        self.backgroundColor = [UIColor colorWithRed:0.971 green:0.968 blue:0.974 alpha:1];

    }
    return self;
}
-(void)setUpUI{
//    if (self.isCalled) {
//        [self initUIForVideoCalleed];
//    }else{
        [self initUIFromCallVideo];
  
}
/**
 *  初始化呼叫方的UI
 */
-(void)initUIFromCallVideo{
    CGFloat btnW = kBtnW;
    CGFloat paddingX = (self.frame.size.width - btnW*3) / 4;
    CGFloat paddingY = (kContainerH - btnW *2) / 3;
    self.muteBtn.frame = CGRectMake(paddingX, paddingY+10, btnW, btnW);
    [self addSubview:_muteBtn];
    
    self.cameraBtn.frame = CGRectMake(paddingX * 2 + btnW, paddingY+5, btnW, btnW);
    [self addSubview:_cameraBtn];
    
    self.loudspeakerBtn.frame = CGRectMake(paddingX * 3 + btnW * 2, paddingY+10, btnW, btnW);
    self.loudspeakerBtn.selected = self.loudSpeaker;
    [self addSubview:_loudspeakerBtn];
    
    self.inviteBtn.frame = CGRectMake(paddingX, paddingY * 2 + btnW-5, btnW, btnW);
    [self addSubview:_inviteBtn];
    
    self.hangupBtn.frame = CGRectMake(paddingX * 2 + btnW, paddingY * 2 + btnW - 10, btnW, btnW);
    [self addSubview:_hangupBtn];
    
    self.packupBtn.frame = CGRectMake(paddingX * 3 + btnW * 2, paddingY * 2 + btnW-5, btnW, btnW);
    [self addSubview:_packupBtn];

}
///**
// *  视频通话，被呼叫方UI初始化
// */
//- (void)initUIForVideoCalleed
//{
//    CGFloat btnW = kBtnW;
//    CGFloat btnH = kBtnW + 20;
//    CGFloat paddingX = (kScreenWidth - btnW * 2) / 3;
//    self.hangupBtn.frame = CGRectMake(paddingX, kContainerH - btnH - 5, btnW, btnH);
//    [self addSubview:_hangupBtn];
//    
//    self.answerBtn.frame = CGRectMake(paddingX * 2 + btnW, kContainerH - btnH - 5, btnW, btnH);
//    [self addSubview:_answerBtn];
//    
//    // 这里还需要添加两个按钮
//    self.msgReplyBtn.frame = CGRectMake(paddingX, 5, btnW, btnW);
//    [self addSubview:_msgReplyBtn];
//    
//    self.voiceAnswerBtn.frame = CGRectMake(paddingX * 2 + btnW, 5, btnW, btnW);
//    [self addSubview:_voiceAnswerBtn];
//    
//}

- (RTCButton *)muteBtn
{
    if (!_muteBtn) {
        _muteBtn = [[RTCButton alloc] initWithTitle:@"静音" imageName:@"icon_avp_mute" isVideo:_isVideo];
        _muteBtn.tag = 2016091401;
        [_muteBtn addTarget:self action:@selector(rtcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _muteBtn;
}

- (RTCButton *)cameraBtn
{
    if (!_cameraBtn) {
        _cameraBtn = [[RTCButton alloc] initWithTitle:@"摄像头" imageName:@"icon_avp_video" isVideo:_isVideo];
        _cameraBtn.tag = 2016091402;
        [_cameraBtn addTarget:self action:@selector(rtcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cameraBtn;
}

- (RTCButton *)loudspeakerBtn
{
    if (!_loudspeakerBtn) {
        _loudspeakerBtn = [[RTCButton alloc] initWithTitle:@"扬声器" imageName:@"icon_avp_loudspeaker" isVideo:_isVideo];
        _loudspeakerBtn.tag = 2016091403;
        [_loudspeakerBtn addTarget:self action:@selector(rtcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _loudspeakerBtn;
}

- (RTCButton *)inviteBtn
{
    if (!_inviteBtn) {
        _inviteBtn = [[RTCButton alloc] initWithTitle:@"邀请成员" imageName:@"icon_avp_invite" isVideo:_isVideo];
        _inviteBtn.tag = 2016091404;
        [_inviteBtn addTarget:self action:@selector(rtcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _inviteBtn;
}

- (RTCButton *)hangupBtn
{
    if (!_hangupBtn) {
        _hangupBtn.tag = 2016091405;
        if (!self.isCalled) {
            _hangupBtn = [[RTCButton alloc] initWithTitle:@"取消"  noHandleImageName:@"icon_call_reject_normal" selectImage:@""];
        } else {
            _hangupBtn = [[RTCButton alloc] initWithTitle:nil noHandleImageName:@"icon_call_reject_normal" selectImage:@""];
        }
        
        [_hangupBtn addTarget:self action:@selector(rtcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hangupBtn;
}

- (RTCButton *)packupBtn
{
    if (!_packupBtn) {
        _packupBtn.tag = 2016091406;
        _packupBtn = [[RTCButton alloc] initWithTitle:@"收起" imageName:@"icon_avp_reduce" isVideo:_isVideo];
        [_packupBtn addTarget:self action:@selector(rtcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _packupBtn;
}

- (void)clearBottomViews
{
    _muteBtn = nil;
    _cameraBtn = nil;
    _loudspeakerBtn = nil;
    _inviteBtn = nil;
    _hangupBtn = nil;
    _packupBtn = nil;
    _msgReplyBtn = nil;
    _voiceAnswerBtn = nil;
    _answerBtn = nil;
}
-(void)rtcBtnClicked:(UIButton*)sender{
    if (_delegate && [self.delegate respondsToSelector:@selector(RTCButtonClicked:)]) {
        [self.delegate RTCButtonClicked:sender];
    }

    switch (sender.tag) {
        case 2016091401:
            //静音按钮
            break;
        case 2016091402:
            //摄像头按钮
            break;
        case 2016091403:
            //扬声器按钮
            [self loudspeakerClick];
            break;
        case 2016091404:
            //邀请按钮
            break;
        case 2016091405:
            //挂断或者接受按钮
            break;
        case 2016091406:
            //收起按钮
            break;
            
        default:
            break;
    }
}


- (void)loudspeakerClick
{
    NSLog(@"外放声音%s",__func__);
    if (!self.loudspeakerBtn.selected) {
        self.loudspeakerBtn.selected = YES;
        self.loudSpeaker = YES;
        [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:nil];
    } else {
        self.loudspeakerBtn.selected = NO;
        self.loudSpeaker = NO;
        [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:nil];
    }
}

-(void)showToolBarInView:(UIView*)view{
    [view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.hidden = NO;
        self.frame = self.oldFrame;
    } completion:^(BOOL finished) {
        
    }];

   }
-(void)hiddenToolBar{
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 0.01);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
@end
