import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

class MapsButton extends StatelessWidget {
  final String address;

  const MapsButton({Key? key, required this.address}) : super(key: key);

  Future<void> _openMaps(String query) async {
    final isGoogleAvailable = await MapLauncher.isMapAvailable(MapType.google);
    final isAppleAvailable = await MapLauncher.isMapAvailable(MapType.apple);

    if (isGoogleAvailable == true || isAppleAvailable == true) {
      final availableMaps = await MapLauncher.installedMaps;

      await availableMaps.first.showMarker(
        coords: Coords(0, 0), // Coordenadas fictícias — opcional: substituir via geocodificação
        title: query,
        description: "Abrir localização",
      );
    } else {
      debugPrint("Nenhum app de mapa encontrado.");
      Get.snackbar("Erro", "Nenhum aplicativo de mapas está disponível.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 30),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () => _openMaps(address),
          child: const Text('Abrir localização'),
        ),
      ),
    );
  }
}
