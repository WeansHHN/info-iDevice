std::string namedv = [[UIDevice currentDevice] name].UTF8String;
NSDate *now = [NSDate date];
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
[dateFormatter setDateFormat:@"EEEE dd/MM/yyyy"];
NSString *dateString = [dateFormatter stringFromDate:now];

UIDevice *device = [UIDevice currentDevice];
device.batteryMonitoringEnabled = YES;

float batteryLevel = device.batteryLevel * 100;
NSString *chargingStatus = @"";
if (device.batteryState == UIDeviceBatteryStateCharging) {
    chargingStatus = @"- Đang Sạc";
} else if (device.batteryState == UIDeviceBatteryStateFull) {
    chargingStatus = @"- Đầy Pin";
} else {
    chargingStatus = @"- Đã Ngắt Sạc";
}

long numCores;
size_t len = sizeof(numCores);
sysctlbyname("hw.ncpu", &numCores, &len, NULL, 0);

kern_return_t kr;
task_info_data_t tinfo;
mach_msg_type_number_t task_info_count = TASK_INFO_MAX;

kr = task_info(mach_task_self(),
               TASK_BASIC_INFO,
               (task_info_t)tinfo,
               &task_info_count);
if (kr != KERN_SUCCESS) {
    // Xử lý lỗi tại đây
}

task_basic_info_t basic_info;
thread_array_t thread_list;
mach_msg_type_number_t thread_count;

thread_info_data_t thinfo;
mach_msg_type_number_t thread_info_count;

basic_info = (task_basic_info_t)tinfo;

// Calculate RAM usage
natural_t used_ram = (basic_info->resident_size) / 1024 / 1024;
// Calculate available RAM
natural_t free_ram = ([NSProcessInfo processInfo].physicalMemory) / 1024 / 1024 - used_ram;
char used_ram_str[100];
char free_ram_str[100];

ImVec4 used_color = ImVec4(0.5f, 0, 0.5f, 1);
ImVec4 ram_color = ImVec4(1, 1, 0, 1);

long num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
long page_size = sysconf(_SC_PAGESIZE);
long num_pages = sysconf(_SC_PHYS_PAGES);
long ram_total = num_pages * page_size;