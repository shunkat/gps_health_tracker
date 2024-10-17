import '../entity/user.dart';
import '../../infrastructure/firebase/firestore.dart';
import '../../infrastructure/device/device_id.dart';

class UserRepository {
  Future<void> registerUser(String nickName, String uid) async {
    try {
      final deviceId = await DeviceId().getDeviceId();
      final user = User(nickName: nickName, uid: uid, deviceId: deviceId);
      await saveUser(user);
    }
    catch (e) {
      throw Exception('Error registering user: $e');
    }
  }

  Future<void> saveUser(User user) async {
    try {
      await FirestoreInfra().createDocument("Users", user.uid , user.toJson());
    } catch (e) {
      throw Exception('Error saving user: $e');
    }
  }
}