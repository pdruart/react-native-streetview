//
//  NSTStreetView.java
//  react-native-streetview
//
//  Created by Amit Palomo on 26/04/2017.
//  Copyright © 2017 Nester.co.il.
//


package co.il.nester.android.react.streetview;

import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.events.EventDispatcher;
import com.google.android.gms.maps.OnStreetViewPanoramaReadyCallback;
import com.google.android.gms.maps.StreetViewPanorama;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.StreetViewPanoramaCamera;
import com.google.android.gms.maps.model.StreetViewPanoramaLocation;
import com.google.android.gms.maps.model.StreetViewSource;
import com.google.android.gms.maps.StreetViewPanoramaView;
import com.google.android.gms.maps.model.StreetViewPanoramaCamera;
import com.google.android.gms.maps.model.StreetViewPanoramaLocation;

import android.content.Context;

public class NSTStreetView extends StreetViewPanoramaView implements OnStreetViewPanoramaReadyCallback {

    private StreetViewPanorama panorama;
    private Boolean allGesturesEnabled = true;
    private LatLng coordinate = null;
    private StreetViewPanoramaCamera camera = null;

    public NSTStreetView(Context context) {
        super(context);
        super.onCreate(null);
        super.onResume();
        super.getStreetViewPanoramaAsync(this);
    }

    private final Runnable measureAndLayout = new Runnable() {
        @Override
        public void run() {
          measure(
              MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.EXACTLY),
              MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.EXACTLY));
          layout(getLeft(), getTop(), getRight(), getBottom());
        }
      };

    @Override
    public void requestLayout() {
      super.requestLayout();
  
      // Required for correct requestLayout
      // H/T https://github.com/facebook/react-native/issues/4990#issuecomment-180415510
      post(measureAndLayout);
    }

    @Override
    public void onStreetViewPanoramaReady(StreetViewPanorama p) {
        panorama = p;
        panorama.setPanningGesturesEnabled(allGesturesEnabled);

        if (coordinate != null) {
            panorama.setPosition(coordinate, StreetViewSource.OUTDOOR);
            if (camera != null) {
                panorama.setOnStreetViewPanoramaChangeListener(new StreetViewPanorama.OnStreetViewPanoramaChangeListener() {
                    @Override
                    public void onStreetViewPanoramaChange(StreetViewPanoramaLocation location) {
                        if (location != null) {
                            panorama.animateTo(camera, 0);
                        }
                    }
                });
            }
        }
    }

    public void setAllGesturesEnabled(boolean allGesturesEnabled) {
        // Saving to local variable as panorama may not be ready yet (async)
        this.allGesturesEnabled = allGesturesEnabled;
    }

    public void setCoordinate(ReadableMap coordinate) {

        if (coordinate == null ) return;
        Double lng = coordinate.getDouble("longitude");
        Double lat = coordinate.getDouble("latitude");

        // saving radius
        this.radius = coordinate.hasKey("radius") ? coordinate.getInt("radius") : 50;

        // Saving to local variable as panorama may not be ready yet (async)
        this.coordinate = new LatLng(lat, lng);
    }

    float getFloat(ReadableMap map, String property, float defaultValue) {
        return map.hasKey(property) ? (float) map.getDouble(property)
                                    : defaultValue;
    }

    public void setCamera(ReadableMap camera) {

        if (camera == null) return;

        float bearing = getFloat(camera, "heading", 0);
        float tilt = getFloat(camera, "pitch", 0);
        float zoom = getFloat(camera, "zoom", 1.0f);

        this.camera = new StreetViewPanoramaCamera.Builder()
            .bearing(bearing)
            .tilt(tilt)
            .zoom(zoom)
            .build();
    }

}
