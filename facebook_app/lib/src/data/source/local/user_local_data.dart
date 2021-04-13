import 'package:facebook_app/src/data/model/user.dart';
import 'package:facebook_app/src/ultils/constants.dart';
import 'package:facebook_app/src/ultils/share_prefs.dart';

class UserLocalDatasource {
  final SpUtil _spUtil;

  UserLocalDatasource(this._spUtil);

  setSaveLogin() {
    _spUtil.putBool(KEY_SAVE_LOGIN, true);
  }

  bool getSaveLogin() {
    var check = _spUtil.getBool(KEY_SAVE_LOGIN);
    _spUtil.getDynamic(KEY_SAVE_LOGIN);
    if (check == null || !check) return false;
    return check;
  }

  UserEntity getCurrentUserLocal() {
    UserEntity userEntity;
    userEntity.birthday = _spUtil.getString(KEY_CURRENT_USER_BIRTHDAY);
    userEntity.email = _spUtil.getString(KEY_CURRENT_USER_EMAIL);
    userEntity.firstName = _spUtil.getString(KEY_CURRENT_USER_FIRST_NAME);
    userEntity.lastName = _spUtil.getString(KEY_CURRENT_USER_LAST_NAME);
    userEntity.genre = _spUtil.getString(KEY_CURRENT_USER_GENRE);
    userEntity.id = _spUtil.getString(KEY_CURRENT_USER_ID);
    userEntity.password = _spUtil.getString(KEY_CURRENT_USER_PASSWORD);
    userEntity.avatar = _spUtil.getString(KEY_CURRENT_USER_AVATAR);
    userEntity.phone = _spUtil.getString(KEY_CURRENT_USER_PHONE);
    return userEntity;
  }

  Future<void> setCurrentUser(UserEntity userEntity) {
    _spUtil.putString(KEY_CURRENT_USER_BIRTHDAY, userEntity.birthday);
    _spUtil.putString(KEY_CURRENT_USER_EMAIL, userEntity.email);
    _spUtil.putString(KEY_CURRENT_USER_FIRST_NAME, userEntity.firstName);
    _spUtil.putString(KEY_CURRENT_USER_LAST_NAME, userEntity.lastName);
    _spUtil.putString(KEY_CURRENT_USER_GENRE, userEntity.genre);
    _spUtil.putString(KEY_CURRENT_USER_ID, userEntity.id);
    _spUtil.putString(KEY_CURRENT_USER_PASSWORD, userEntity.password);
    _spUtil.putString(KEY_CURRENT_USER_AVATAR, userEntity.avatar);
    return _spUtil.putString(KEY_CURRENT_USER_PHONE, userEntity.phone);
  }

  void clearUser() {
    _spUtil.putString(KEY_CURRENT_USER_BIRTHDAY, "");
    _spUtil.putString(KEY_CURRENT_USER_EMAIL, "");
    _spUtil.putString(KEY_CURRENT_USER_FIRST_NAME, "");
    _spUtil.putString(KEY_CURRENT_USER_LAST_NAME, "");
    _spUtil.putString(KEY_CURRENT_USER_GENRE, "");
    _spUtil.putString(KEY_CURRENT_USER_ID, "");
    _spUtil.putString(KEY_CURRENT_USER_PASSWORD, "");
    _spUtil.putString(KEY_CURRENT_USER_AVATAR, "");
    _spUtil.putString(KEY_CURRENT_USER_PHONE, "");
    _spUtil.putBool(KEY_SAVE_LOGIN, false);
  }
}
