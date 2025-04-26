// pages/add_schedule_page.dart
import 'package:flexihome/src/features/app/presentations/controllers/add_schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddSchedulePage extends StatelessWidget {
  final DateTime initialDate;

  AddSchedulePage({required this.initialDate, Key? key}) : super(key: key) {
    final controller = Get.put(AddScheduleController());
    controller.selectedDate.value = initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddScheduleController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Agendamento'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Get.back(),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Título
            TextFormField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'Agendamento:',
                hintText: 'Como se chama o agendamento?',
              ),
            ),
            SizedBox(height: 16),

            // Unidade
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedUnit.value.isEmpty
                      ? null
                      : controller.selectedUnit.value,
                  items: controller.unidades
                      .map((unit) => DropdownMenuItem(
                            value: unit,
                            child: Text(unit),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedUnit.value = val;
                  },
                  decoration: InputDecoration(
                    labelText: 'Unidade:',
                    hintText: 'Selecione uma unidade',
                  ),
                )),
            SizedBox(height: 16),

            // Data
            Obx(() => ListTile(
                  title: Text('Data: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate.value,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) controller.selectedDate.value = picked;
                  },
                )),

            // Hora
            Obx(() => ListTile(
                  title: Text('Horário: ${controller.selectedTime.value.format(context)}'),
                  trailing: Icon(Icons.access_time),
                  onTap: () async {
                    final picked = await showTimePicker(
                      context: context,
                      initialTime: controller.selectedTime.value,
                    );
                    if (picked != null) controller.selectedTime.value = picked;
                  },
                )),
            SizedBox(height: 16),

            // Repetir
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.repeatOption.value.isEmpty ? null : controller.repeatOption.value,
                  items: controller.repeatOptions
                      .map((opt) => DropdownMenuItem(
                            value: opt,
                            child: Text(opt),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) controller.setRepeatOption(val);
                  },
                  decoration: InputDecoration(
                    labelText: 'Repetir:',
                  ),
                )),
            SizedBox(height: 16),

            // Termina (condicional)
            Obx(() {
              if (controller.isSingleDateOnly) return SizedBox.shrink();
              return DropdownButtonFormField<String>(
                value: controller.endOption.value.isEmpty ? null : controller.endOption.value,
                items: controller.endOptions
                    .map((opt) => DropdownMenuItem(
                          value: opt,
                          child: Text(opt),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    controller.setEndOption(val);
                    if (val == 'Na data...') {
                      controller.pickEndDate();
                    }
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Termina:',
                ),
              );
            }),
            SizedBox(height: 16),

            // Mostrar a data de término selecionada, se aplicável
            Obx(() {
              if (controller.isSingleDateOnly || controller.endDate.value == null) {
                return SizedBox.shrink();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Data do término:', style: TextStyle(fontSize: 16)),
                  Text(
                    DateFormat('dd/MM/yyyy').format(controller.endDate.value!),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
            SizedBox(height: 32),

            // Botão Salvar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text('Salvar'),
                onPressed: controller.saveSchedule,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
