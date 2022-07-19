import 'package:app_pet/Ui/Desparasitacion.dart';
import 'package:app_pet/Ui/Location.dart';
import 'package:app_pet/Ui/calendar_view.dart';
import 'package:app_pet/Ui/main_menu.dart';
import 'package:app_pet/Ui/medicalexams.dart';
import 'package:app_pet/Ui/settings_page.dart';
import 'package:app_pet/screens/adaption.dart';
import 'package:app_pet/screens/directory.dart';
import 'package:app_pet/screens/medical_diary.dart';
import 'package:app_pet/screens/pet_products.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:app_pet/screens/tips.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:app_pet/screens/visit.dart';
import 'package:app_pet/vet_screens/vet-menu.dart';
import 'package:app_pet/vet_screens/vet_events.dart';
import 'package:app_pet/vet_screens/vet_news.dart';
import 'package:flutter/material.dart';

class SearchSection extends SearchDelegate<String> {
  final cities = [
    'diario Medico',
    'cerca de ti',
    'mi calendario',
    'adopcion',
    'directorio medico',
    'products',
    'tips y eventos',
    'desparasitacion',
    'vacunas',
    'visit al profesional de medicina veterinaria',
    'examenes medico',
    'configuration',
    'agregar mascota',
  ];

  final recentCities = [
    'diario Medico',
    'cerca de ti',
    'mi calendario',
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, '');
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(context) {
    if (query == 'configuration') {
      return SettingPage();
    } else if (query == 'cerca de ti') {
      return LocationScreen();
    } else if (query == 'diario Medico') {
      return MedicalDiary();
    } else if (query == 'mi calendario') {
      return CalendarView();
    } else if (query == 'adopcion') {
      return Adaption();
    } else if (query == 'directorio medico') {
      return Directory();
    } else if (query == 'products') {
      return Products();
    } else if (query == 'tips y eventos') {
      return Tips();
    } else if (query == 'desparasitacion') {
      return Desparasitacion();
    } else if (query == 'vacunas') {
      return Vaccination();
    } else if (query == 'visit al profesional de medicina veterinaria') {
      return Visits();
    } else if (query == 'examenes medico') {
      return MedicalExams();
    } else if (query == 'agregar mascota') {
      return PetReg2();
    } else {
      return MainMenu();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recentCities
        : cities.where((city) {
            final cityLower = city.toLowerCase();
            final queryLower = query.toLowerCase();

            return cityLower.startsWith(queryLower);
          }).toList();

    return buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;

              // 1. Show Results
              showResults(context);

              // 2. Close Search & Return Result
              // close(context, suggestion);

              // 3. Navigate to Result Page
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ResultPage(suggestion),
              //   ),
              // );
            },
            leading: const Icon(Icons.check_circle),
            // title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}


