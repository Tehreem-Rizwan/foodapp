import 'package:flutter/material.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/app_images.dart';
import 'package:foodapp/constants/app_styling.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';
import 'package:foodapp/view/widget/common_image_view_widget.dart';
import 'package:foodapp/view/widget/custom_delievery_time_widget.dart';
import 'package:foodapp/view/widget/custom_driver_info_widget.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class DeliveryOrderScreen extends StatefulWidget {
  @override
  _DeliveryOrderScreenState createState() => _DeliveryOrderScreenState();
}

class _DeliveryOrderScreenState extends State<DeliveryOrderScreen> {
  GoogleMapController? _mapController;
  LatLng _initialPosition =
      LatLng(37.7749, -122.4194); // Default location (San Francisco)
  LatLng? _riderLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _riderLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _riderLocation == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _riderLocation!,
                    zoom: 14,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  markers: {
                    if (_riderLocation != null)
                      Marker(
                        markerId: MarkerId('rider'),
                        position: _riderLocation!,
                        infoWindow: InfoWindow(title: 'Rider'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueOrange),
                      ),
                  },
                ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kTertiaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: kSecondaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                      SizedBox(width: 70),
                      CustomText(
                        text: AppLocalizations.of(context)!.delieverdyourorder,
                        size: 16,
                        weight: FontWeight.w600,
                        color: kBlackyColor,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                DriverInfoWidget(
                  driverName: AppLocalizations.of(context)!.cristopertDastin,
                  driverId: '213752',
                  driverImage: Assets.imagesCristopertDastin,
                  messageIcon: Assets.imagesMsg,
                  callIcon: Assets.imagesPhonecall,
                ),
                DeliveryTimeWidget(
                  deliveryText: AppLocalizations.of(context)!.yourDeliveryTime,
                  estimatedTime:
                      AppLocalizations.of(context)!.estimated830915PM,
                  primaryColor: kBlackyColor,
                  secondaryColor: kgreyblackColor,
                ),
                CommonImageView(
                    imagePath: Assets.imagesProgress,
                    fit: BoxFit.contain,
                    width: 327,
                    height: 24),
                SizedBox(height: h(context, 16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: AppLocalizations.of(context)!.order,
                      size: 14,
                      weight: FontWeight.w600,
                      color: kBlackyColor,
                    ),
                  ],
                ),
                Padding(
                  padding: all(context, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppLocalizations.of(context)!.burger2WithMeat,
                        size: 14,
                        color: kgreyblackColor,
                      ),
                      CustomText(
                        text: '\$283',
                        size: 14,
                        color: kgreyblackColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h(context, 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
