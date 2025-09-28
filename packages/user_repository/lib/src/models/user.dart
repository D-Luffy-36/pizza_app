import '../entities/entities.dart';

class MyUser{
  final String userId;
  final String email;
  final String name;
  final bool hasActiveCart;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  static final empty = MyUser(
    userId: '',
    email: '',
    name: '',
    hasActiveCart: false,
  );

  MyUserEntity toEntity(){
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart,
    );
  }

  static MyUser fromEntity(MyUserEntity entity){
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      hasActiveCart: entity.hasActiveCart,
    );
  }

  // ✅ Hàm copyWith
  MyUser copyWith({
    String? userId,
    String? email,
    String? name,
    bool? hasActiveCart,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      name: name ?? this.name,
      hasActiveCart: hasActiveCart ?? this.hasActiveCart,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActiveCart';
  }

}