import './location_fact.dart';

class Location {
  final int id;
  final String name;
  final String imagePath;
  final List<LocationFact> facts;

  Location(this.id, this.name, this.imagePath, this.facts);

  //fetchAll means to fetch all the locations in the virtual database that we create
  static List<Location> fetchAll() {
    return [
      Location(1, 'Kiyomizu-dera', 'assets/images/kiyomizu-dera.jpg', [
        LocationFact('Summary',
            'Kiyomizu-dera, officially Otowa-san Kiyomizu-dera, is an independent Buddhist temple in eastern Kyoto. The temple is part of the Historic Monuments of Ancient Kyoto UNESCO World Heritage site.'),
        LocationFact('Architectural Style', 'Japanese Buddhist architecture.'),
      ]),
      Location(2, 'Mount Fuji', 'assets/images/fuji.jpg', [
        LocationFact('Summary',
            'Japan’s Mt. Fuji is an active volcano about 100 kilometers southwest of Tokyo. Commonly called “Fuji-san,” it’s the country’s tallest peak, at 3,776 meters.'),
        LocationFact('Did You Know',
            'There are cities that surround Mount Fuji: Gotemba, Fujiyoshida and Fujinomiya.'),
      ]),
      Location(3, 'Arashiyama Bamboo Grove', 'assets/images/arashiyama.jpg', [
        LocationFact('Summary',
            'While we could go on about the ethereal glow and seemingly endless heights of this bamboo grove on the outskirts of Kyoto, the sight\'s pleasures extend beyond the visual realm.'),
        LocationFact('How to Get There',
            'Kyoto airport, with several terminals, is located 16 kilometres south of the city and is also known as Kyoto. Kyoto can also be reached by transport links from other regional airports.'),
      ]),
    ];
  }
  static Location fetchByID(int locationID) {
    //fetch all locations, iterate them and when we find the location
    //with the ID we want, return it immediately
    var locations = Location.fetchAll();
    for (var i = 0; i < locations.length; i++) {
      if (locations[i].id == locationID) {
        return locations[i];
      }
    }
    return null;
  }
}