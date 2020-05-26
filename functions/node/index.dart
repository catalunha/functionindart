// import 'package:firebase_functions_interop/firebase_functions_interop.dart';
// void main() {
//  functions['moin'] = functions
//    .region('us-central1')
//    .https.onRequest(greet);
// }
// void greet(ExpressHttpRequest request) {
//  request.response
//  ..writeln('Moin, moin!')
//  ..close();
// }
import 'package:firebase_functions_interop/firebase_functions_interop.dart';

void helloWorld(ExpressHttpRequest request) {
  request.response.writeln('Hello world...');
  request.response.close();
}

Future<void> createHook(DocumentSnapshot snapshot, EventContext context) async {
  final name = snapshot.data.getString('name');
  print(name);
  final data = DocumentData.fromMap({'name': name});
  await snapshot.firestore.collection('/bar').add(data);
}

void main() {
  functions['helloWorld'] = functions.https.onRequest(helloWorld);
  functions['foo'] = functions
      // .region('europe-west3')
      .firestore
      .document('/foo/{id}')
      .onCreate(createHook);
}
