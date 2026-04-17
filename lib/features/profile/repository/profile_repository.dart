import '../../../core/constants/url_constants.dart';
import '../../../core/enum/http_methods.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/request_attr.dart';

class ProfileRepository {

  // GET PROFILE FROM BACKEND
  Future getProfile() async {
    final res = await ApiService.request(
      RequestAttr(
        url: UrlConstants.profile,
        method: HttpMethod.GET,
      ),
    );

    return res.data;
  }

  // UPDATE PROFILE
  Future updateProfile(Map<String, dynamic> data) async {
    final res = await ApiService.request(
      RequestAttr(
        url: UrlConstants.updateProfile,
        method: HttpMethod.PUT,
        body: data,
      ),
    );

    return res.data;
  }
}
