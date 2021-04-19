class UserEntity {
  String id = '-1';
  String firstName = '';
  String lastName = '';
  String avatar = " ";
  String coverImage = " ";
  String email = '';
  String phone = '';
  String birthday = '';
  String password = '';
  String genre = '';
  String city = '';
  String description = '';

  UserEntity.origin();

  UserEntity(this.id, this.firstName, this.lastName, this.avatar, this.birthday,
      this.email, this.phone, this.password, this.genre);

  UserEntity.fromJson(Map map) {
    this.id = map['id'];
    this.firstName = map['first_name'];
    this.lastName = map['last_name'];
    this.avatar = map['avatar'];
    this.coverImage = map['cover_image'];
    this.birthday = map['birthday'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.password = map['password'];
    this.genre = map['genre'];
    this.city = map['city'];
    this.description = map['description'];
  }

  Map userToMap() => new Map<String, dynamic>.from({
        "id": this.id,
        "first_name": this.firstName,
        "last_name": this.lastName,
        "avatar": this.avatar,
        "cover_image": this.coverImage,
        "email": this.email,
        "phone": this.phone,
        "password": this.password,
        "birthday": this.birthday,
        "genre": this.genre,
        "city": this.city,
        "description": this.description
      });

  static List<Map> userToListMap(List<UserEntity> users) {
    List<Map> usersMap = [];
    users.forEach((UserEntity user) {
      Map step = user.userToMap();
      usersMap.add(step);
    });
    return usersMap;
  }

  static List<UserEntity> fromListMap(List<Map> maps) {
    List<UserEntity> users = [];
    maps.forEach((element) {
      users.add(UserEntity.fromJson(element));
    });
    return users;
  }
}
