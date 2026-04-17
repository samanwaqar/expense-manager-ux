import '../../core/enum/http_methods.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_service.dart';
import '../../core/network/request_attr.dart';
import '../../core/constants/url_constants.dart';

class RemoteDataSource {
  final ApiClient apiClient;

  RemoteDataSource(this.apiClient);
  //  AUTH
  Future login(Map<String, dynamic> data) async {
    return await ApiService.request(
      RequestAttr(
        url: UrlConstants.login,
        method: HttpMethod.POST,
        body: data,
      ),
    );
  }

  Future signup(Map<String, dynamic> data) async {
    return await ApiService.request(
      RequestAttr(
        url: UrlConstants.signup,
        method: HttpMethod.POST,
        body: data,
      ),
    );
  }

  //  EXPENSE
  Future addExpense(Map<String, dynamic> data) async {
    return await ApiService.request(
      RequestAttr(
        url: UrlConstants.addExpense,
        method: HttpMethod.POST,
        body: data,
      ),
    );
  }

  Future getExpenses() async {
    return await ApiService.request(
      RequestAttr(
        url: UrlConstants.getExpenses,
        method: HttpMethod.GET,
      ),
    );
  }

  Future updateExpense(int id, Map<String, dynamic> data) async {
    return await ApiService.request(
      RequestAttr(
        url: "${UrlConstants.updateExpense}$id",
        method: HttpMethod.PUT,
        body: data,
      ),
    );
  }

  Future deleteExpense(int id) async {
    return await ApiService.request(
      RequestAttr(
        url: "${UrlConstants.deleteExpense}$id",
        method: HttpMethod.DELETE,
      ),
    );
  }

  // 📊 DASHBOARD
  Future dashboard() async {
    return await ApiService.request(
      RequestAttr(
        url: UrlConstants.dashboard,
        method: HttpMethod.GET,
      ),
    );
  }

  Future monthlyReport() async {
    return await ApiService.request(
      RequestAttr(
        url: UrlConstants.monthlyReport,
        method: HttpMethod.GET,
      ),
    );
  }
}
