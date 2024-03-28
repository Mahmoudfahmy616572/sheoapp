//this is class fetches data from json and return it to the  app
import 'package:flutter/services.dart' as the_bundle;
import 'package:sheoapp/model/sneakers_model.dart';

class Helper {
  //male
  Future<List<Sneakers>> getMaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);
    return maleList;
  }

//female
  Future<List<Sneakers>> getFemaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final femaleList = sneakersFromJson(data);
    return femaleList;
  }

//kids
  Future<List<Sneakers>> getKidsSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidsList = sneakersFromJson(data);
    return kidsList;
  }

  // Single male
  Future<Sneakers> getMaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  //Single female
  Future<Sneakers> getFemaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final femaleList = sneakersFromJson(data);
    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  //Single kids
  Future<Sneakers> getKidsSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidsList = sneakersFromJson(data);
    final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
