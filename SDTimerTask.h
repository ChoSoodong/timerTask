







#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDTimerTask : NSObject

/** 总时间 */
@property (nonatomic, assign) NSInteger timeInterval;


/**
 开始计时

 @param completeBlock 完成回调,天数,小时数,分钟数,秒数,总时间(单位:秒)
 回调格式为:day:00 hour:01 minute:02 second:34
 */
-(void)startTimerTaskWithCompleteBlock:(void (^)(NSString *day,NSString *hour,NSString *minute,NSString *second,NSInteger timeInterval))completeBlock;


/**
 结束计时
 */
-(void)stop;
@end

NS_ASSUME_NONNULL_END
