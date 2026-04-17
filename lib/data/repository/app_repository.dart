import '../remote/remote_data_source.dart';

class AppRepository {
  final RemoteDataSource remote;

  AppRepository(this.remote);

  // AUTH
  Future login(data) => remote.login(data);
  Future signup(data) => remote.signup(data);

  // EXPENSE
  Future addExpense(data) => remote.addExpense(data);
  Future getExpenses() => remote.getExpenses();
  Future updateExpense(id, data) => remote.updateExpense(id, data);
  Future deleteExpense(id) => remote.deleteExpense(id);

  // DASHBOARD
  Future dashboard() => remote.dashboard();
  Future monthlyReport() => remote.monthlyReport();
}
