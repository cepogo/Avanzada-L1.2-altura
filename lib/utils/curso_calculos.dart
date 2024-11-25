class Participant {
  final double height;
  final int age;
  final String gender;

  Participant({required this.height, required this.age, required this.gender});
}

class CursoCalculos {
  static String calcularResultados(List<Participant> participants) {
    if (participants.isEmpty) return 'No se ingresaron participantes.';

    double totalHeightM = 0, totalHeightF = 0;
    int countM = 0, countF = 0, totalAge = 0;

    for (var p in participants) {
      totalAge += p.age;
      if (p.gender == 'M') {
        totalHeightM += p.height;
        countM++;
      } else if (p.gender == 'F') {
        totalHeightF += p.height;
        countF++;
      }
    }

    final avgHeightM = countM > 0 ? (totalHeightM / countM).toStringAsFixed(2) : 'N/A';
    final avgHeightF = countF > 0 ? (totalHeightF / countF).toStringAsFixed(2) : 'N/A';
    final avgAge = participants.isNotEmpty
        ? (totalAge / participants.length).toStringAsFixed(2)
        : 'N/A';

    return '''
Promedio de altura (Hombres): $avgHeightM cm
Promedio de altura (Mujeres): $avgHeightF cm
Promedio de edad: $avgAge años
''';
  }
}
