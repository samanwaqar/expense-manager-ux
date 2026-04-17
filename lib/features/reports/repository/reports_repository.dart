import '../../../core/network/api_service.dart';
import '../../../core/network/request_attr.dart';
import '../../../core/constants/url_constants.dart';
import '../../../core/enum/http_methods.dart';

class ReportsRepository {

  Future monthlyReport() async {
    try {
      print(" CALLING MONTHLY REPORT API...");

      final response = await ApiService.request(
        RequestAttr(
          url: UrlConstants.monthlyReport,
          method: HttpMethod.GET,
        ),
      );

      print(" REPORT RESPONSE: ${response.data}");
      return response;

    } catch (e) {
      print("REPOSITORY ERROR: $e");
      rethrow;
    }
  }
}
