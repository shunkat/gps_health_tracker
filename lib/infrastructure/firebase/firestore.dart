import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInfra {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ドキュメントの作成
  Future<void> createDocument(String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).set(data);
      print("Document created with ID: $docId");
    } on FirebaseException catch (e) {
      print("Failed to create document: ${e.message}");
    }
  }

  // ドキュメントの読み取り
  Future<DocumentSnapshot> getDocument(String collectionPath, String docId) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore.collection(collectionPath).doc(docId).get();
      if (docSnapshot.exists) {
        print("Document data: ${docSnapshot.data()}");
      } else {
        print("No document found with ID: $docId");
      }
      return docSnapshot;
    } on FirebaseException catch (e) {
      print("Failed to get document: ${e.message}");
      rethrow;
    }
  }

  // ドキュメントの更新
  Future<void> updateDocument(String collectionPath, String docId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).update(updatedData);
      print("Document updated with ID: $docId");
    } on FirebaseException catch (e) {
      print("Failed to update document: ${e.message}");
    }
  }

  // ドキュメントの削除
  Future<void> deleteDocument(String collectionPath, String docId) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
      print("Document deleted with ID: $docId");
    } on FirebaseException catch (e) {
      print("Failed to delete document: ${e.message}");
    }
  }

  // コレクション全体のデータを取得
  Future<QuerySnapshot> getCollection(String collectionPath) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collectionPath).get();
      print("Fetched ${querySnapshot.docs.length} documents from $collectionPath collection.");
      return querySnapshot;
    } on FirebaseException catch (e) {
      print("Failed to fetch collection: ${e.message}");
      rethrow;
    }
  }
}
