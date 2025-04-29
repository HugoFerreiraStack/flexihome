// controllers/add_schedule_controller.dart
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flexihome/src/core/extensions/constants.dart';
import 'package:flexihome/src/core/services/auth/auth_service.dart';
import 'package:flexihome/src/features/app/domain/entities/agendamento_type_enum.dart';
import 'package:flexihome/src/features/app/domain/entities/condominio.dart';
import 'package:flexihome/src/features/app/domain/entities/unidade.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/event.dart';
import 'calendar_controller.dart';
import '../widgets/error_dialog.dart';
import '../widgets/end_date_dialog.dart';

class AddScheduleController extends GetxController {
  static AddScheduleController get to => Get.find();

  final Rxn<AgendamentoTypeEnum> _typeEvente = Rxn<AgendamentoTypeEnum>();
  AgendamentoTypeEnum? get typeEvent => _typeEvente.value;
  set typeEvent(AgendamentoTypeEnum? value) => _typeEvente.value = value;

  final _condominiums = <Condominio>[].obs;
  List<Condominio> get condominiums => _condominiums;
  set condominiums(List<Condominio> value) => _condominiums.value = value;

  final Rxn<Condominio> _selectedCondominium = Rxn<Condominio>();
  Condominio? get selectedCondominium => _selectedCondominium.value;
  set selectedCondominium(Condominio? value) =>
      _selectedCondominium.value = value;

  final _unitys = <Unidade>[].obs;
  List<Unidade> get unitys => _unitys;
  set unitys(List<Unidade> value) => _unitys.value = value;

  final Rxn<Unidade> _selectedUnit = Rxn<Unidade>();
  Unidade? get selectedUnit => _selectedUnit.value;
  set selectedUnit(Unidade? value) => _selectedUnit.value = value;

  final _eventos = <Event>[].obs;
  List<Event> get eventos => _eventos;
  set eventos(List<Event> value) => _eventos.value = value;

  final selectedDate = DateTime.now().obs;
  final selectedTime = TimeOfDay.now().obs;
  final repeatOption = ''.obs;
  final endOption = ''.obs;
  final endDate = Rxn<DateTime>();

  final List<String> endOptions = ['Nunca', 'Na data...'];

  final repeatOptions = <String>[].obs;
  bool get isSingleDateOnly => repeatOption.value.startsWith('Somente');

  void setSelectedCondominium(Condominio? value) {
    selectedCondominium = value;
    if (value != null) {
      selectedUnit = null; // Redefine a unidade selecionada
      unitys.clear(); // Limpa a lista de unidades
      getUnitsByCondominium(value.id!); // Busca as unidades do novo condomínio
    }
  }

  Future<void> getCondominiums() async {
    condominiums.clear(); // Limpa a lista antes de buscar
    try {
      // Referência à coleção "condominios"
      CollectionReference condominiosCollection =
          FirebaseFirestore.instance.collection(Constants.collectionCondominio);

      // Recupera o ID da imobiliária do usuário atual
      final String? idImobiliaria = AuthService.to.host?.idImobiliaria;

      if (idImobiliaria == null) {
        log('Erro: ID da imobiliária não encontrado.');
        return;
      }

      // Consulta para buscar documentos onde "idImobiliaria" seja igual ao ID do usuário
      QuerySnapshot querySnapshot = await condominiosCollection
          .where('idImobiliaria', isEqualTo: idImobiliaria)
          .get();

      // Adiciona os resultados à lista de condomínios
      for (var element in querySnapshot.docs) {
        condominiums.add(Condominio.fromJson(
          element.data() as Map<String, dynamic>,
        ));
      }

      log('Condomínios encontrados: ${condominiums.first.toJson()}');
    } catch (e) {
      log('Erro ao buscar condomínios: $e');
    }
  }

  Future<void> getUnitsByCondominium(String condominiumId) async {
    unitys.clear();
    selectedUnit = null; // Zera a unidade selecionada
    try {
      CollectionReference unidadesCollection =
          FirebaseFirestore.instance.collection(Constants.collectionUnidade);

      // Consulta para buscar documentos onde "condominio.id" seja igual ao ID do condomínio selecionado
      QuerySnapshot querySnapshot = await unidadesCollection
          .where('condominio.id', isEqualTo: condominiumId)
          .get();

      // Adiciona os resultados à lista de unidades
      for (var element in querySnapshot.docs) {
        unitys.add(Unidade.fromJson(
          element.data() as Map<String, dynamic>,
        ));
      }
    } catch (e) {
      log('Erro ao buscar unidades: $e');
    }
  }

  void resetFields() {
    typeEvent = null; // Zera o tipo de evento
    _selectedCondominium.value = null; // Zera o condomínio selecionado
    _unitys.clear(); // Limpa a lista de unidades
    _selectedUnit.value = null; // Zera a unidade selecionada
    _eventos.clear(); // Limpa a lista de eventos
    selectedDate.value =
        DateTime.now(); // Redefine a data selecionada para a data atual
    selectedTime.value =
        TimeOfDay.now(); // Redefine o horário selecionado para o horário atual
    repeatOption.value = ''; // Zera a opção de repetição
    endOption.value = ''; // Zera a opção de término
    endDate.value = null; // Zera a data de término
  }

  @override
  void onInit() {
    super.onInit();
    getEventsByImobiliaria(AuthService.to.host!.idImobiliaria!);
    buildRepeatOptions();
    getCondominiums();
  }

  void buildRepeatOptions() {
    final date = selectedDate.value;
    final formattedDate =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

    repeatOptions.assignAll([
      'Somente $formattedDate',
      'Todos os Dias',
      'Todas as Semanas',
      'A cada 2 Semanas',
      'Todos os Meses',
      'Todos os Anos',
    ]);

    repeatOption.value = repeatOptions.first;
  }

  void setRepeatOption(String value) {
    repeatOption.value = value;
    if (isSingleDateOnly) {
      endOption.value = '';
      endDate.value = null;
    }
  }

  void setEndOption(String value) {
    endOption.value = value;
    if (value == 'Nunca') {
      endDate.value = null;
    }
  }

  Future<void> pickEndDate() async {
    final maxSelectableDate = selectedDate.value
        .add(Duration(days: 365 * 3 + 60)); // 3 anos + 2 meses

    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: selectedDate.value,
      lastDate: maxSelectableDate,
    );

    if (picked != null) {
      // Validação específica
      if (repeatOption.value == 'Todos os Dias' &&
          picked.isAfter(selectedDate.value.add(Duration(days: 95)))) {
        showErrorDialog(
            'Eventos diários podem ser agendados no máximo para 95 dias.');
        return;
      }

      final limitForValidation =
          selectedDate.value.add(Duration(days: 365 * 3)); // 3 anos "visuais"
      if (picked.isAfter(limitForValidation)) {
        showErrorDialog('Eventos podem ser agendados no máximo para 3 anos.');
        return;
      }

      final confirmed = await showEndDateDialog(
        'Agendamento',
        repeatOption.value,
        picked,
      );

      if (confirmed) {
        endDate.value = picked;
      }
    }
  }

  Future<void> saveSchedule() async {
    final calendarController = Get.find<CalendarController>();

    if (typeEvent == null) {
      showErrorDialog('Selecione o tipo de evento.');
      return;
    }

    if (selectedCondominium == null) {
      showErrorDialog('Selecione um condomínio.');
      return;
    }

    if (selectedUnit == null) {
      showErrorDialog('Selecione uma unidade.');
      return;
    }

    final String repeat = repeatOption.value;

    DateTime startDate = selectedDate.value;
    DateTime? limitDate;

    // Regras para limite de data
    if (isSingleDateOnly) {
      limitDate = startDate;
    } else if (endOption.value == 'Nunca') {
      if (repeat == 'Todos os Dias') {
        limitDate = startDate.add(Duration(days: 95));
      } else {
        limitDate = startDate.add(Duration(days: 365 * 3 + 60));
      }
    } else if (endOption.value == 'Na data...' && endDate.value != null) {
      if (repeat == 'Todos os Dias' &&
          endDate.value!.isAfter(startDate.add(Duration(days: 95)))) {
        showErrorDialog(
            'Eventos diários podem ser agendados no máximo para 95 dias.');
        return;
      }

      if (endDate.value!.isAfter(startDate.add(Duration(days: 365 * 3 + 60)))) {
        showErrorDialog('Eventos podem ser agendados no máximo para 3 anos.');
        return;
      }

      limitDate = endDate.value;
    } else {
      showErrorDialog('Selecione uma data final válida.');
      return;
    }

    // Gerar lista de datas
    List<DateTime> datesToAdd = [];

    DateTime nextValidDate(int year, int month, int day) {
      try {
        return DateTime(year, month, day);
      } catch (_) {
        final lastDay = DateTime(year, month + 1, 0).day;
        return DateTime(year, month, lastDay);
      }
    }

    DateTime date = startDate;

    switch (repeat) {
      case 'Todos os Dias':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = date.add(Duration(days: 1));
        }
        break;
      case 'Todas as Semanas':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = date.add(Duration(days: 7));
        }
        break;
      case 'A cada 2 Semanas':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = date.add(Duration(days: 14));
        }
        break;
      case 'Todos os Meses':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = nextValidDate(date.year, date.month + 1, date.day);
        }
        break;
      case 'Todos os Anos':
        while (!date.isAfter(limitDate!)) {
          datesToAdd.add(date);
          date = DateTime(date.year + 1, date.month, date.day);
        }
        break;
      default:
        // Caso seja "Somente [data]", adiciona só a data selecionada
        datesToAdd.add(startDate);
        break;
    }

    // Criar o evento
    final event = Event(
      id: Uuid().v4(),
      type: typeEvent,
      date: startDate,
      dates: datesToAdd,
      condominium: selectedCondominium,
      unit: selectedUnit,
      repeatOption: repeat,
    );

    try {
      await FirebaseFirestore.instance
          .collection(Constants.collectionEvents)
          .doc(event.id)
          .set(event.toJson());

      await FirebaseFirestore.instance
          .collection(Constants.collectionUnidade)
          .doc(selectedUnit!.id)
          .update({
        'eventos': FieldValue.arrayUnion([event.toJson()]),
      });

      log('Evento salvo com sucesso!');
      for (var date in datesToAdd) {
        final normalizedDate = DateTime(date.year, date.month, date.day);

        calendarController.addEvent(normalizedDate, event);
      }

      calendarController.refreshEvents();
      calendarController.refresh();

      Get.back();
      resetFields();
      calendarController.focusedDay.value = DateTime.now();
      calendarController.selectedDay.value = DateTime.now();
      calendarController.refreshEvents();
    } catch (e) {
      log('Erro ao salvar evento: $e');
      showErrorDialog('Erro ao salvar o evento. Tente novamente. $e');
    }
  }

  Future<void> getEventsByImobiliaria(String idImobiliaria) async {
    try {
      CollectionReference eventsCollection =
          FirebaseFirestore.instance.collection('agendamentos');

      QuerySnapshot querySnapshot = await eventsCollection
          .where('condominium.idImobiliaria', isEqualTo: idImobiliaria)
          .get();

      // Limpa os eventos existentes antes de adicionar os novos
      eventos.clear();
      final calendarController = Get.find<CalendarController>();
      calendarController.events.clear();
      // Adiciona os eventos recuperados ao mapa de eventos do TableCalendar
      for (var element in querySnapshot.docs) {
        final event = Event.fromJson(element.data() as Map<String, dynamic>);

        // Adiciona cada data do evento ao mapa de eventos

        for (var date in event.dates ?? []) {
          final normalizedDate = DateTime(date.year, date.month, date.day);

          calendarController.addEvent(normalizedDate, event);
        }
      }

      log('Eventos carregados com sucesso: ${eventos.length}');
      calendarController.refreshEvents();
    } catch (e) {
      log('Erro ao buscar eventos: $e');
    }
  }
}
