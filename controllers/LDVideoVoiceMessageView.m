//
//  LDVideoVoiceMessageView.m
//  Linkdood
//
//  Created by VRV2 on 16/9/19.
//  Copyright © 2016年 xiong qing. All rights reserved.
//

#import "LDVideoVoiceMessageView.h"
#import "NSString+LDStringAttribute.h"
@interface LDVideoVoiceMessageView ()
@property (strong, nonatomic) UIImageView *cachedImageView;
@end

@implementation LDVideoVoiceMessageView
- (instancetype)initWithMessage:(LDMessageModel *)message{
    self = [super init];
    if (self)
    {
        [self setAppliesMediaViewMaskAsOutgoing:message.sendUserID == MYSELF.ID];
        self.message = (LDTextMessageModel*)message;
    }
    return self;
}

-(CGSize)mediaViewDisplaySize{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    
   CGSize contantSize = [self.message.message boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return CGSizeMake(contantSize.width+50, contantSize.height+30);
}
-(UIView *)mediaView{
    
    _cachedImageView = [[UIImageView alloc]init];
    CGSize size = [self mediaViewDisplaySize];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self.message.limitRange.count >0) {
        imageView.backgroundColor = [UIColor colorWithRed:245/255.0 green:191/255.0 blue:79/255.0 alpha:1];
    }
    else{
        imageView.backgroundColor = self.appliesMediaViewMaskAsOutgoing?[UIColor jsq_messageBubbleLightGrayColor]:[UIColor colorWithRed:200/255.0 green:220/255.0 blue:1 alpha:1];
    }
    imageView.clipsToBounds = YES;
    

    self.messageLabel = [[UILabel alloc]init];
    self.messageLabel.bounds = CGRectMake(0, 0, size.width, size.height);
    self.messageLabel.center = CGPointMake(imageView.bounds.size.width*0.7,imageView.bounds.size.height*0.8);
    self.messageLabel.font = [UIFont systemFontOfSize:16];
    self.messageLabel.text = self.message.message;
    [self.messageLabel sizeToFit];
    [imageView addSubview:self.messageLabel];
    self.cachedImageView = imageView;
    JSQMessagesBubbleImageFactory *bubbleFactory= [[JSQMessagesBubbleImageFactory alloc] init];
    if (self.appliesMediaViewMaskAsOutgoing) {
        [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
        [[[JSQMessagesMediaViewBubbleImageMasker alloc] initWithBubbleImageFactory:bubbleFactory] applyOutgoingBubbleImageMaskToMediaView:self.cachedImageView];
    }else{
        [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
        [[[JSQMessagesMediaViewBubbleImageMasker alloc] initWithBubbleImageFactory:bubbleFactory] applyIncomingBubbleImageMaskToMediaView:self.cachedImageView];
    }
    if (_message.activeType == 1) {
       
    }
    return self.cachedImageView;
}

@end
