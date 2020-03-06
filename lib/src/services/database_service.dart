import 'package:seemur/src/providers/user_model_provider.dart';
import 'package:seemur/src/utilities/constants.dart';

class DatabaseService {
  static void updateUsuario(Usuario usuario) {
    usersRef.document(usuario.uid).updateData(
        {'imagen': usuario.profileImageUrl});
  }
}