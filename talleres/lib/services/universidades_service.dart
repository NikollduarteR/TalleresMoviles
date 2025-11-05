import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidades_fb.dart';

class UniversidadService {
  static final _ref = FirebaseFirestore.instance.collection('universidades');

  /// 🔹 Obtener todas las universidades en tiempo real
  static Stream<List<UniversidadFb>> watchUniversidades() {
    return _ref.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => UniversidadFb.fromMap(doc.id, doc.data()))
          .toList();
    });
  }

  /// 🔹 Obtener una universidad por su ID en tiempo real
  static Stream<UniversidadFb?> watchUniversidadById(String id) {
    return _ref.doc(id).snapshots().map((doc) {
      if (doc.exists) {
        return UniversidadFb.fromMap(doc.id, doc.data()!);
      }
      return null;
    });
  }

  /// 🔹 Agregar una universidad
  static Future<void> addUniversidad(UniversidadFb universidad) async {
    await _ref.add(universidad.toMap());
  }

  /// 🔹 Actualizar universidad por ID
  static Future<void> updateUniversidad(
    String id,
    UniversidadFb universidad,
  ) async {
    await _ref.doc(id).update(universidad.toMap());
  }

  /// 🔹 Eliminar universidad
  static Future<void> deleteUniversidad(String id) async {
    await _ref.doc(id).delete();
  }

  /// 🔹 Obtener todas las universidades (solo una vez)
  static Future<List<UniversidadFb>> getUniversidades() async {
    final snapshot = await _ref.get();
    return snapshot.docs
        .map((doc) => UniversidadFb.fromMap(doc.id, doc.data()))
        .toList();
  }

  /// 🔹 Obtener una universidad por ID (solo una vez)
  static Future<UniversidadFb?> getUniversidadById(String id) async {
    final doc = await _ref.doc(id).get();
    if (doc.exists) {
      return UniversidadFb.fromMap(doc.id, doc.data()!);
    }
    return null;
  }
}
