import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FilterCards extends StatelessWidget {
  const FilterCards();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
            child: Row(
            children: [
              customFilterCard(context, 'Newest Date', Colors.deepOrange),
              customFilterCard(context, 'A-z', Colors.deepPurple),
              customFilterCard(context, 'Z-a', Colors.greenAccent),
              customFilterCard(context, 'Older Date', Colors.indigoAccent),
            ],
          ),
        ),
      ),
    );
  }

  Widget customFilterCard( context, String title, Color color ) {
        final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;

    return Container(
              width: 150,
              margin: EdgeInsets.only( right: 20 ),
              height: categoryHeight,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                    )
                    ),
                  ],
                ),
              ),
            );
  }
}