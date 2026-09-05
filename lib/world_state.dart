import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              FutureBuilder(
                future: statesServices.fetchWorldStateRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {

                  // FIXED: Changed to !snapshot.hasData to show spinner while loading
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ),
                    );
                  } else {

                    // FIXED: Wrapped the Column in Expanded and SingleChildScrollView
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!.cases!.toString()),
                                "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartRadius: MediaQuery.of(context).size.height / 3.2,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              animationDuration: const Duration(milliseconds: 1200), // FIXED: microseconds to milliseconds
                              chartType: ChartType.ring,
                              colorList: colorlist,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Recovered',
                                      value: snapshot.data!.recovered.toString(),
                                    ),
                                    ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CountriesListScreen()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text('Track Countries'),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}