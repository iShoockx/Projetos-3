// // Usando mocks, você simula o comportamento desses serviços (Firestore e do UserCache) sem precisar de rede, 
// // banco real ou dados de usuário de verdade.

// // flutter pub run build_runner build (Depois de criar esse arquivo, 
// // você precisa gerar os arquivos de mock rodando no terminal)

// // import 'mocks.mocks.dart'; (Depois você só importa ele nos seus testes)

// // Conteudo desse arquivo

// import 'package:mockito/annotations.dart';
// import 'package:projetos_3/services/lembrete.dart';
// import 'package:projetos_3/cache/user_cache.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// @GenerateMocks([
//   LembreteService,
//   UserCache,
//   FirebaseFirestore,
//   CollectionReference,
//   DocumentReference,
//   QuerySnapshot,
//   QueryDocumentSnapshot
// ])
// void main() {}


 