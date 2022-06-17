#import "Macros.h"


void setup() {


[switches addSwitch3:NSSENCRYPT("test3")
  description:NSSENCRYPT("Teleport all enemies to you without them knowing")
];

[switches addSwitch2:NSSENCRYPT("test2")
  description:NSSENCRYPT("Teleport all enemies to you without them knowing")
];



  
[switches addSwitch:NSSENCRYPT("test1")
  description:NSSENCRYPT("Teleport all enemies to you without them knowing")
];





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