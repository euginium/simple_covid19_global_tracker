class CovidDataModel {
  String countryName, location, updateTime;
  int confirmed, recovered, deaths;
  CovidDataModel(
      {this.location,
      this.confirmed,
      this.countryName,
      this.deaths,
      this.recovered,
      this.updateTime});
}
