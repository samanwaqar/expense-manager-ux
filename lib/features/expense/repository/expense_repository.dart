import '../../../core/network/api_service.dart';
import '../../../core/network/request_attr.dart';
import '../../../core/constants/url_constants.dart';
import '../../../core/enum/http_methods.dart';

class ExpenseRepository {

  Future addExpense(Map<String, dynamic> data) async {
    print(" ADD EXPENSE API: $data");

    final response = await ApiService.request(
      RequestAttr(
        url: UrlConstants.addExpense,
        method: HttpMethod.POST,
        body: data,
      ),
    );

    print(" ADD EXPENSE RESPONSE: ${response.data}");
    return response;
  }

  Future getExpenses() async {
    print(" GET EXPENSES API");

    final response = await ApiService.request(
      RequestAttr(
        url: UrlConstants.getExpenses,
        method: HttpMethod.GET,
      ),
    );

    print(" EXPENSES: ${response.data}");
    return response;
  }

  Future updateExpense(int id, Map<String, dynamic> data) async {
    print(" UPDATE EXPENSE ID=$id DATA=$data");

    final response = await ApiService.request(
      RequestAttr(
        url: "${UrlConstants.updateExpense}$id",
        method: HttpMethod.PUT,
        body: data,
      ),
    );

    print(" UPDATE RESPONSE: ${response.data}");
    return response;
  }

  Future deleteExpense(int id) async {
    print(" DELETE EXPENSE ID=$id");

    final response = await ApiService.request(
      RequestAttr(
        url: "${UrlConstants.deleteExpense}$id",
        method: HttpMethod.DELETE,
      ),
    );

    print(" DELETE RESPONSE: ${response.data}");
    return response;
  }
}
