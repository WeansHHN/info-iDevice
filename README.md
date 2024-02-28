# Mô tả

Đây là một ứng dụng iOS sử dụng ImGui để tạo giao diện người dùng. Ứng dụng này cung cấp một số chức năng chính sau:

- Hiển thị thông tin về thiết bị, bao gồm trạng thái jailbreak, ngày, pin, và tài nguyên hệ thống.
- Kiểm tra xem thiết bị đã jailbreak hay chưa bằng cách kiểm tra sự tồn tại của các tệp và ứng dụng được liên quan.
- Sử dụng ImGui để tạo giao diện người dùng và hiển thị thông tin một cách đẹp mắt và dễ đọc.

# Hướng dẫn sử dụng

1. Clone repository này về máy của bạn.
2. Mở project trong Xcode hoặc Theos
3. Chạy ứng dụng trên một thiết bị hoặc máy ảo iOS.

# Tác dụng

- Hàm isJailbroken() kiểm tra xem thiết bị iOS đã jailbreak hay chưa.
```obj-c
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
```

# Yêu cầu

- iOS 11.0+
- Xcode 10.0+

# Thành viên

- Người tạo: [Weans (Hải Ninh)](https://hhnios.site)

# Thông tin thêm

Ứng dụng này sử dụng ImGui, một thư viện giao diện người dùng đa nền tảng.

# Đóng góp

Chúng tôi rất hoan nghênh mọi đóng góp từ cộng đồng. Nếu bạn muốn đóng góp vào dự án này, vui lòng gửi một pull request.
