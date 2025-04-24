// add_schedule.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/add_schedule_controller.dart';

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
        title: Text('Adicione um agendamento'),
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
            TextFormField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: 'Agendamento',
                hintText: 'O que você está agendando?',
              ),
            ),
            SizedBox(height: 16),
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
                  decoration: InputDecoration(labelText: 'Unidades'),
                )),
            SizedBox(height: 16),
            Obx(() => ListTile(
                  title: Text('Data: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}'),
                  trailing: Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate.value,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (picked != null) controller.selectedDate.value = picked;
                  },
                )),
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
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.repeatOption.value,
                  onChanged: (val) {
                    if (val != null) controller.setRepeatOption(val);
                  },
                  items: controller.repeatOptions
                      .map((opt) => DropdownMenuItem(
                            value: opt,
                            child: Text(opt),
                          ))
                      .toList(),
                  decoration: InputDecoration(labelText: 'Repetir'),
                )),
            Obx(() {
              if (controller.repeatOption.value == 'Mensalmente') {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      value: controller.repeatInterval.value,
                      onChanged: (val) {
                        if (val != null) controller.repeatInterval.value = val;
                      },
                      items: List.generate(12, (i) => i + 1)
                          .map((val) => DropdownMenuItem(
                                value: val,
                                child: Text('A cada $val mês(es)'),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                          labelText: 'Intervalo de repetição (mensal)'),
                    ),
                  ],
                );
              }
              return SizedBox();
            }),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text('Salvar'),
                onPressed: controller.saveSchedule,
              ),
            )
          ],
        ),
      ),
    );
  }
}