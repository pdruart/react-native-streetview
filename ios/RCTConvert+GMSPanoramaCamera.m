#import "RCTConvert+GMSPanoramaCamera.h"

@implementation RCTConvert(GMSPanoramaCamera)
RCT_CONVERTER(CLLocationDirection, CLLocationDirection, doubleValue);

+ (GMSPanoramaCamera *)GMSPanoramaCamera:(id)json
{
    //  Check for optional fields
    BOOL hasPitch = json[@"pitch"] != nil;
    BOOL hasZoom = json[@"zoom"] != nil;
    BOOL hasFov = json[@"fov"] != nil;

    //  Read values and set defaults
    CLLocationDirection heading = [self CLLocationDirection:json[@"heading"]];
    double pitch = hasPitch ? [self double:json[@"pitch"]] : 0;
    float zoom = hasZoom ? [self float:json[@"zoom"]] : 1.0f;
    double fov = hasFov ? [self double:json[@"fov"]] : 90.0;
    
    return [GMSPanoramaCamera cameraWithHeading:heading pitch:pitch zoom:zoom FOV:fov];
}

@end
