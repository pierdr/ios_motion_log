//
//  ViewController.m
//  AccelerometerLog
//
//  Created by local on 10/3/15.
//  Copyright (c) 2015 binaryfutures. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
}


@end

@implementation ViewController



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelertionData:accelerometerData.acceleration];
                                                 if(error){
                                                     
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
    
    [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue currentQueue]
                                    withHandler:^(CMGyroData *gyroData, NSError *error) {
                                        [self outputRotationData:gyroData.rotationRate];
                                        if(error){
                                            
                                            NSLog(@"%@", error);
                                        }
                                    }];
    
    [self.motionManager startMagnetometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                            withHandler:^(CMMagnetometerData *magnetometerData, NSError *error) {
                                                [self outputMagneticData:magnetometerData];
                                                if(error){
                                                    
                                                    NSLog(@"%@", error);
                                                }
                                                
                                            }];
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical
                                                            toQueue:[NSOperationQueue currentQueue]
                                                        withHandler:^(CMDeviceMotion *motion, NSError *error) {
                                                            [self outputMotionData:motion];
                                                            if(error){
                                                                
                                                                NSLog(@"%@", error);
                                                            }
                                                        }];
    
}
-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    
    self.accX.text = [NSString stringWithFormat:@" %.006f",acceleration.x];
    
    self.accY.text = [NSString stringWithFormat:@" %.006f",acceleration.y];
    
    self.accZ.text = [NSString stringWithFormat:@" %.006f",acceleration.z];
    
    
}
-(void)outputRotationData:(CMRotationRate)rotation
{
    
    self.rotX.text = [NSString stringWithFormat:@" %.006f",rotation.x];
    
    self.rotY.text = [NSString stringWithFormat:@" %.006f",rotation.y];
    
    self.rotZ.text = [NSString stringWithFormat:@" %.006f",rotation.z];
    
    
}
-(void)outputMagneticData:(CMMagnetometerData*) magnetometerData
{
    
    self.magX.text = [NSString stringWithFormat:@" %.006f",magnetometerData.magneticField.x];
    
    self.magY.text = [NSString stringWithFormat:@" %.006f",magnetometerData.magneticField.y];
    
    self.magZ.text = [NSString stringWithFormat:@" %.006f",magnetometerData.magneticField.z];
    
    
}
-(void)outputMotionData:(CMDeviceMotion*) motion
{
    
    
    self.motPitch.text = [NSString stringWithFormat:@" %.006f",motion.attitude.pitch];
    
    self.motRoll.text = [NSString stringWithFormat:@" %.006f",motion.attitude.roll];
    
    self.motYaw.text = [NSString stringWithFormat:@" %.006f",motion.attitude.yaw];
    
    self.motW.text  =[NSString stringWithFormat:@" %.006f",motion.attitude.quaternion.w];
    
    
}


-(IBAction)saveData:(id)sender{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    
    NSError *error;
    //CURRENT TIME
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh-mm-ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
    
    NSString* results =[NSString stringWithFormat:@"acc x:%@,y:%@,z:%@\n rot x:%@,y:%@,z:%@\n mag  x:%@,y:%@,z:%@\n mot: pitch:%@,roll:%@,yaw:%@,w:%@\n",self.accX.text,self.accY.text,self.accZ.text,self.rotX.text,self.rotY.text,self.rotZ.text,self.magX.text,self.magY.text,self.magZ.text,self.motPitch.text,self.motRoll.text,self.motYaw.text,self.motW.text];
    
    //WRITE FILE
    BOOL succeed = [results writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",resultString]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!succeed){
        NSLog(@"Writing file unsuccessful");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to write file"
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
-(IBAction)setMarker:(id)sender{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    
    NSError *error;
    //CURRENT TIME
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh-mm-ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
    NSString* results =[NSString stringWithFormat:@"END"];
    [results writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@END.txt",resultString]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
}
-(IBAction)setBegin:(id)sender{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    
    NSError *error;
    //CURRENT TIME
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh-mm-ss"];
    NSString *resultString = [dateFormatter stringFromDate: currentTime];
    
    NSString* results =[NSString stringWithFormat:@"BEGIN"];
    [results writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@BEGIN.txt",resultString]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
}

@end
