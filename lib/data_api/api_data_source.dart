import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadUsers() {
    return BaseNetwork.get("");
  }

  Future<Map<String, dynamic>> loadDetailWeapons(int idDiterima){
    String uuid = idDiterima.toString();
    return BaseNetwork.get("$uuid");
  }
}
