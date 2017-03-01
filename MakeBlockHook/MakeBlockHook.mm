#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CaptainHook/CaptainHook.h"
#import <UIKit/UIKit.h>

CHDeclareClass(AppDelegate);

CHMethod2(BOOL, AppDelegate, application, id, arg1, didFinishLaunchingWithOptions, id, arg2) {
    BOOL value = CHSuper2(AppDelegate, application, arg1, didFinishLaunchingWithOptions, arg2);
    // 获取属性
    Ivar ivar = class_getInstanceVariable([self class], "_window");
    UIWindow *keyWindow = object_getIvar(self, ivar);
    
    // *****初始化环信SDK*****
    
    return value;
}

__attribute__((constructor)) static void entry() {
    CHLoadLateClass(AppDelegate);
    CHHook2(AppDelegate, application, didFinishLaunchingWithOptions);
}
