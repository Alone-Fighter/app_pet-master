import 'package:app_pet/Ui/settings_page.dart';
import 'package:app_pet/vet_screens/vet-menu.dart';
import 'package:app_pet/vet_screens/vet_events.dart';
import 'package:app_pet/vet_screens/vet_news.dart';
import 'package:flutter/material.dart';

class SearchVetSection extends SearchDelegate<String> {
  final cities = [
    'Eventos',
    'Novedades',
    'Configuration',
    'Home',
  ];

  final recentCities = [
    'Eventos',
    'Novedades',
    'Configuration',
    'Home',
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
    } else if (query == 'Eventos') {
      return VetEvents();
    } else if (query == 'Novedades') {
      return VetNews();
    } else {
      return VetMenu();
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