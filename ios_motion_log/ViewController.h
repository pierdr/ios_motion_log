//
//  ViewController.h
//  AccelerometerLog
//
//  Created by local on 10/3/15.
//  Copyright (c) 2015 binaryfutures. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
@import CoreLocation;
@import CoreMotion;

@interface ViewController : UIViewController

@property (nonatomic) CMMotionManager *motionManager;

@property (strong, nonatomic) IBOutlet UILabel *accX;
@property (strong, nonatomic) IBOutlet UILabel *accY;
@property (strong, nonatomic) IBOutlet UILabel *accZ;

@property (strong, nonatomic) IBOutlet UILabel *rotX;
@property (strong, nonatomic) IBOutlet UILabel *rotY;
@property (strong, nonatomic) IBOutlet UILabel *rotZ;

@property (strong, nonatomic) IBOutlet UILabel *magX;
@property (strong, nonatomic) IBOutlet UILabel *magY;
@property (strong, nonatomic) IBOutlet UILabel *magZ;

@property (strong, nonatomic) IBOutlet UILabel *motYaw;
@property (strong, nonatomic) IBOutlet UILabel *motPitch;
@property (strong, nonatomic) IBOutlet UILabel *motRoll;
@property (strong, nonatomic) IBOutlet UILabel *motW;

-(void)outputMagneticData:(CMMagnetometerData*) magnetometerData;
-(void)outputMotionData:(CMDeviceMotion*) motion;
-(void)outputAccelertionData:(CMAcceleration)acceleration;
-(void)outputRotationData:(CMRotationRate)rotation;

-(IBAction)saveData:(id)sender;

-(IBAction)setMarker:(id)sender;
-(IBAction)setBegin:(id)sender;

@end

