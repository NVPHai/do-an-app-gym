import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign in with Email and Password
  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Đã xảy ra lỗi không xác định.');
    }
  }

  // Register with Email and Password
  Future<UserCredential?> registerWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Đã xảy ra lỗi không xác định.');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Đã xảy ra lỗi không xác định.');
    }
  }

  // Handle Firebase Auth Exceptions
  Exception _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('Không tìm thấy tài khoản với email này.');
      case 'wrong-password':
        return Exception('Sai mật khẩu.');
      case 'invalid-email':
        return Exception('Email không hợp lệ.');
      case 'user-disabled':
        return Exception('Tài khoản đã bị vô hiệu hóa.');
      case 'email-already-in-use':
        return Exception('Email đã được sử dụng bởi một tài khoản khác.');
      case 'operation-not-allowed':
        return Exception('Đăng nhập bằng email/mật khẩu chưa được kích hoạt.');
      case 'weak-password':
        return Exception('Mật khẩu quá yếu. Vui lòng chọn mật khẩu mạnh hơn.');
      case 'invalid-credential':
        return Exception('Thông tin đăng nhập không chính xác.');
      default:
        return Exception(e.message ?? 'Đã xảy ra lỗi xác thực.');
    }
  }
}
