//Для помощи в использовании меню просьба обратиться ко мне за помощью в дискорд: R1ncoe#9067

#import "Macros.h"


void setup() {


  [switches addOffsetSwitch3:@"No flash"
              description:@"Flash no smooth"
                offsets:{0x18DBC8C}
                  bytes:
{"0x000080D2C0035FD6"}];

[switches addOffsetSwitch2:@"No HE"
              description:@"No HE damage"
                offsets:{0x18E00B8}
                  bytes:
{"0x200080D2C0035FD6"}];



  
[switches addOffsetSwitch:@"No Recoil"
              description:@"No Recoil"
                offsets:{0x18E569C}
                  bytes:{"0xC0035FD6"}];





}



void setupMenu() {

 
  [menu setFrameworkName:"UnityFramework"];

  menu = [[Menu alloc]  
            initWithTitle:NSSENCRYPT("")
            titleColor:[UIColor whiteColor]
            titleFont:NSSENCRYPT("Copperplate-Bold")
            credits:NSSENCRYPT("This Mod Menu has been made by YOURNAME, do not share this without proper credits and my permission. \n\nEnjoy!")
            headerColor:UIColorFromHex(0x000000)
            switchOffColor:[UIColor darkGrayColor]
            switchOnColor:UIColorFromHex(0x00ADF2)
            switchTitleFont:NSSENCRYPT("Copperplate-Bold")
            switchTitleColor:[UIColor whiteColor]
            infoButtonColor:UIColorFromHex(0xBD0000)
            maxVisibleSwitches:4 // Less than max -> blank space, more than max -> you can scroll!
            menuWidth:450
            menuIcon:@""
            menuButton:@""];    

    
    setup();
}

// If the menu button doesn't show up; Change the timer to a bigger amount.
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
  timer(5) {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

    // Website link, remove it if you don't need it.
    [alert addButton: NSSENCRYPT("Visit Me!") actionBlock: ^(void) {
      [[UIApplication sharedApplication] openURL: [NSURL URLWithString: NSSENCRYPT("YOURSITE")]];
      timer(2) {
        setupMenu();
      });        
    }];

    [alert addButton: NSSENCRYPT("Thankyou, understood.") actionBlock: ^(void) {
      timer(2) {
        setupMenu();
      });
    }];    

    alert.shouldDismissOnTapOutside = NO;
    alert.customViewColor = [UIColor purpleColor];  
    alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;   
    
    [alert showSuccess: nil
            subTitle:NSSENCRYPT("читы - Mod Menu \n\nThis Mod Menu has been made by YOURNAME, do not share this without proper credits and my permission. \n\nEnjoy!") 
              closeButtonTitle:nil
                duration:99999999.0f];
  });
}


%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}