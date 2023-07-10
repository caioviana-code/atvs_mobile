import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/controller/auth_store.dart';

import '../../domain/tool_entity.dart';
import '../../domain/tool_mapper.dart';
import '../../domain/tool_services_interfaces/tool_service.dart';

class ToolFirestoreServiceImpl implements ToolService {
  final FirebaseFirestore firestore;

  ToolFirestoreServiceImpl(this.firestore, this.authStore);
  final AuthStore authStore; 

  @override
  Future<void> createTool(ToolEntity tool) async {
    final collectionRef = firestore.collection('tools').doc(tool.tId);
    await collectionRef.set(ToolMapper.entityToMap(tool));
  }

  @override
  Future<void> deleteTool(String tId) async {
    final documentRef = firestore.collection('tools').doc(tId);
    await documentRef.delete().then(
          (doc) => print("Document deleted "),
          onError: (e) => print("Error updating document $e"),
        );
  }

  @override
  Future<ToolEntity?> getToolById(String tId) async {
    final documentSnapshot = await firestore.collection('tools').doc(tId).get();

    if (documentSnapshot.exists) {
      final map = documentSnapshot.data();
      if (map != null) {
        return ToolMapper.mapToEntity(map);
      }
    }

    return null;
  }

  @override
  Future<void> updateTool(ToolEntity tool) async {
    final documentRef = firestore.collection('tools').doc(tool.tId);
    await documentRef.set(ToolMapper.entityToMap(tool));
  }

  @override
  Future<List<ToolEntity>> getToolList() async {
    final String? userId = authStore.getCurrentUserId(); 

    final querySnapshot = await firestore
        .collection('tools')
        .where('userId', isEqualTo: userId) 
        .get();

    final tools = querySnapshot.docs.map((doc) {
      final map = doc.data();
      return ToolMapper.mapToEntity(map);
    }).toList();

    return tools;
  }
}
