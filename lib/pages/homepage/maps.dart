import 'dart:html';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps/google_maps.dart' as gmaps;
import 'package:google_maps/google_maps.dart';
import 'dart:ui' as ui;


import 'package:parking_management/api/api.dart';
import 'package:parking_management/pages/homepage/booking_card.dart';

import '../../controllers/authController.dart';

// class GoogleMap extends StatefulWidget {
//   const GoogleMap({Key key}) : super(key: key);
//
//   @override
//   State<GoogleMap> createState() => _GoogleMapState();
// }
//
// class _GoogleMapState extends State<GoogleMap> {
//   Future data;
//   @override
//   void initState() {
//     data=ApiRequests.getUserdata();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     String htmlId = "7";
// return Container(
//   // ignore: missing_return
//   child:   FutureBuilder(future:data,builder: (context,AsyncSnapshot snapshot)
//   {
//     if(snapshot.hasData)
//       {
//         print("i am here ${snapshot.data[0].id}");
//      // ignore: undefined_prefixed_name
//           ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
//             final myLatlng = gmaps.LatLng(12.937916173784934, 77.58606671055257);
//             final roadAtlasStyles = <MapTypeStyle>[
//               gmaps.MapTypeStyle()..
//               featureType= "administrative.land_parcel"..
//               stylers= [
//                 jsify({
//                   "visibility": "off"
//                 })
//               ]
//               ,
//               gmaps.MapTypeStyle()..
//               featureType= "administrative.neighborhood"..
//               stylers= [
//                 jsify({
//                   "visibility": "off"
//                 })
//               ],
//
//               gmaps.MapTypeStyle()..
//               featureType= "landscape"..
//               elementType= "geometry"..
//               stylers= [
//                 jsify({
//                   "color": "#dedede"
//                 })
//               ],
//
//               gmaps.MapTypeStyle()..
//               featureType= "poi"..
//               elementType= "geometry.fill"..
//               stylers= [
//                 jsify({
//                   "visibility": "on"
//                 })
//               ]
//               ,
//               gmaps.MapTypeStyle()..
//               featureType= "poi"..
//               elementType= "geometry"..
//               stylers= [
//                 jsify({
//                   "visibility": "on"
//                 })
//               ], gmaps.MapTypeStyle()..
//               featureType= "poi"..
//               elementType= "labels"..
//               stylers=  [
//                 jsify({
//                   "visibility": "simplified"
//                 }),
//               ]
//               ,
//               gmaps.MapTypeStyle()..
//               featureType= "poi"..
//               elementType= "labels.text"..
//               stylers=  [
//                 jsify({
//                   "saturation": -40
//                 }),
//                 jsify({
//                   "visibility": "simplified"
//                 }),
//               ]
//               ,
//               gmaps.MapTypeStyle()..
//               featureType= "poi.park"..
//               elementType= "geometry.fill"..
//               stylers= [
//                 jsify({
//                   "color": "#00ffb3"
//                 }),
//               ]
//               ,gmaps.MapTypeStyle()..
//               featureType= "poi.government"..
//               elementType= "labels.text"..
//               stylers= [
//                 jsify({
//                   "visibility": "off"
//                 }),
//               ],
//               gmaps.MapTypeStyle()..
//               featureType= "poi.park"..
//               elementType= "labels.text"..
//               stylers=  [
//                 jsify({
//                   "visibility": "off"
//                 })],
//               gmaps.MapTypeStyle()..
//               featureType= "poi.place_of_worship"..
//               elementType= "labels.text"..
//               stylers=  [
//                 jsify({
//                   "visibility": "off"
//                 }),
//                 jsify({
//                   "visibility": "off"
//                 }),
//               ]
//
//               ,
//               gmaps.MapTypeStyle()..
//               featureType= "road"..
//               elementType= "labels"..
//               stylers= [
//                 jsify({
//                   "visibility": "off"
//                 }),
//               ],
//               gmaps.MapTypeStyle()..
//               featureType= "road"..
//               elementType= "labels.txt"..
//               stylers= [
//                 jsify({
//                   "visibility": "on"
//                 }),
//               ],
//               gmaps.MapTypeStyle()..
//               featureType= "water"..
//               elementType= "labels.text"..
//               stylers= [
//                 jsify({
//                   "visibility": "off"
//                 })
//               ]
//
//             ];
//
//             // another location
//             final myLatlng2 = gmaps.LatLng(12.937243032736022, 77.58631880660613);
//             final myLatlng3 = gmaps.LatLng(12.937685613556328, 77.58589236059608);
//             var kormangla=gmaps.LatLngBounds(gmaps.LatLng(12.92739021440368, 77.60811313721946),gmaps.LatLng(12.943056942765141, 77.63373639189741),);
//             final mapOptions = gmaps.MapOptions()..mapTypeControlOptions = (MapTypeControlOptions()
//               ..mapTypeIds = [MapTypeId.ROADMAP, 'roadatlas'])
//               ..zoom = 18..minZoom=17..maxZoom=19..mapTypeControl=false..streetViewControl=false..fullscreenControl=false
//               ..center = gmaps.LatLng(12.934461915366287, 77.61627994798981)..restriction=(gmaps.MapRestriction()..latLngBounds=kormangla..strictBounds=false);
//
//             gmaps.PolylineOptions polylineOptions,visiblePolylineOptions;
//
//             final elem = DivElement()
//               ..id = htmlId;
// // final styledMapType=gmaps.StyledMapType([  MapTypeStyle()
// //   ..stylers = [
// //     jsify({'hue': '#890000'}),
// //     jsify({'visibility': 'simplified'}),
// //     jsify({'gamma': 0.5}),
// //     jsify({'weight': 0.5}),
// //   ],
// //     MapTypeStyle()
// //         ..elementType = 'labels'
// //         ..stylers = [
// //           jsify({'visibility': 'off'}),
// //         ],
// //       MapTypeStyle()
// //       ..featureType = 'water'
// //       ..stylers = [
// //       jsify({'color': '#890000'}),]],gmaps.StyledMapTypeOptions()..name = 'Custom Style');
//             final map = gmaps.GMap(elem, mapOptions);
//             final styledMapTypeOptions = StyledMapTypeOptions()..name = 'US Road Atlas';
//
//             final usRoadMapType = StyledMapType(roadAtlasStyles, styledMapTypeOptions);
//
//             map.mapTypes.set('usroadatlas', usRoadMapType);
//             map.mapTypeId = 'usroadatlas';
// //       map.mapTypes.set("3ce9a11b8af23fcf", styledMapType);
//             final dirService = gmaps.DirectionsService();
//
//
//             for (var element in snapshot.data) {
//               var request=gmaps.DirectionsRequest()..origin=element.startLatitude+','+element.startLongitude..
//             destination=element.stopLatitude+','+element.stopLongitude..
//               travelMode = gmaps.TravelMode.DRIVING;
//               print("availavleSpaces:${element.availableSpaces}");
//               polylineOptions = gmaps.PolylineOptions()
//                 ..clickable = false
//                 ..visible = false;
//               // var dirRenderer = gmaps.DirectionsRenderer(
//               //     gmaps.DirectionsRendererOptions()
//               //       ..map = map
//               //       ..suppressMarkers = true..polylineOptions=polylineOptions);
//
//               dirService.route(request, (result, status) {
//                 if (status == gmaps.DirectionsStatus.OK) {
//                   List coordinates = [];
//                   // dirRenderer.directions=result;
//
//                   for (var element in result.routes[0].overviewPath) {
//                     coordinates.add(element);
//                   }
//                   print(coordinates);
//                   if (element.availableSpaces>50) {
//                    visiblePolylineOptions= gmaps.PolylineOptions()
//                       ..map = map
//                       ..path = coordinates
//                       ..clickable = true
//                       ..strokeWeight = 10
//                       ..strokeColor = "green"
//                       ..strokeOpacity = 0.5;
//
//                   } else {
//                     visiblePolylineOptions= gmaps.PolylineOptions()
//                       ..map = map
//                       ..path = coordinates
//                       ..clickable = true
//                       ..strokeWeight = 10
//                       ..strokeColor = "red"
//                       ..strokeOpacity = 0.5;
//
//                   }
//                   var polyline = gmaps.Polyline(visiblePolylineOptions);
//
//                   polyline.onClick.listen((event) {
//                     print(event.latLng);
//                     var infoWindow = gmaps.InfoWindow(gmaps.InfoWindowOptions()
//                       ..content =
//                           "<script defer src='maps.dart' type = 'application/dart'></script>  <script defer src = 'packages/browser/dart.js'></script>  <input type='button' id='book' onclick='' value='Display'>"
//                       ..position = event.latLng);
//                     infoWindow.open(map, polyline);
//
//                   });
//                 }
//               });
//             }
//
//             return elem;
//           });
//
//         return HtmlElementView(viewType: htmlId);
//       }
//     else if(snapshot.hasError)
//     {
//       print(snapshot.error);
//       return Container();
//     }
//     else
//       {
//         return CircularProgressIndicator();
//       }
//       })
//
// );
//
// }}

// final marker = gmaps.Marker(gmaps.MarkerOptions()
//   ..position = myLatlng
//   ..map = map
//   ..title = 'Hello World!'
//   ..label = 'P'
//   ..icon =
//       'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png');
//
// // Another marker
// gmaps.Marker(
//   gmaps.MarkerOptions()
//     ..position = myLatlng2
//     ..map = map,
// );
// marker.onClick.listen((event) => infoWindow.open(map, marker));

// var polyLine = gmaps.Polyline(gmaps.PolylineOptions()
//   ..map = map
//   ..path =[myLatlng, myLatlng3, myLatlng2]);
// var polyLine2 = gmaps.Polyline(gmaps.PolylineOptions()
//   ..map = map
//   ..path = [gmaps.LatLng(12.936732972149057, 77.58528771110313), gmaps.LatLng(12.936509968260532, 77.58608253004708)] );
class GoogleMap extends StatelessWidget {
  GoogleMap({Key key,}) : super(key: key);
  final AuthController controller = Get.find<AuthController>();
int timeFactor=0;
  @override
  Widget build(BuildContext context) {
    var htmlId = "7";
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final myLatlng = gmaps.LatLng(12.937916173784934, 77.58606671055257);
      final roadAtlasStyles = <MapTypeStyle>[
        gmaps.MapTypeStyle()
          ..featureType = "administrative.land_parcel"
          ..stylers = [
            jsify({"visibility": "off"})
          ],
        gmaps.MapTypeStyle()
          ..featureType = "administrative.neighborhood"
          ..stylers = [
            jsify({"visibility": "off"})
          ],
        gmaps.MapTypeStyle()
          ..featureType = "landscape"
          ..elementType = "geometry"
          ..stylers = [
            jsify({"color": "#dedede"})
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi"
          ..elementType = "geometry.fill"
          ..stylers = [
            jsify({"visibility": "on"})
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi"
          ..elementType = "geometry"
          ..stylers = [
            jsify({"visibility": "on"})
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi"
          ..elementType = "labels"
          ..stylers = [
            jsify({"visibility": "simplified"}),
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi"
          ..elementType = "labels.text"
          ..stylers = [
            jsify({"saturation": -40}),
            jsify({"visibility": "simplified"}),
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi.park"
          ..elementType = "geometry.fill"
          ..stylers = [
            jsify({"color": "#00ffb3"}),
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi.government"
          ..elementType = "labels.text"
          ..stylers = [
            jsify({"visibility": "off"}),
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi.business"
          ..elementType = "labels.text"
          ..stylers = [
            jsify({"visibility": "off"}),
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi.park"
          ..elementType = "labels.text"
          ..stylers = [
            jsify({"visibility": "off"})
          ],
        gmaps.MapTypeStyle()
          ..featureType = "poi.place_of_worship"
          ..elementType = "labels.text"
          ..stylers = [
            jsify({"visibility": "off"}),
            jsify({"visibility": "off"}),
          ],
        gmaps.MapTypeStyle()
          ..featureType = "road"
          ..elementType = "labels"
          ..stylers = [
            jsify({"visibility": "off"}),
          ],
        gmaps.MapTypeStyle()
          ..featureType = "road"
          ..elementType = "labels.text"
          ..stylers = [
            jsify({"visibility": "on"}),
          ],
        gmaps.MapTypeStyle()
          ..featureType = "water"
          ..elementType = "labels.text"
          ..stylers = [
            jsify({"visibility": "off"})
          ]
      ];

      // another location
      var kormangla = gmaps.LatLngBounds(
        gmaps.LatLng(12.92739021440368, 77.60811313721946),
        gmaps.LatLng(12.943056942765141, 77.63373639189741),
      );
      final mapOptions = gmaps.MapOptions()
        ..mapTypeControlOptions = (MapTypeControlOptions()
          ..mapTypeIds = [MapTypeId.ROADMAP, 'roadatlas'])
        ..zoom = 18
        ..minZoom = 17
        ..maxZoom = 20
        ..mapTypeControl = false
        ..streetViewControl = false
        ..fullscreenControl = false
        ..center = gmaps.LatLng(12.934461915366287, 77.61627994798981)
        ..restriction = (gmaps.MapRestriction()
          ..latLngBounds = kormangla
          ..strictBounds = false);

      gmaps.PolylineOptions polylineOptions, visiblePolylineOptions;

      final elem = DivElement()..id = htmlId;
// final styledMapType=gmaps.StyledMapType([  MapTypeStyle()
//   ..stylers = [
//     jsify({'hue': '#890000'}),
//     jsify({'visibility': 'simplified'}),
//     jsify({'gamma': 0.5}),
//     jsify({'weight': 0.5}),
//   ],
//     MapTypeStyle()
//         ..elementType = 'labels'
//         ..stylers = [
//           jsify({'visibility': 'off'}),
//         ],
//       MapTypeStyle()
//       ..featureType = 'water'
//       ..stylers = [
//       jsify({'color': '#890000'}),]],gmaps.StyledMapTypeOptions()..name = 'Custom Style');
      final map = gmaps.GMap(elem, mapOptions);
      final styledMapTypeOptions = StyledMapTypeOptions()
        ..name = 'US Road Atlas';

      final usRoadMapType =
          StyledMapType(roadAtlasStyles, styledMapTypeOptions);

      map.mapTypes.set('usroadatlas', usRoadMapType);
      map.mapTypeId = 'usroadatlas';
      final dirService = gmaps.DirectionsService();
            var request = gmaps.DirectionsRequest()
        ..origin = gmaps.LatLng(12.933446609675931, 77.62325043037035)
        ..destination = gmaps.LatLng(12.933446609675931, 77.62325043037035)
        ..travelMode = gmaps.TravelMode.DRIVING;
      print("${controller.streets}");
      dirService.route(request,(result,status)
      {
        if(status ==gmaps.DirectionsStatus.OK)
          {
            List coordinates = [];
          // dirRenderer.directions=result;

          for (var element in result.routes[0].overviewPath) {
            coordinates.add(element);
          }
           print(coordinates);
          }
      });
      for (var element in controller.streets) {
        List path=[];
        print("478.dart");
for(var coordinate in element.coordinateString)
  {
    path.add(gmaps.LatLng(coordinate[0], coordinate[1]));
  }

print("path:${path}");
        if (element.availableSpaces > 50) {
          visiblePolylineOptions = gmaps.PolylineOptions()
            ..map = map
            ..path = path
            ..clickable = true
            ..strokeWeight = 10
            ..strokeColor = "green"
            ..strokeOpacity = 0.5;
          print("493.dart");
        } else {
          visiblePolylineOptions = gmaps.PolylineOptions()
            ..map = map
            ..path =  path
            ..clickable = true
            ..strokeWeight = 10
            ..strokeColor = "red"
            ..strokeOpacity = 0.5;
        }
        var polyline = gmaps.Polyline(visiblePolylineOptions);

        polyline.onClick.listen((event) {
          if (controller.bottomSheet == false)
            {
              map.center=event.latLng;
              map.zoom=20;
            }
          BookingCard.streetSelected.value = true;

// print("529-maps.dart spaces:${element.availableSpaces} ");
//print("530-maps.dart spaces:${element.streetName} ");

          BookingCard.availableParkingSpaces.value =
              element.availableSpaces.toString();
          BookingCard.title.value = element.streetName;
          BookingCard.streetId = element.id;
          if (controller.bottomSheet == true) {

                Get.bottomSheet(BookingCard(
                  bottomSheet: true,
                ));
          }
        });
      }


      return elem;
    });

    return HtmlElementView(viewType: htmlId);
  }


}

//
// void buildRoute(gmaps.DirectionsService dirService, gmaps.DirectionsRequest request, element, gmaps.PolylineOptions visiblePolylineOptions, gmaps.GMap map, BuildContext context) async{
//   if(timeFactor==9)
//   {
//     await Future.delayed(Duration(seconds: 1));
//   }
//   else
//     await Future.delayed(Duration(milliseconds: timeFactor*300),()
//     {
//       dirService.route(request, (result, status) async{
//         if (status == gmaps.DirectionsStatus.OK) {
//           timeFactor++;
//           List coordinates = [];
//           // dirRenderer.directions=result;
//
//           for (var element in result.routes[0].overviewPath) {
//             coordinates.add(element);
//           }
//           // print(coordinates);
//           if (element.availableSpaces > 50) {
//             visiblePolylineOptions = gmaps.PolylineOptions()
//               ..map = map
//               ..path = coordinates
//               ..clickable = true
//               ..strokeWeight = 10
//               ..strokeColor = "green"
//               ..strokeOpacity = 0.5;
//           } else {
//             visiblePolylineOptions = gmaps.PolylineOptions()
//               ..map = map
//               ..path = coordinates
//               ..clickable = true
//               ..strokeWeight = 10
//               ..strokeColor = "red"
//               ..strokeOpacity = 0.5;
//           }
//           var polyline = gmaps.Polyline(visiblePolylineOptions);
//
//           polyline.onClick.listen((event) {
//             BookingCard.streetSelected.value = true;
//             map.center=event.latLng;
//             map.zoom=20;
//             // print("529-maps.dart spaces:${element.availableSpaces} ");
//             //print("530-maps.dart spaces:${element.streetName} ");
//             BookingCard.availableParkingSpaces.value =
//                 element.availableSpaces.toString();
//             BookingCard.title.value = element.streetName;
//             BookingCard.streetId = element.id;
//             if (controller.bottomSheet == true) {
//               Scaffold.of(context)
//                   .showBottomSheet<void>((BuildContext context) {
//                 return BookingCard(
//                   bottomSheet: true,
//                 );
//               });
//             }
//           });
//         }
//         else
//         if(status==gmaps.DirectionsStatus.OVER_QUERY_LIMIT)
//         {
//           await Future.delayed(Duration(milliseconds: 1),()
//           {
//             print("overQuery");
//           });
//         }
//       });
//     });
//
//
// }


//       map.mapTypes.set("3ce9a11b8af23fcf", styledMapType);
//       final dirService = gmaps.DirectionsService();
//       var request = gmaps.DirectionsRequest()
//         ..origin = gmaps.LatLng(12.933496963882442, 77.62314790714224)
//         ..destination = gmaps.LatLng(12.93578619289577, 77.61537586808842)
//         ..travelMode = gmaps.TravelMode.DRIVING;
//  print("availavleSpaces:${element.availableSpaces}");
// for (var element in controller.streets) {
//
//   var request = gmaps.DirectionsRequest()
//     ..origin = element.startLatitude + ',' + element.startLongitude
//     ..destination = element.stopLatitude + ',' + element.stopLongitude
//     ..travelMode = gmaps.TravelMode.DRIVING;
// //  print("availavleSpaces:${element.availableSpaces}");
//   polylineOptions = gmaps.PolylineOptions()
//     ..clickable = false
//     ..visible = false;
//   dirService.route(request, (result, status) async{
//     if (status == gmaps.DirectionsStatus.OK) {
//       timeFactor++;
//       List coordinates = [];
//       // dirRenderer.directions=result;
//
//       for (var element in result.routes[0].overviewPath) {
//         coordinates.add(element);
//       }
//       // print(coordinates);
//       if (element.availableSpaces > 50) {
//         visiblePolylineOptions = gmaps.PolylineOptions()
//           ..map = map
//           ..path = coordinates
//           ..clickable = true
//           ..strokeWeight = 10
//           ..strokeColor = "green"
//           ..strokeOpacity = 0.5;
//       } else {
//         visiblePolylineOptions = gmaps.PolylineOptions()
//           ..map = map
//           ..path = coordinates
//           ..clickable = true
//           ..strokeWeight = 10
//           ..strokeColor = "red"
//           ..strokeOpacity = 0.5;
//       }
//       var polyline = gmaps.Polyline(visiblePolylineOptions);
//
//       polyline.onClick.listen((event) {
//         BookingCard.streetSelected.value = true;
//         map.center=event.latLng;
//         map.zoom=20;
//         // print("529-maps.dart spaces:${element.availableSpaces} ");
//         //print("530-maps.dart spaces:${element.streetName} ");
//         BookingCard.availableParkingSpaces.value =
//             element.availableSpaces.toString();
//         BookingCard.title.value = element.streetName;
//         BookingCard.streetId = element.id;
//         if (controller.bottomSheet == true) {
//           Scaffold.of(context)
//               .showBottomSheet<void>((BuildContext context) {
//             return BookingCard(
//               bottomSheet: true,
//             );
//           });
//         }
//       });
//     }
//     else
//     if(status==gmaps.DirectionsStatus.OVER_QUERY_LIMIT)
//     {
//       await Future.delayed(Duration(milliseconds: 1),()
//       {
//         print("overQuery");
//       });
//     }
//   });
//   // var dirRenderer = gmaps.DirectionsRenderer(
//   //     gmaps.DirectionsRendererOptions()
//   //       ..map = map
//   //       ..suppressMarkers = true..polylineOptions=polylineOptions);
//
//   buildRoute(dirService, request, element, visiblePolylineOptions, map, context);
// }