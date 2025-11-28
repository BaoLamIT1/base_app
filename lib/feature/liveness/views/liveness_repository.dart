// import '../../../core/values/api_url.dart';
// import '../model/live_ness_model.dart';
//
// class LivenessRepository extends BaseRepository {
//   LivenessRepository(super.controller);
//
//   Future<SendImageResponse?> sendImageLive(
//     String pathImage /*List<Uint8List> list*/,
//   ) async {
//     String customer = "customer";
//     // final formData = FormData();
//     /*    formData.fields.add(MapEntry(
//       'customer',
//       'customer',
//     ));*/
//     /*    for (int i = 0; i < list.length; i++) {
//       formData.files.add(MapEntry(
//         'userImg',
//         MultipartFile.fromBytes(
//           list[i],
//           filename: "Image$i.jpg",
//           contentType: MediaType(
//             'image',
//             'jpg',
//           ), // Replace with actual file type
//         ),
//       ));
//     }*/
//     FormData formData = FormData.fromMap({
//       'userImg': await MultipartFile.fromFile(pathImage),
//     });
//     var response = await baseSendRequest(
//       "${ApiUrl.urlSendImage}?customer=$customer",
//       RequestMethod.POST,
//       jsonMap: formData,
//     );
//
//     SendImageResponse frontCardResponse = SendImageResponse.fromJson(response);
//     return frontCardResponse;
//   }
// }
