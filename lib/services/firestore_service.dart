import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new user document in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toMap());
    } catch (e) {
      throw Exception('Lỗi khi tạo dữ liệu người dùng: $e');
    }
  }

  // Get user data stream
  Stream<UserModel?> getUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromMap(snapshot.data()!, snapshot.id);
      }
      return null;
    });
  }
  
  // Get user data once
  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Lỗi khi lấy dữ liệu người dùng: $e');
    }
  }

  // Update user data (Safe Merge)
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      // Dùng set với merge: true sẽ an toàn tuyệt đối. 
      // Nếu doc chưa có, nó sẽ tạo mới. Nếu đã có, nó sẽ chỉ update các field trong data.
      await _firestore.collection('users').doc(uid).set(data, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Lỗi khi cập nhật dữ liệu: $e');
    }
  }

  // Save image locally and return the file name
  Future<String> saveImageLocally(String uid, File imageFile, bool isProfileImage) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String prefix = isProfileImage ? 'avatar' : 'bg';
      String extension = imageFile.path.split('.').last;
      String fileName = '${prefix}_$uid.${extension == 'jpg' || extension == 'jpeg' || extension == 'png' ? extension : 'jpg'}';
      
      String localPath = '${directory.path}/$fileName';
      await imageFile.copy(localPath);
      return fileName;
    } catch (e) {
      throw Exception('Lỗi khi lưu ảnh: $e');
    }
  }

  // Get full local path from file name
  Future<String> getLocalImagePath(String fileName) async {
    if (fileName.isEmpty) return '';
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }
}
