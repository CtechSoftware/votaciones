class Partido {
  final String id;
  final String nombre;
  final int votos;

  Partido({required this.id, required this.nombre, required this.votos});

  factory Partido.fromMap(Map<String, dynamic> data, String documentId) {
    return Partido(
      id: documentId,
      nombre: data['nombre'] ?? '',
      votos: data['votos'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'nombre': nombre, 'votos': votos};
  }
}
