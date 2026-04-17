import '../../../data/repository/app_repository.dart';

class LoginRepository {
  final AppRepository repo;

  LoginRepository(this.repo);

  Future login(data) async {
    return await repo.login(data);
  }
}
