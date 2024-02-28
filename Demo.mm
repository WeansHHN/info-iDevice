#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#include <thread>
#include <mach/mach.h>
#include <sys/sysctl.h>
#include <sys/stat.h>

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
    //Rootless
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/jb/usr/sbin/sshd"]) {
        return true;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/var/jb"]) {
        return true;
    }

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/Check.Packages"]]) {
        return true;
    }

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sileo://source/Check.Packages"]]) {
        return true;
    }
    return false;
}



#import "iDevice.h"

if (ImGui::BeginTabItem(ICON_FA_USER" Thông tin"))
{               
ImGui::TextColored(ImColor(255, 255, 255), "Hello ");
ImGui::SameLine();
ImGui::TextColored(ImColor(255, 255, 255), "%s", namedv.c_str());

ImGui::TextColored(ImVec4(1.0f, 1.0f, 1.0f, 1.0f), "Trạng Thái: ");
ImGui::SameLine();
if (isJailbroken()) {
    ImGui::TextColored(ImVec4(1.0f, 0.0f, 0.0f, 1.0f), "Đã Jailbreak !");
} else {
    ImGui::TextColored(ImVec4(0.0f, 1.0f, 0.0f, 1.0f), "Chưa Jailbreak !");
}
ImGui::Separator();

ImVec4 red = ImVec4(0.92f, 0.59f, 0.58f, 1.0f);
ImVec4 green = ImVec4(0.76f, 0.88f, 0.77f, 1.0f);
ImVec4 cyan = ImVec4(0.0f, 1.0f, 1.0f, 1.0f);
ImVec4 blue = ImVec4(0.77f, 0.87f, 0.96f, 1.00f);
ImVec4 white = ImVec4(1.0f, 1.0f, 1.0f, 1.0f);

ImGui::TextColored(white, "Ngày: ");
ImGui::SameLine();
ImGui::TextColored(blue, "%s", [dateString UTF8String]);

ImGui::TextColored(white, "Pin: ");
ImGui::SameLine();
ImGui::TextColored(cyan, "%.0f%%", batteryLevel);
ImGui::SameLine();
ImGui::TextColored(white, " / ");
ImGui::SameLine();
if (device.batteryState == UIDeviceBatteryStateCharging) {
    ImGui::TextColored(green, "Đang Sạc");
} else if (device.batteryState == UIDeviceBatteryStateFull) {
    ImGui::TextColored(green, "Đầy Pin");
} else {
    ImGui::TextColored(red, "Đã Ngắt Sạc");
}

ImGui::TextColored(white, "Tổng CPU:");
ImGui::SameLine();
ImGui::TextColored(ImColor(0, 255, 0), " %ld bytes", ram_total);
ImGui::SameLine();
ImGui::TextColored(white, " / ");
ImGui::SameLine();
ImGui::TextColored(ImColor(102, 255, 102), "Nhân: %ld", num_cpus);

ImVec4 used_text_color(1, 0, 1, 1);
ImVec4 used_info_color(1, 1, 0, 1);

ImGui::TextColored(white, "Sử dụng RAM:");
ImGui::SameLine();
int used_ram_len = snprintf(used_ram_str, sizeof(used_ram_str), "%s: %d MB", "Đã sử dụng", used_ram);

if (used_ram_len > 0) {
    ImGui::TextColored(used_text_color, "%s", "Đã sử dụng:");
    ImGui::SameLine();
    ImGui::TextColored(used_info_color, "%d MB", used_ram);
}

ImGui::SameLine();
ImGui::TextColored(white, " / ");
ImGui::SameLine();
sprintf(free_ram_str, " %d MB", free_ram);
if (strlen(free_ram_str) > 0) {
    ImGui::TextColored(ImVec4(0, 1, 0, 1), "RAM trống: ");
    ImGui::SameLine();
    ImGui::TextColored(ImVec4(1, 0, 0, 1), "%s", free_ram_str);
}
