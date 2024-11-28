#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <sys/sysctl.h>
#include <mach/mach.h>
#include <unistd.h>

@interface DeviceInfo : NSObject

+ (NSString *)deviceName;
+ (NSString *)currentDate;
+ (NSString *)chargingStatus;
+ (float)batteryLevel;

+ (long)numberOfCores;
+ (NSDictionary<NSString *, NSNumber *> *)memoryUsage;

@end

@implementation DeviceInfo

+ (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

+ (NSString *)currentDate {
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE dd/MM/yyyy"];
    return [dateFormatter stringFromDate:now];
}

+ (NSString *)chargingStatus {
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;

    switch (device.batteryState) {
        case UIDeviceBatteryStateCharging:
            return @"- Đang Sạc";
        case UIDeviceBatteryStateFull:
            return @"- Đầy Pin";
        case UIDeviceBatteryStateUnplugged:
        case UIDeviceBatteryStateUnknown:
        default:
            return @"- Đã Ngắt Sạc";
    }
}

+ (float)batteryLevel {
    return [UIDevice currentDevice].batteryLevel * 100.0;
}

+ (long)numberOfCores {
    size_t size = sizeof(long);
    long numCores = 0;
    sysctlbyname("hw.ncpu", &numCores, &size, NULL, 0);
    return numCores;
}

+ (NSDictionary<NSString *, NSNumber *> *)memoryUsage {
    task_basic_info_data_t tinfo;
    mach_msg_type_number_t tinfo_count = TASK_BASIC_INFO_COUNT;

    kern_return_t kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&tinfo, &tinfo_count);
    if (kr != KERN_SUCCESS) {
        return nil;
    }

    natural_t usedRAM = (tinfo.resident_size) / 1024 / 1024;
    natural_t totalRAM = (natural_t)([NSProcessInfo processInfo].physicalMemory / 1024 / 1024);
    natural_t freeRAM = totalRAM - usedRAM;

    return @{
        @"UsedRAM": @(usedRAM),
        @"FreeRAM": @(freeRAM)
    };
}

@end
