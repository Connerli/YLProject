//
//  LDUserDefaults+Properties.h
//  Liaodao
//
//  Created by Conner on 2018/5/10.
//

#import "YLUserDefaults.h"

@interface YLUserDefaults (Properties)
//服务器时间
@property (nonatomic, assign) long long serverTime;
//上次同步系统运行时间
@property (nonatomic, assign) long long lastSyncLocalRunTime;
@end
