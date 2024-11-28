#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#include <thread>
#include <mach/mach.h>
#include <sys/sysctl.h>
#include <sys/stat.h>
#import "iDecive.h"

bool isJailbroken() {
    //Rootfull
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        return true;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]) {
        return true;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]) {
        return true;
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]) {
        return true;
    }

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/Check.Packages"]]) {
        return true;
    }
    //Rootless
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/jb/usr/sbin/sshd"]) {
        return true;
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/jb"]) {
        return true;
    }

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sileo://source/Check.Packages"]]) {
        return true;
    }
    return false;
}

UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;

    // Lấy thông tin về pin
    float batteryLevel = device.batteryLevel * 100;
    NSString *chargingStatus;
    if (device.batteryState == UIDeviceBatteryStateCharging) {
        chargingStatus = @"Đang Sạc";
    } else if (device.batteryState == UIDeviceBatteryStateFull) {
        chargingStatus = @"Đầy Pin";
    } else {
        chargingStatus = @"Đã Ngắt Sạc";
    }

    // Lấy thông tin ngày
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE dd/MM/yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];

    // Lấy số nhân CPU
    long num_cpus = sysconf(_SC_NPROCESSORS_ONLN);

    // Tính toán RAM
    size_t len;
    natural_t free_ram = [[NSProcessInfo processInfo] physicalMemory] / 1024 / 1024; // MB
    natural_t used_ram = 0;  // Tính RAM đã sử dụng (nếu có logic thực hiện)

    // Lấy tên thiết bị
    std::string namedv = [[device name] UTF8String];  // Chuyển NSString thành std::string

if (currentTab == 0) {

    // Hiển thị thông tin trên ImGui
    ImGui::TextColored(ImColor(255, 255, 255), "Hello");
    ImGui::SameLine();
    ImGui::TextColored(ImColor(255, 255, 255), "%s", namedv.c_str());

    ImGui::TextColored(ImVec4(1.0f, 1.0f, 1.0f, 1.0f), "Trạng Thái:");
    ImGui::SameLine();
    if (isJailbroken()) {  // Kiểm tra jailbreak của thiết bị
        ImGui::TextColored(ImVec4(1.0f, 0.0f, 0.0f, 1.0f), "Đã Jailbreak !");
    } else {
        ImGui::TextColored(ImVec4(0.0f, 1.0f, 0.0f, 1.0f), "Chưa Jailbreak !");
    }

    ImGui::Separator();

    // Màu sắc
    ImVec4 red = ImVec4(0.92f, 0.59f, 0.58f, 1.0f);
    ImVec4 green = ImVec4(0.76f, 0.88f, 0.77f, 1.0f);
    ImVec4 cyan = ImVec4(0.0f, 1.0f, 1.0f, 1.0f);
    ImVec4 blue = ImVec4(0.77f, 0.87f, 0.96f, 1.00f);
    ImVec4 white = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);

    // Hiển thị ngày
    ImGui::TextColored(white, "Ngày:");
    ImGui::SameLine();
    ImGui::TextColored(blue, "%s", [dateString UTF8String]);

    // Hiển thị trạng thái pin
    ImGui::TextColored(white, "Pin:");
    ImGui::SameLine();
    ImGui::TextColored(cyan, "%.0f%%", batteryLevel);
    ImGui::SameLine();
    ImGui::TextColored(white, "/");
    ImGui::SameLine();
    ImGui::TextColored((device.batteryState == UIDeviceBatteryStateCharging || device.batteryState == UIDeviceBatteryStateFull) ? green : red,
                       "%s", [chargingStatus UTF8String]);

    // Hiển thị CPU
    ImGui::TextColored(white, "Tổng CPU:");
    ImGui::SameLine();
    ImGui::TextColored(ImColor(0, 255, 0), " %ld", num_cpus);

    // Hiển thị RAM
    ImGui::TextColored(white, "RAM trống:");
    ImGui::SameLine();
    ImGui::TextColored(ImColor(0, 255, 0), "%u MB", free_ram);

}
