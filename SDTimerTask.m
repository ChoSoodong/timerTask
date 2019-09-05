







#import "SDTimerTask.h"

@interface SDTimerTask()

@property(nonatomic,retain) dispatch_source_t timer;

@end

@implementation SDTimerTask

-(void)startTimerTaskWithCompleteBlock:(void (^)(NSString *day,NSString *hour,NSString *minute,NSString *second,NSInteger timeInterval))completeBlock{
    if (_timer==nil) {

         _timeInterval = 1;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
   
            int days = (int)(_timeInterval/(3600*24));
            int hours = (int)((_timeInterval-days*24*3600)/3600);
            int minute = (int)(_timeInterval-days*24*3600-hours*3600)/60;
            int second = (int)(_timeInterval-days*24*3600-hours*3600-minute*60);
            
            NSString *daysStr = days < 10 ? [NSString stringWithFormat:@"0%d",days] : [NSString stringWithFormat:@"%d",days];
            NSString *hoursStr = hours < 10 ? [NSString stringWithFormat:@"0%d",hours] : [NSString stringWithFormat:@"%d",hours];
            NSString *minuteStr = minute < 10 ? [NSString stringWithFormat:@"0%d",minute] : [NSString stringWithFormat:@"%d",minute];
            NSString *secondStr = second < 10 ? [NSString stringWithFormat:@"0%d",second] : [NSString stringWithFormat:@"%d",second];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock(daysStr,hoursStr,minuteStr,secondStr,_timeInterval);
            });
            _timeInterval++;
    
        });
        dispatch_resume(_timer);
     
    }
}
/**
 *  主动销毁定时器
 */
-(void)stop{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
