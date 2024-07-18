import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService{

  static DatabaseService instance = DatabaseService();

  late FirebaseFirestore _db;

  DatabaseService(){
    _db = FirebaseFirestore.instance;
  }
  final String _userCollection = "users";
  Future<void> createUserInDb(String uid, String name, String email, String imageURL) async {
    try{
      return await _db.collection(_userCollection).doc(uid).set({
        "name":name,
        "email":email,
        "image":imageURL,
        "lastSeen":DateTime.now().toUtc(),
      });
    }catch(e){
      print(e);
    }
  }
}