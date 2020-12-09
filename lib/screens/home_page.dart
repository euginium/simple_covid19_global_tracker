import 'package:covidapi_app/model/covid_data_model.dart';
import 'package:covidapi_app/service/data.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CovidDataModel _covidDataModel = new CovidDataModel();
  String countryName = 'Malaysia';
  List<String> names;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCovidData();
    getCountryNameList();
  }

  getCovidData() async {
    Data dataClass = new Data();
    _covidDataModel = await dataClass.getData(countryName);
    setState(() {
      if (_covidDataModel == null) {
        _covidDataModel.countryName = '';
        _covidDataModel.confirmed = null;
        _covidDataModel.location = '';
        _covidDataModel.recovered = null;
        _covidDataModel.location = '';
        _covidDataModel.updateTime = '';
      } else {
        return _covidDataModel;
      }
    });
  }

  getCountryNameList() async {
    Data dataclass = new Data();
    names = await dataclass.getCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //dropdown menu
            Container(
              margin: EdgeInsets.all(15),
              child: Form(
                child: DropdownSearch(
                  onChanged: (String value) {
                    print(value);
                    setState(() async {
                      countryName = value;
                      var results = await getCovidData();
                      print(countryName);
                      return results;
                    });
                  },
                  hint: "Select a country",
                  mode: Mode.BOTTOM_SHEET,
                  showSearchBox: true,
                  searchBoxDecoration: InputDecoration(
                    labelText: 'Type in country name',
                    labelStyle: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  items: names,
                  label: "Search",
                  showClearButton: false,
                  selectedItem: countryName,
                ),
              ),
            ),
            // Country Image
            Container(
              height: 360,
            ),
            // Information Card
            Container(
              margin: EdgeInsets.all(12),
              child: Container(
                width: 380,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //country name
                    Container(
                      padding: EdgeInsets.all(12),
                      child: ListTile(
                        title: Text(
                          '${_covidDataModel.countryName}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          '${_covidDataModel.location}',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),

                    //2 cards of recovery and increase
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //red
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 25.0,
                                  offset: Offset(5.0, 10.0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${_covidDataModel.confirmed}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  'Total cases',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //green
                          Container(
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  spreadRadius: 0.5,
                                  blurRadius: 25.0,
                                  offset: Offset(-5.0, 10.0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${_covidDataModel.recovered.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  'Total recovered',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
