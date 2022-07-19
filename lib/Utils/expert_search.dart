import 'package:app_pet/Ui/Desparasitacion.dart';
import 'package:app_pet/Ui/Location.dart';
import 'package:app_pet/Ui/calendar_view.dart';
import 'package:app_pet/Ui/main_menu.dart';
import 'package:app_pet/Ui/medicalexams.dart';
import 'package:app_pet/Ui/settings_page.dart';
import 'package:app_pet/screens/adaption.dart';
import 'package:app_pet/screens/cardiologi.dart';
import 'package:app_pet/screens/dermatologi.dart';
import 'package:app_pet/screens/directory.dart';
import 'package:app_pet/screens/general.dart';
import 'package:app_pet/screens/medical_diary.dart';
import 'package:app_pet/screens/oftomologi.dart';
import 'package:app_pet/screens/oncologi.dart';
import 'package:app_pet/screens/ortoped.dart';
import 'package:app_pet/screens/pet_products.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:app_pet/screens/tips.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:app_pet/screens/visit.dart';
import 'package:app_pet/vet_screens/vet-menu.dart';
import 'package:app_pet/vet_screens/vet_events.dart';
import 'package:app_pet/vet_screens/vet_news.dart';
import 'package:flutter/material.dart';

class ExpertSearch extends SearchDelegate<String> {
  final cities = [
    'Medicina General.',
    'Cardiología.',
    'Dermatología.',
    'Ortopedia.',
    'Oftalmología.',
    'Oncología.',
  ];

  final recentCities = [
    'Medicina General.',
    'Cardiología.',

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
    if (query == 'Medicina General.') {
      return MedicalGeneral();
    } else if (query == 'Cardiología.') {
      return Cardiology();
    } else if (query == 'Dermatología.') {
      return Dermatology();
    } else if (query == 'Ortopedia.') {
      return Ortoped();
    } else if (query == 'Oftalmología.') {
      return Oftomologi();
    } else if (query == 'Oncología.') {
      return Oncology();

    } else {
      return Directory();
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


