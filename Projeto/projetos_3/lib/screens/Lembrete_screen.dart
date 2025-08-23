import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/widgets/appbar.dart';
import 'package:projetos_3/services/lembrete.dart';
import 'package:projetos_3/widgets/navbar.dart';

class LembreteScreen extends StatefulWidget {
  const LembreteScreen({super.key});

  @override
  State<LembreteScreen> createState() => _LembreteScreenState();
}

class _LembreteScreenState extends State<LembreteScreen> {
  final TextEditingController _tituloController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isImportant = false;
  final TextEditingController _descricaoController = TextEditingController();

  final LembreteService _lembreteService = LembreteService();

  DateTime? get _selectedDateTime {
    if (_selectedDate == null || _selectedTime == null) return null;
    return DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: "Título do lembrete",
                ),
              ),
              SizedBox(height: 20.h),
        
              TextField(
                controller: _descricaoController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Descrição",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.h),
        
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    setState(() {
                      _selectedDate = date;
                    });
                  }
                },
                child: Text(
                  _selectedDate == null
                      ? "Escolher data"
                      : "Data: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                ),
              ),
              SizedBox(height: 10.h),
        
              ElevatedButton(
                onPressed: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _selectedTime = time;
                    });
                  }
                },
                child: Text(
                  _selectedTime == null
                      ? "Escolher hora"
                      : "Hora: ${_selectedTime!.hour}:${_selectedTime!.minute.toString().padLeft(2, '0')}",
                ),
              ),
              SizedBox(height: 30.h),
        
              Row(
                children: [
                  Checkbox(
                    value: _isImportant,
                    onChanged: (bool? value) {
                      setState(() {
                        _isImportant = value ?? false;
                      });
                    },
                  ),
                  const Text("Importante"),
                ],
              ),
        
              SizedBox(height: 30.h),
        
              ElevatedButton(
                onPressed: () async {
                  final titulo = _tituloController.text.trim();
                  final dataHora = _selectedDateTime;
                  final descricao = _descricaoController.text.trim();
        
                  if (titulo.isEmpty || dataHora == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Preencha título, data e hora"),
                      ),
                    );
                    return;
                  }
        
                  try {
                    await _lembreteService.adicionarLembrete(
                      titulo,
                      descricao,
                      dataHora,
                      _isImportant,
                    );
        
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lembrete salvo com sucesso!"),
                      ),
                    );
        
                    _tituloController.clear();
                    setState(() {
                      _selectedDate = null;
                      _selectedTime = null;
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erro ao salvar lembrete: $e")),
                    );
                  }
                },
                child: const Text("Salvar lembrete"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(currentRoute: "/Lembrete"),
    );
  }
}
