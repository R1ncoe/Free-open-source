//
//  Menu.mm
//  ModMenu
//
//  Created by R1ncoe on 6/17/22.
//  Copyright © 2022 R1ncoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Menu.h"

@interface Menu ()

@property (assign, nonatomic) CGPoint lastMenuLocation;
@property (strong, nonatomic) UILabel *menuTitle;
@property (strong, nonatomic) UIView *header;
@property (strong, nonatomic) UIView *footer;
@property (strong, nonatomic) UILabel *footerText;

@end


@implementation Menu

NSUserDefaults *defaults;
UIScrollView *scrollView;
UIScrollView *scrollView2;
UIScrollView *scrollView3;
CGFloat menuWidth;
CGFloat scrollViewX;
NSString *credits;
UIColor *switchOnColor;
NSString *switchTitleFont;
UIColor *switchTitleColor;
UIColor *infoButtonColor;
NSString *menuIconBase64;
NSString *menuButtonBase64;
UILabel *watermark;
UIDevice *myDevice;
NSDateFormatter *ttime;
float scrollViewHeight = 0;
float scrollView2Height = 0;
float scrollView3Height = 0;
BOOL hasRestoredLastSession = false;
UIButton *menuButton;
UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
UIView *menuRightBorder1;
UIView *menuRightBorder;

const char *frameworkName = NULL;

UIWindow *mainWindow;


// init the menu
// global variabls, extern in Macros.h
Menu *menu = [[Menu alloc]init];
Switches *switches = [[Switches alloc]init];


-(id)initWithTitle:(NSString *)title_ titleColor:(UIColor *)titleColor_ titleFont:(NSString *)titleFont_ credits:(NSString *)credits_ headerColor:(UIColor *)headerColor_ switchOffColor:(UIColor *)switchOffColor_ switchOnColor:(UIColor *)switchOnColor_ switchTitleFont:(NSString *)switchTitleFont_ switchTitleColor:(UIColor *)switchTitleColor_ infoButtonColor:(UIColor *)infoButtonColor_ maxVisibleSwitches:(int)maxVisibleSwitches_ menuWidth:(CGFloat )menuWidth_ menuIcon:(NSString *)menuIconBase64_ menuButton:(NSString *)menuButtonBase64_ {
    mainWindow = [UIApplication sharedApplication].keyWindow;
    defaults = [NSUserDefaults standardUserDefaults];

    menuWidth = menuWidth_;
    switchOnColor = switchOnColor_;
    credits = credits_;
    switchTitleFont = switchTitleFont_;
    switchTitleColor = switchTitleColor_;
    infoButtonColor = infoButtonColor_;
    menuButtonBase64 = menuButtonBase64_;

NSString *bat = @"%";

    myDevice = [UIDevice currentDevice];
       [myDevice setBatteryMonitoringEnabled:YES];
           double batLeft = (float)[myDevice batteryLevel] * 100;

   ttime = [[NSDateFormatter alloc] init];
      [ttime setDateFormat:@"hh:mm a"];

watermark = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 153.5, 25)];
watermark.textColor = [UIColor whiteColor];
watermark.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
watermark.layer.borderColor = [UIColor blackColor].CGColor;
watermark.layer.borderWidth = 2.0f;
watermark.layer.cornerRadius = 1.0;
watermark.text = [NSString stringWithFormat:@" byYourname | %.0f%@ | %@",batLeft,bat,[ttime stringFromDate:[NSDate date]]];
watermark.adjustsFontSizeToFitWidth = YES;
watermark.layer.opacity = 0;
watermark.font = [UIFont fontWithName:@"Avenir-Heavy" size:13.0f];
watermark.center = CGPointMake(CGRectGetMaxX(mainWindow.frame)-(watermark.frame.size.width/2)-[[switches getValueFromSwitch:@"Watermark X:"] floatValue], CGRectGetMinY(mainWindow.frame)+(watermark.frame.size.height/2)+[[switches getValueFromSwitch:@"Watermark Y:"] floatValue]);
[mainWindow addSubview:watermark];

[NSTimer scheduledTimerWithTimeInterval:0.001f target:self selector:@selector(watermark) userInfo:nil repeats:YES];

        [UIView animateWithDuration:0.25 animations:^ {
if([switches isSwitchOn:@"Watermark"]){
watermark.layer.opacity = 1;
}else{
watermark.layer.opacity = 0;
}
}];



    // Base of the Menu UI.
    self = [super initWithFrame:CGRectMake(0,0,menuWidth_, maxVisibleSwitches_ * 50 + 50)];
    self.center = mainWindow.center;
    self.layer.opacity = 0.0f;

    self.header = [[UIView alloc]initWithFrame:CGRectMake(0, 1, menuWidth_, 50)];
    self.header.backgroundColor = headerColor_;
    CAShapeLayer *headerLayer = [CAShapeLayer layer];
    headerLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.header.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    self.header.layer.mask = headerLayer;
    [self addSubview:self.header];


    NSData* data = [[NSData alloc] initWithBase64EncodedString:menuIconBase64_ options:0];
    UIImage* menuIconImage = [UIImage imageWithData:data];

    UIButton *menuIcon = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    menuIcon.frame = CGRectMake(5, 1, 50, 50);
    menuIcon.backgroundColor = [UIColor clearColor];
    [menuIcon setBackgroundImage:menuIconImage forState:UIControlStateNormal];

    [menuIcon addTarget:self action:@selector(menuIconTapped) forControlEvents:UIControlEventTouchDown];
    [self.header addSubview:menuIcon];

[button addTarget:self 
 action:@selector(ButtonClicked:)
 forControlEvents:UIControlEventTouchUpInside];
[button setTitle:@"1" forState:UIControlStateNormal];
button.frame = CGRectMake(60.0, 15.0, 65.0, 25.0);
button.layer.cornerRadius = 2.0;
button.layer.masksToBounds = true;
button.backgroundColor =  [UIColor clearColor];
button.layer.borderColor = [UIColor clearColor].CGColor;
UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked)];
[button addGestureRecognizer:buttonTap];
[_header addSubview:button];

[button2 addTarget:self 
 action:@selector(ButtonClicked2:)
 forControlEvents:UIControlEventTouchUpInside];
[button2 setTitle:@"2" forState:UIControlStateNormal];
button2.frame = CGRectMake(130.0, 15.0, 65.0, 25.0);
button2.layer.cornerRadius = 2.0;
button2.layer.masksToBounds = true;
button2.backgroundColor =  [UIColor clearColor];
button2.layer.borderColor = [UIColor clearColor].CGColor;
UITapGestureRecognizer *buttonTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked2)];
[button2 addGestureRecognizer:buttonTap2];
[_header addSubview:button2];

[button3 addTarget:self 
 action:@selector(ButtonClicked3:)
 forControlEvents:UIControlEventTouchUpInside];
[button3 setTitle:@"3" forState:UIControlStateNormal];
button3.frame = CGRectMake(200.0, 15.0, 65.0, 25.0);
button3.layer.cornerRadius = 2.0;
button3.layer.masksToBounds = true;
button3.backgroundColor =  [UIColor clearColor];
button3.layer.borderColor = [UIColor clearColor].CGColor;
UITapGestureRecognizer *buttonTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ButtonClicked3)];
[button3 addGestureRecognizer:buttonTap3];
[_header addSubview:button3];


    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.header.bounds), menuWidth_, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.header.bounds))];
    scrollView.backgroundColor = switchOffColor_;
    scrollView.alpha = 0;
    [self addSubview:scrollView];

    scrollView2 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.header.bounds), menuWidth_, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.header.bounds))];
    scrollView2.backgroundColor = switchOffColor_;
    scrollView2.alpha = 1;
    [self addSubview:scrollView2];

    scrollView3 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.header.bounds), menuWidth_, CGRectGetHeight(self.bounds) - CGRectGetHeight(self.header.bounds))];
    scrollView3.backgroundColor = switchOffColor_;
    scrollView3.alpha = 0;
    [self addSubview:scrollView3];




    // we need this for the switches, do not remove.
    scrollViewX = CGRectGetMinX(scrollView.self.bounds);

    self.menuTitle = [[UILabel alloc]initWithFrame:CGRectMake(55, -2, menuWidth_ - 60, 50)];
    self.menuTitle.text = title_;
    self.menuTitle.textColor = titleColor_;
    self.menuTitle.font = [UIFont fontWithName:titleFont_ size:30.0f];
    self.menuTitle.adjustsFontSizeToFitWidth = true;
    self.menuTitle.textAlignment = NSTextAlignmentCenter;
    [self.header addSubview: self.menuTitle];

    self.footer = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 1, menuWidth_, 20)];
    self.footer.backgroundColor = headerColor_;
    CAShapeLayer *footerLayer = [CAShapeLayer layer];
    footerLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.footer.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){0.0, 0.0}].CGPath;
    self.footer.layer.mask = footerLayer;
    [self addSubview:self.footer];

self.footerText = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetHeight(self.bounds) - 0, menuWidth_, 20)];
    self.footerText.text = @"By R1ncoe on github!";
    self.footerText.textColor = [UIColor whiteColor];
    self.footerText.font = [UIFont fontWithName:titleFont_ size:13.0f];
    self.footerText.adjustsFontSizeToFitWidth = true;
    self.footerText.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.footerText];

self.footerText = [[UILabel alloc]initWithFrame:CGRectMake(-5, CGRectGetHeight(self.bounds) - 0, menuWidth_, 20)];
    self.footerText.text = @"Free opensource";
    self.footerText.textColor = [UIColor whiteColor];
    self.footerText.font = [UIFont fontWithName:titleFont_ size:13.0f];
    self.footerText.adjustsFontSizeToFitWidth = true;
    self.footerText.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.footerText];

menuRightBorder = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 19, 2)];
   menuRightBorder.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.00];
   menuRightBorder.center = mainWindow.center;
    menuRightBorder.alpha = 0.0;
   [mainWindow addSubview: menuRightBorder];

   menuRightBorder1 = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, 2, 19)];
   menuRightBorder1.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.00];
   menuRightBorder1.center = mainWindow.center;
menuRightBorder1.alpha = 0.0;
   [mainWindow addSubview: menuRightBorder1];

        [UIView animateWithDuration:0.5 animations:^ {
if([switches isSwitchOn:@"Crosshair"]){

menuRightBorder.alpha = 1.0;

menuRightBorder1.alpha = 1.0;

}
else{

menuRightBorder.alpha = 0.0;

menuRightBorder1.alpha = 0.0;
}
}];




    UIPanGestureRecognizer *dragMenuRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(menuDragged:)];
    [self.header addGestureRecognizer:dragMenuRecognizer];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenu:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.header addGestureRecognizer:tapGestureRecognizer];

    [mainWindow addSubview:self];
    [self showMenuButton];

    return self;
}

// Detects whether the menu is being touched and sets a lastMenuLocation.
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.lastMenuLocation = CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
    [super touchesBegan:touches withEvent:event];
}

// Update the menu's location when it's being dragged
- (void)menuDragged:(UIPanGestureRecognizer *)pan {
    CGPoint newLocation = [pan translationInView:self.superview];
    self.frame = CGRectMake(self.lastMenuLocation.x + newLocation.x, self.lastMenuLocation.y + newLocation.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)hideMenu:(UITapGestureRecognizer *)tap {
    if(tap.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.5 animations:^ {
            self.alpha = 0.0f;
            menuButton.alpha = 1.0f;
        }];
    }
}

-(void)showMenu:(UITapGestureRecognizer *)tapGestureRecognizer {
    if(tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        menuButton.alpha = 0.0f;
        [UIView animateWithDuration:0.5 animations:^ {
            self.alpha = 1.0f;
        }];
    }
    // We should only have to do this once (first launch)
    if(!hasRestoredLastSession) {
        restoreLastSession();
        hasRestoredLastSession = true;
    }
}


-(void)ButtonClicked{

button.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7];
button2.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0];
button3.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0];

    scrollView.alpha = 0;
    scrollView2.alpha = 1;
    scrollView3.alpha = 0;
}

-(void)ButtonClicked2{

button.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0];
button2.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7];
button3.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0];

    scrollView.alpha = 1;
    scrollView2.alpha = 0;
    scrollView3.alpha = 0;
}

-(void)ButtonClicked3{

button.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0];
button2.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0];
button3.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.7];

    scrollView.alpha = 0;
    scrollView2.alpha = 0;
    scrollView3.alpha = 1;
}

-(void)watermark{
NSString *bat = @"%";

    myDevice = [UIDevice currentDevice];
       [myDevice setBatteryMonitoringEnabled:YES];
           double batLeft = (float)[myDevice batteryLevel] * 100;

   ttime = [[NSDateFormatter alloc] init];
      [ttime setDateFormat:@"hh:mm a"];


watermark.text = [NSString stringWithFormat:@" byYourName | %.0f%@ | %@",batLeft,bat,[ttime stringFromDate:[NSDate date]]];
watermark.center = CGPointMake(CGRectGetMaxX(mainWindow.frame)-(watermark.frame.size.width/2)-[[switches getValueFromSwitch:@"Watermark X:"] floatValue], CGRectGetMinY(mainWindow.frame)+(watermark.frame.size.height/2)+[[switches getValueFromSwitch:@"Watermark Y:"] floatValue]);

}


void restoreLastSession() {
    UIColor *clearColor = [UIColor clearColor];
    BOOL isOn = false;

    for(id switch_ in scrollView.subviews) {
        if([switch_ isKindOfClass:[OffsetSwitch class]]) {
            isOn = [defaults boolForKey:[switch_ getPreferencesKey]];
            std::vector<MemoryPatch> memoryPatches = [switch_ getMemoryPatches];
            for(int i = 0; i < memoryPatches.size(); i++) {
                if(isOn){
                 memoryPatches[i].Modify();
                } else {
                 memoryPatches[i].Restore();
                }
            }
            ((OffsetSwitch*)switch_).backgroundColor = isOn ? switchOnColor : clearColor;
        }

        if([switch_ isKindOfClass:[TextFieldSwitch class]]) {
            isOn = [defaults boolForKey:[switch_ getPreferencesKey]];
            ((TextFieldSwitch*)switch_).backgroundColor = isOn ? switchOnColor : clearColor;
        }

        if([switch_ isKindOfClass:[SliderSwitch class]]) {
            isOn = [defaults boolForKey:[switch_ getPreferencesKey]];
            ((SliderSwitch*)switch_).backgroundColor = isOn ? switchOnColor : clearColor;
        }
    }
}

-(void)showMenuButton {
    NSData* data = [[NSData alloc] initWithBase64EncodedString:menuButtonBase64 options:0];
    UIImage* menuButtonImage = [UIImage imageWithData:data];

    menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    menuButton.frame = CGRectMake((mainWindow.frame.size.width/2), (mainWindow.frame.size.height/2), 50, 50);
    menuButton.backgroundColor = [UIColor clearColor];
    [menuButton setBackgroundImage:menuButtonImage forState:UIControlStateNormal];

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showMenu:)];
    [menuButton addGestureRecognizer:tapGestureRecognizer];

    [menuButton addTarget:self action:@selector(buttonDragged:withEvent:)
       forControlEvents:UIControlEventTouchDragInside];
    [mainWindow addSubview:menuButton];
}

// handler for when the user is draggin the menu.
- (void)buttonDragged:(UIButton *)button withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:button] anyObject];

    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_x = location.x - previousLocation.x;
    CGFloat delta_y = location.y - previousLocation.y;

    button.center = CGPointMake(button.center.x + delta_x, button.center.y + delta_y);
}

// When the menu icon(on the header) has been tapped, we want to show proper credits!
-(void)menuIconTapped {
    [self showPopup:self.menuTitle.text description:credits];
    self.layer.opacity = 0.0f;
}

-(void)showPopup:(NSString *)title_ description:(NSString *)description_ {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

    alert.shouldDismissOnTapOutside = NO;
    alert.customViewColor = [UIColor purpleColor];
    alert.showAnimationType = SCLAlertViewShowAnimationFadeIn;

    [alert addButton: @"Ok!" actionBlock: ^(void) {
        self.layer.opacity = 1.0f;
    }];

    [alert showInfo:title_ subTitle:description_ closeButtonTitle:nil duration:9999999.0f];
}


- (void)addSwitchToMenu:(id)switch_ {
    [switch_ addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchDown];
    scrollViewHeight += 50;
    scrollView.contentSize = CGSizeMake(menuWidth, scrollViewHeight);
    [scrollView addSubview:switch_];
}

- (void)addSwitchToMenu2:(id)switch_ {
    [switch_ addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchDown];
    scrollView2Height += 50;
    scrollView2.contentSize = CGSizeMake(menuWidth, scrollView2Height);
    [scrollView2 addSubview:switch_];
}

- (void)addSwitchToMenu3:(id)switch_ {
    [switch_ addTarget:self action:@selector(switchClicked:) forControlEvents:UIControlEventTouchDown];
    scrollView3Height += 50;
    scrollView3.contentSize = CGSizeMake(menuWidth, scrollView3Height);
    [scrollView3 addSubview:switch_];
}


- (void)changeSwitchBackground:(id)switch_ isSwitchOn:(BOOL)isSwitchOn_ {
    UIColor *clearColor = [UIColor clearColor];

    [UIView animateWithDuration:0.3 animations:^ {
        if([switch_ isKindOfClass:[TextFieldSwitch class]]) {
            ((TextFieldSwitch*)switch_).backgroundColor = isSwitchOn_ ? clearColor : switchOnColor;
        }
        if([switch_ isKindOfClass:[SliderSwitch class]]) {
            ((SliderSwitch*)switch_).backgroundColor = isSwitchOn_ ? clearColor : switchOnColor;
        }
        if([switch_ isKindOfClass:[OffsetSwitch class]]) {
            ((OffsetSwitch*)switch_).backgroundColor = isSwitchOn_ ? clearColor : switchOnColor;
        }
    }];

    [defaults setBool:!isSwitchOn_ forKey:[switch_ getPreferencesKey]];
}

/*********************************************************************************************
    This method does the following handles the behaviour when a switch has been clicked
    TextfieldSwitch and SliderSwitch only change from color based on whether it's on or not.
    A OffsetSwitch does too, but it also applies offset patches
***********************************************************************************************/
-(void)switchClicked:(id)switch_ {
    BOOL isOn = [defaults boolForKey:[switch_ getPreferencesKey]];

    if([switch_ isKindOfClass:[OffsetSwitch class]]) {
        std::vector<MemoryPatch> memoryPatches = [switch_ getMemoryPatches];
        for(int i = 0; i < memoryPatches.size(); i++) {
            if(!isOn){
                memoryPatches[i].Modify();
            } else {
                memoryPatches[i].Restore();
           }
        }
    }

     // Update switch background color and pref value.
[self changeSwitchBackground:switch_ isSwitchOn:isOn];
if([switches isSwitchOn:@"Crosshair"]){
menuRightBorder.layer.opacity = 1.0;

menuRightBorder1.layer.opacity = 1.0;
}else{
menuRightBorder1.layer.opacity = 0.0;

menuRightBorder.layer.opacity = 0.0;
}
}



   

-(void)setFrameworkName:(const char *)name_ {
    frameworkName = name_;
}

-(const char *)getFrameworkName {
    return frameworkName;
}
@end // End of menu class!


/********************************
    OFFSET SWITCH STARTS HERE!
*********************************/

@implementation OffsetSwitch {
    std::vector<MemoryPatch> memoryPatches;
}

- (id)initHackNamed:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::vector<uint64_t>)offsets_ bytes:(std::vector<std::string>)bytes_ {
    description = description_;
    preferencesKey = hackName_;

    if(offsets_.size() != bytes_.size()){
        [menu showPopup:@"Invalid input count" description:[NSString stringWithFormat:@"Offsets array input count (%d) is not equal to the bytes array input count (%d)", (int)offsets_.size(), (int)bytes_.size()]];
    } else {
        // For each offset, we create a MemoryPatch.
        for(int i = 0; i < offsets_.size(); i++) {
            MemoryPatch patch = MemoryPatch::createWithHex([menu getFrameworkName], offsets_[i], bytes_[i]);
            if(patch.isValid()) {
              memoryPatches.push_back(patch);
            } else {
              [menu showPopup:@"Invalid patch" description:[NSString stringWithFormat:@"Failing offset: 0x%llx, please re-check the hex you entered.", offsets_[i]]];
            }
        }
    }

    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight - 1, menuWidth + 2, 50)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, menuWidth - 60, 50)];
    switchLabel.text = hackName_;
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:18];
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:switchLabel];

    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.frame = CGRectMake(menuWidth - 30, 15, 20, 20);
    infoButton.tintColor = infoButtonColor;

    UITapGestureRecognizer *infoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInfo:)];
    [infoButton addGestureRecognizer:infoTap];
    [self addSubview:infoButton];

    return self;
}

-(void)showInfo:(UIGestureRecognizer *)gestureRec {
    if(gestureRec.state == UIGestureRecognizerStateEnded) {
        [menu showPopup:[self getPreferencesKey] description:[self getDescription]];
        menu.layer.opacity = 0.0f;
    }
}

-(NSString *)getPreferencesKey {
    return preferencesKey;
}

-(NSString *)getDescription {
    return description;
}

- (std::vector<MemoryPatch>)getMemoryPatches {
    return memoryPatches;
}

@end //end of OffsetSwitch class


/**************************************
    TEXTFIELD SWITCH STARTS HERE!
    - Note that this extends from OffsetSwitch.
***************************************/

@implementation TextFieldSwitch {
    UITextField *textfieldValue;
}

- (id)initTextfieldNamed:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    preferencesKey = hackName_;
    switchValueKey = [hackName_ stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    description = description_;

    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight -1, menuWidth + 2, 50)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, menuWidth - 60, 30)];
    switchLabel.text = hackName_;
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:18];
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:switchLabel];

    textfieldValue = [[UITextField alloc]initWithFrame:CGRectMake(menuWidth / 4 - 10, switchLabel.self.bounds.origin.x - 5 + switchLabel.self.bounds.size.height, menuWidth / 2, 20)];
    textfieldValue.layer.borderWidth = 2.0f;
    textfieldValue.layer.borderColor = inputBorderColor_.CGColor;
    textfieldValue.layer.cornerRadius = 10.0f;
    textfieldValue.textColor = switchTitleColor;
    textfieldValue.textAlignment = NSTextAlignmentCenter;
    textfieldValue.delegate = self;
    textfieldValue.backgroundColor = [UIColor clearColor];

    // get value from the plist & show it (if it's not empty).
    if([[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey] != nil) {
        textfieldValue.text = [[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey];
    }

    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    infoButton.frame = CGRectMake(menuWidth - 30, 15, 20, 20);
    infoButton.tintColor = infoButtonColor;

    UITapGestureRecognizer *infoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInfo:)];
    [infoButton addGestureRecognizer:infoTap];
    [self addSubview:infoButton];

    [self addSubview:textfieldValue];

    return self;
}

// so when click "return" the keyboard goes way, got it from internet. Common thing apparantly
-(BOOL)textFieldShouldReturn:(UITextField*)textfieldValue_ {
    switchValueKey = [[self getPreferencesKey] stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    [defaults setObject:textfieldValue_.text forKey:[self getSwitchValueKey]];
    [textfieldValue_ resignFirstResponder];

    return true;
}

-(NSString *)getSwitchValueKey {
    return switchValueKey;
}

@end // end of TextFieldSwitch Class


/*******************************
    SLIDER SWITCH STARTS HERE!
    - Note that this extends from TextFieldSwitch
 *******************************/

@implementation SliderSwitch {
    UISlider *sliderValue;
    float valueOfSlider;
}

- (id)initSliderNamed:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_{
    preferencesKey = hackName_;
    switchValueKey = [hackName_ stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    description = description_;

    self = [super initWithFrame:CGRectMake(-1, scrollViewX + scrollViewHeight -1, menuWidth + 2, 50)];
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;

    switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, menuWidth - 60, 30)];
    switchLabel.text = [NSString stringWithFormat:@"%@ %.2f", hackName_, sliderValue.value];
    switchLabel.textColor = switchTitleColor;
    switchLabel.font = [UIFont fontWithName:switchTitleFont size:18];
    switchLabel.adjustsFontSizeToFitWidth = true;
    switchLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:switchLabel];

    sliderValue = [[UISlider alloc]initWithFrame:CGRectMake(menuWidth / 4 - 20, switchLabel.self.bounds.origin.x - 4 + switchLabel.self.bounds.size.height, menuWidth / 2 + 20, 20)];
    sliderValue.thumbTintColor = sliderColor_;
    sliderValue.minimumTrackTintColor = switchTitleColor;
    sliderValue.maximumTrackTintColor = switchTitleColor;
    sliderValue.minimumValue = minimumValue_;
    sliderValue.maximumValue = maximumValue_;
    sliderValue.continuous = true;
    [sliderValue addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    valueOfSlider = sliderValue.value;

    // get value from the plist & show it (if it's not empty).
    if([[NSUserDefaults standardUserDefaults] objectForKey:switchValueKey] != nil) {
        sliderValue.value = [[NSUserDefaults standardUserDefaults] floatForKey:switchValueKey];
        switchLabel.text = [NSString stringWithFormat:@"%@ %.2f", hackName_, sliderValue.value];
    }

    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    infoButton.frame = CGRectMake(menuWidth - 30, 15, 20, 20);
    infoButton.tintColor = infoButtonColor;

    UITapGestureRecognizer *infoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showInfo:)];
    [infoButton addGestureRecognizer:infoTap];
    [self addSubview:infoButton];

    [self addSubview:sliderValue];

    return self;
}

-(void)sliderValueChanged:(UISlider *)slider_ {
    switchValueKey = [[self getPreferencesKey] stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];
    switchLabel.text = [NSString stringWithFormat:@"%@ %.2f", [self getPreferencesKey], slider_.value];
    [defaults setFloat:slider_.value forKey:[self getSwitchValueKey]];
}

@end // end of SliderSwitch class





@implementation Switches


-(void)addSwitch:(NSString *)hackName_ description:(NSString *)description_ {
    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu:offsetPatch];

}

-(void)addSwitch2:(NSString *)hackName_ description:(NSString *)description_ {
    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu2:offsetPatch];

}

-(void)addSwitch3:(NSString *)hackName_ description:(NSString *)description_ {
    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ offsets:std::vector<uint64_t>{} bytes:std::vector<std::string>{}];
    [menu addSwitchToMenu3:offsetPatch];

}

- (void)addOffsetSwitch:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu:offsetPatch];
}

- (void)addOffsetSwitch2:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu2:offsetPatch];
}

- (void)addOffsetSwitch3:(NSString *)hackName_ description:(NSString *)description_ offsets:(std::initializer_list<uint64_t>)offsets_ bytes:(std::initializer_list<std::string>)bytes_ {
    std::vector<uint64_t> offsetVector;
    std::vector<std::string> bytesVector;

    offsetVector.insert(offsetVector.begin(), offsets_.begin(), offsets_.end());
    bytesVector.insert(bytesVector.begin(), bytes_.begin(), bytes_.end());

    OffsetSwitch *offsetPatch = [[OffsetSwitch alloc]initHackNamed:hackName_ description:description_ offsets:offsetVector bytes:bytesVector];
    [menu addSwitchToMenu3:offsetPatch];
}

- (void)addTextfieldSwitch:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    TextFieldSwitch *textfieldSwitch = [[TextFieldSwitch alloc]initTextfieldNamed:hackName_ description:description_ inputBorderColor:inputBorderColor_];
    [menu addSwitchToMenu:textfieldSwitch];
}

- (void)addTextfieldSwitch2:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    TextFieldSwitch *textfieldSwitch = [[TextFieldSwitch alloc]initTextfieldNamed:hackName_ description:description_ inputBorderColor:inputBorderColor_];
    [menu addSwitchToMenu2:textfieldSwitch];
}

- (void)addTextfieldSwitch3:(NSString *)hackName_ description:(NSString *)description_ inputBorderColor:(UIColor *)inputBorderColor_ {
    TextFieldSwitch *textfieldSwitch = [[TextFieldSwitch alloc]initTextfieldNamed:hackName_ description:description_ inputBorderColor:inputBorderColor_];
    [menu addSwitchToMenu3:textfieldSwitch];
}

- (void)addSliderSwitch:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SliderSwitch *sliderSwitch = [[SliderSwitch alloc] initSliderNamed:hackName_ description:description_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu:sliderSwitch];
}

- (void)addSliderSwitch2:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SliderSwitch *sliderSwitch = [[SliderSwitch alloc] initSliderNamed:hackName_ description:description_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu2:sliderSwitch];
}

- (void)addSliderSwitch3:(NSString *)hackName_ description:(NSString *)description_ minimumValue:(float)minimumValue_ maximumValue:(float)maximumValue_ sliderColor:(UIColor *)sliderColor_ {
    SliderSwitch *sliderSwitch = [[SliderSwitch alloc] initSliderNamed:hackName_ description:description_ minimumValue:minimumValue_ maximumValue:maximumValue_ sliderColor:sliderColor_];
    [menu addSwitchToMenu3:sliderSwitch];
}

- (NSString *)getValueFromSwitch:(NSString *)name {

    //getting the correct key for the saved input.
    NSString *correctKey =  [name stringByApplyingTransform:NSStringTransformLatinToCyrillic reverse:false];

    if([[NSUserDefaults standardUserDefaults] objectForKey:correctKey]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:correctKey];
    }
    else if([[NSUserDefaults standardUserDefaults] floatForKey:correctKey]) {
        NSString *sliderValue = [NSString stringWithFormat:@"%f", [[NSUserDefaults standardUserDefaults] floatForKey:correctKey]];
        return sliderValue;
    }

    return 0;
}

-(bool)isSwitchOn:(NSString *)switchName {
    return [[NSUserDefaults standardUserDefaults] boolForKey:switchName];
}

@end
