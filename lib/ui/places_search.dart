import 'dart:async';

import 'package:aajtak/models/places_model.dart';
import 'package:aajtak/respository/places_repository.dart';
import 'package:aajtak/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlacesSearchScreen extends StatefulWidget {
  const PlacesSearchScreen({Key? key}) : super(key: key);
  static const route = '/Places';
  @override
  _PlacesSearchScreenState createState() => _PlacesSearchScreenState();
}

class _PlacesSearchScreenState extends State<PlacesSearchScreen> {
  late TextEditingController _searchController;
  Timer? _debounce;
  String? searchTerm;
  List<Place> list = [];
  final PlacesRepository _placesRepository = PlacesRepository();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Places search',
            style: Styles.appBarRow,
          ),
        ),
        body: Column(
          children: [
            Container(

              height: 50,
              margin: const EdgeInsets.all(15),
              child: CupertinoSearchTextField(
                backgroundColor: Colors.white,
                prefixIcon: const Icon(Icons.search_sharp,size: 30,),
                controller: _searchController,
                suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill),
                suffixMode: OverlayVisibilityMode.editing,
                placeholder: 'Search Places',
                onChanged: (String value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () async {
                    list = await _placesRepository.getPlaces(_searchController.text);
                    setState(() {
                    });
                  });
                },
                onSubmitted: (String value) {
                  FocusScope.of(context).unfocus();
                },
                onSuffixTap: () {

                  setState(() {
                    list=[];
                    _searchController.text = '';
                  });
                },
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      Place place = list[index];
                      return ListTile(
                        tileColor: Colors.white,
                        onTap: (){
                          Navigator.of(context).pop(place);
                        },
                        leading: const Icon(Icons.location_pin),
                        title: Text(place.placeName ?? '',style: Styles.searchText,),
                      );
                    }))
          ],
        ));
  }
}
