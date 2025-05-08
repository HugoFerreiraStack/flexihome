// pages/add_schedule_page.dart
import 'package:flexihome/src/config/themes/app_colors.dart';
import 'package:flexihome/src/features/app/domain/entities/agendamento_type_enum.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';
import 'package:flexihome/src/features/app/presentations/controllers/add_schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddSchedulePage extends StatelessWidget {
  final DateTime initialDate;

  AddSchedulePage({required this.initialDate, super.key}) {
    final controller = Get.put(AddScheduleController());
    controller.selectedDate.value = initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddScheduleController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Novo Agendamento'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              controller.resetFields();
              Get.back();
            },
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColors.tertiary,
          AppColors.primary,
          AppColors.secondary
        ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Obx(() => DropdownButtonFormField<AgendamentoTypeEnum>(
                    dropdownColor: AppColors.primary,
                    decoration: InputDecoration(
                      labelText: 'Tipo de agendamento',
                      labelStyle: TextStyle(color: Colors.white),
                      iconColor: Colors.white,
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint: Text(
                      'Qual o tipo de agendamento?',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    value: controller.typeEvent,
                    items: AgendamentoTypeEnum.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.description,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (AgendamentoTypeEnum? newValue) {
                      controller.typeEvent = newValue;
                    },
                  )),
              SizedBox(height: 16),
              Obx(() => DropdownButtonFormField<Condominio>(
                    dropdownColor: AppColors.primary,
                    decoration: InputDecoration(
                      labelText: 'Condominio',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint: Text(
                      'Selecione o condominio',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    value: controller.selectedCondominium,
                    items: controller.condominiums
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.nome!,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (Condominio? newValue) {
                      controller.selectedCondominium = newValue;
                      controller.getUnitsByCondominium(newValue!.id!);
                    },
                  )),

              SizedBox(height: 16),
              Obx(() => DropdownButtonFormField<Unidade>(
                    dropdownColor: AppColors.primary,
                    decoration: InputDecoration(
                      labelText: 'Unidade',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint: Text(
                      'Selecione o apartamento',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    value: controller.selectedUnit,
                    items: controller.unitys
                        .map(
                          (e) => DropdownMenuItem<Unidade>(
                            value: e,
                            child: Text(
                              e.numberAp ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (Unidade? newValue) {
                      controller.selectedUnit = newValue;
                    },
                  )),
              SizedBox(height: 16),

              // Data
              Obx(() => ListTile(
                    title: Text(
                      'Data: ${DateFormat('dd/MM/yyyy').format(controller.selectedDate.value)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      final now = DateTime.now();
                      final initialDate =
                          controller.selectedDate.value.isBefore(now)
                              ? now
                              : controller.selectedDate.value;

                      final picked = await showDatePicker(
                        locale: const Locale('pt', 'BR'),
                        context: context,
                        initialDate: initialDate,
                        firstDate: now,
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        controller.selectedDate.value = picked;
                        controller.buildRepeatOptions();
                      }
                    },
                  )),

              // Hora
              Obx(() => ListTile(
                    title: Text(
                      'Horário: ${controller.selectedTime.value.format(context)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Icon(
                      Icons.access_time,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: controller.selectedTime.value,
                      );
                      if (picked != null) {
                        controller.selectedTime.value = picked;
                      }
                    },
                  )),
              SizedBox(height: 16),

              // Repetir
              Obx(() => DropdownButtonFormField<String>(
                    dropdownColor: AppColors.primary,
                    decoration: InputDecoration(
                      labelText: 'Repertir',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint:
                        Text('Repetir', style: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                    value: controller.repeatOption.value.isEmpty
                        ? null
                        : controller.repeatOption.value,
                    items: controller.repeatOptions
                        .map((opt) => DropdownMenuItem(
                              value: opt,
                              child: Text(opt),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.setRepeatOption(val);
                    },
                  )),
              SizedBox(height: 16),

              // Termina (condicional)
              Obx(() {
                if (controller.isSingleDateOnly) return SizedBox.shrink();
                return DropdownButtonFormField<String>(
                  dropdownColor: AppColors.primary,
                  decoration: InputDecoration(
                    labelText: 'Termina',
                    labelStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  hint: Text('Termina:', style: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  value: controller.endOption.value.isEmpty
                      ? null
                      : controller.endOption.value,
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
                );
              }),
              SizedBox(height: 16),

              // Mostrar a data de término selecionada, se aplicável
              Obx(() {
                if (controller.isSingleDateOnly ||
                    controller.endDate.value == null) {
                  return SizedBox.shrink();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Data do término:', style: TextStyle(fontSize: 16)),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(controller.endDate.value!),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
      ),
    );
  }
}
