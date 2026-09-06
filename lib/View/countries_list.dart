import 'package:covid_tracker/View/detial_screen.dart';
import 'package:flutter/material.dart';
// Make sure to import your services file!
import 'package:covid_tracker/Services/states_services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListAState();
}

class _CountriesListAState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  // 1. Create an instance of your API service
  StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                // 2. Add the future function here!
                // (Make sure the name matches the function in your states_services.dart file)
                future: statesServices.countriesListApi(),

                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return  ListView.builder(
                      itemCount: 8, // CHANGED HERE: Replaced snapshot.data!.length with a fixed number (8) to prevent null errors while loading.
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              // implement country list item using ListTile
                              ListTile(
                                // CHANGED HERE: Replaced text and image references with empty containers so Shimmer doesn't crash before data loads.
                                title: Container(height: 10, width: 89, color: Colors.white),
                                subtitle: Container(height: 10, width: 89, color: Colors.white),
                                leading: Container(height: 50, width: 50, color: Colors.white),
                              )
                            ],
                          ),
                        );

                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length, // CHANGED HERE: Replaced 4 with snapshot.data!.length to show all countries.
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if(searchController.text.isEmpty){
                          return Column(
                            children: [
                              // You will build your country list items here
                              // implement country list item using ListTile
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => DetialScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'] ,
                                        totalCases:  snapshot.data![index]['cases'] ,
                                        totalRecovered: snapshot.data![index]['recovered'] ,
                                        totalDeaths: snapshot.data![index]['deaths'] ,
                                        active: snapshot.data![index]['active'] ,
                                        test: snapshot.data![index]['tests'] ,
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'] ,

                                      )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                
                                  // CHANGED HERE: Replaced Container with NetworkImage for the flag
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              // You will build your country list items here
                              // implement country list item using ListTile
                              InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => DetialScreen(
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        name: snapshot.data![index]['country'] ,
                                        totalCases:  snapshot.data![index]['cases'] ,
                                        totalRecovered: snapshot.data![index]['recovered'] ,
                                        totalDeaths: snapshot.data![index]['deaths'] ,
                                        active: snapshot.data![index]['active'] ,
                                        test: snapshot.data![index]['tests'] ,
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'] ,

                                      )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),

                                  // CHANGED HERE: Replaced Container with NetworkImage for the flag
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                  ),
                                ),
                              )
                            ],
                          );
                        }else{
                          return Container() ;
                        }

                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}