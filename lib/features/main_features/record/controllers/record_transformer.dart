class RecordConverter {
  String summarize(Map<String, dynamic>? plantInfo) {
    if (plantInfo == null) {
      return 'No hay información disponible sobre la planta.';
    }

    final bestMatch = plantInfo['results']?[0] as Map<String, dynamic>?;
    if (bestMatch == null) {
      return 'No se encontró la mejor coincidencia.';
    }

    final species = bestMatch['species'] as Map<String, dynamic>?;
    if (species == null) {
      return 'No se encontró información de la especie.';
    }

    final scientificName = species['scientificName'] ?? 'N/A';
    final commonNames = species['commonNames']?.join(', ') ?? 'N/A';
    final family = species['family']?['scientificName'] ?? 'N/A';

    return 'Información de la planta:\n'
        '- Nombre Científico: $scientificName\n'
        '- Nombres Comunes: $commonNames\n'
        '- Familia: $family';
  }
}