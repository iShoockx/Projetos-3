import 'package:shared_preferences/shared_preferences.dart';

/// Classe para armazenar o usuário cadastrado no aplicativo salvando o seu ID
class UserCache {
  static const _key = 'user_uid';

  /// Função que salva o ID do usuário no momento do login
  static Future<void> saveUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, uid);
  }

  /// Função que resgata o ID armazenado
  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

 /// Função que apaga o ID do usuário para logout 
  static Future<void> clearUid() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
