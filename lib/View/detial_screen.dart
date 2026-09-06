import 'package:covid_tracker/world_state.dart';
import 'package:flutter/material.dart';

class DetialScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

  DetialScreen({
    Key? key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  }) : super(key: key);

  @override
  State<DetialScreen> createState() => _DetialScreenState();
}

class _DetialScreenState extends State<DetialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      // CHANGED HERE: Wrapped the main Column with SingleChildScrollView to prevent overflow
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06),
                        ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                        ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                        ReusableRow(title: 'Death', value: widget.totalDeaths.toString()),
                        ReusableRow(title: 'Critical', value: widget.critical.toString()),
                        ReusableRow(title: 'Today Recovered', value: widget.totalRecovered.toString()),
                      ],
                    ),
                  ),
                ),
                // CHANGED HERE: Moved the CircleAvatar OUT of the Card's column and into the Stack
                // so it actually overlaps the top of the card properly.
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}