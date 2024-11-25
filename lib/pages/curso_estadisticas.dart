import 'package:flutter/material.dart';
import '../utils/curso_calculos.dart';

class CourseStatsScreen extends StatefulWidget {
  @override
  _CourseStatsScreenState createState() => _CourseStatsScreenState();
}

class _CourseStatsScreenState extends State<CourseStatsScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  List<Participant> _participants = [];
  String _resultMessage = '';

  void _addParticipant() {
    final height = double.tryParse(_heightController.text);
    final age = int.tryParse(_ageController.text);
    final gender = _genderController.text.trim().toUpperCase();

    if (height == null || age == null || !(gender == 'M' || gender == 'F')) {
      setState(() {
        _resultMessage = 'Datos inválidos. Verifica los campos.';
      });
      return;
    }

    if (height < 0) {
      setState(() {
        _resultMessage = CursoCalculos.calcularResultados(_participants);
      });
      return;
    }

    setState(() {
      _participants.add(Participant(height: height, age: age, gender: gender));
      _heightController.clear();
      _ageController.clear();
      _genderController.clear();
      _resultMessage = 'Participante agregado. Ingresa otro o termina.';
    });
  }

  void _resetData() {
    setState(() {
      _participants.clear();
      _heightController.clear();
      _ageController.clear();
      _genderController.clear();
      _resultMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Estadísticas del Curso',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue.shade200, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInputField('Altura (cm)', _heightController),
                SizedBox(height: 10),
                _buildInputField('Edad', _ageController),
                SizedBox(height: 10),
                _buildInputField('Sexo (M/F)', _genderController),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addParticipant,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Agregar Participante',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _resetData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Reiniciar',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _resultMessage,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: label.contains('Altura') || label.contains('Edad')
          ? TextInputType.number
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
