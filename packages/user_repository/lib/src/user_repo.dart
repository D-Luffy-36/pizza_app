import './models/models.dart';

abstract class UserRepository {
  /// Stream user hiện tại (login/logout)
  Stream<MyUser?> user();

  /// Tạo tài khoản mới và lưu info vào Firestore
  Future<MyUser> signUp(MyUser myUser, String password);

  /// Lưu hoặc update thông tin user
  Future<void> setUserData(MyUser user);

  /// Đăng nhập với email/password
  Future<void> signIn(String email, String password);

  /// Đăng xuất
  Future<void> logOut();
}
