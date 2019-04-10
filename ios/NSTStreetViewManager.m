//
//  NSTStreetViewManager.m
//  react-native-streetview
//
//  Created by Amit Palomo on 26/04/2017.
//  Copyright © 2017 Nester.co.il.
//

#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>
#import <React/RCTConvert+CoreLocation.h>

#import "RCTConvert+GMSPanoramaCamera.h"

@import GoogleMaps;

@interface NSTStreetViewManager : RCTViewManager
@end

@implementation NSTStreetViewManager

RCT_EXPORT_MODULE()

RCT_CUSTOM_VIEW_PROPERTY(coordinate, CLLocationCoordinate, NSTStreetView) {
  if (json == nil) return;
  NSInteger radius = [[json valueForKey:@"radius"] intValue];

  [view moveNearCoordinate:[RCTConvert CLLocationCoordinate2D:json] source:kGMSPanoramaSourceOutside];
}

RCT_CUSTOM_VIEW_PROPERTY(camera, GMSPanoramaCamera, GMSPanoramaView) {
    if (json == nil) return;

    //  set with no animation
    view.camera = [RCTConvert GMSPanoramaCamera:json];
}

RCT_EXPORT_VIEW_PROPERTY(allGesturesEnabled, BOOL)
RCT_EXPORT_VIEW_PROPERTY(onError, RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onSuccess, RCTDirectEventBlock);

- (UIView *)view {
  NSTStreetView *panoView = [[NSTStreetView alloc] initWithFrame:CGRectZero];
  panoView.delegate = panoView;
  return panoView;
}

@end
