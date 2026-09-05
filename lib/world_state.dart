import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);


  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration:  const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  final colorlist = <Color>  [
  const Color(0xff4285F4),
  const Color(0xff1aa260),
  const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(15.0),
      child:  Scaffold(
        body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
              PieChart(dataMap: const {
              "Total": 20,
              "Recovered": 15,
              "Deaths": 5,
              },
                chartRadius:  MediaQuery.of(context).size.height / 3.2,
                legendOptions: const LegendOptions(
                legendPosition: LegendPosition.left
                ),
                animationDuration:const Duration(microseconds: 1200),
                   chartType: ChartType.ring,

                colorList: colorlist,
              ),

               Padding(
                 padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                 child: Card(
                    child: Column(
                      children: [
                          ReusableRow(title: 'Total', value: '200'),
                        ReusableRow(title: 'Total', value: '200'),
                        ReusableRow(title: 'Total', value: '200'),
                      ],

                    ),
                  ),
               ),

               Container(
                 height: 50,
                 decoration: BoxDecoration(

                   color: Colors.green,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: const Center(

                   child: Text('Track Countries'),
                 ),
               )

              ],
            )
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  String title , value;
   ReusableRow({Key? key, required this.title, required this.value}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10 ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],

          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
