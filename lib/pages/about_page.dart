import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:parking_management/util/animations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1, Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 30, 20, 30),
        child: Column(
          children: [Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              "About the service:\n",maxLines: 2,textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "OpenSans",), presetFontSizes:[70,40,35,30,20,15,8]),
          ),
            AutoSizeText(
                "ParkOur is a service that aims to let people park their vehicle anytime,anywhere as long as they feel like parking it \n"
                    "It let's you choose a street to park your vehicle in.Each street where you can park is marked in:"
                , style: TextStyle(
                 fontFamily: "OpenSans", letterSpacing: 1,),maxLines:11,presetFontSizes: [24,20,16,12,8,4],),
            AutoSizeText("Green", style: TextStyle(
                fontFamily: "OpenSans",
                letterSpacing: 1,
                color: Colors.green),maxLines:1,presetFontSizes: [24,20,16,12,8,4,],),
            AutoSizeText("or", style: TextStyle(
             fontFamily: "OpenSans", letterSpacing: 1,),maxLines:1,presetFontSizes: [24,20,16,4,],),
            AutoSizeText("Red.", style: TextStyle(
                fontFamily: "OpenSans",
                letterSpacing: 1,
                color: Colors.red),maxLines:1,presetFontSizes: [24,20,16,12,4,],),
            AutoSizeText(
              "The former means there are enough spots available for you to book your parking and the latter means "
                  "the parking spots are scarce for the moment.\n"
                  "After booking a spot ,you are given a time range of 10 minutes, 5 minutes before the start time and 5 minutes after "
                  "the start time.\nIn other words, assuming you have booked a slot to 7:45pm in 60ft road, you can park your vehicle anywhere "
                  "in 60ft road starting from 7:40pm to 7:50pm, "
                  "after which your booking is considered invalid if you have not parked your vehicle and started the timer.\n\n"
                  "Talking about the timer,\n"
                  "after parking your vehicle in the given range of time,you have to click on the start button present"
                  "on the screen to validate your parking."
                  "Click on the stop button to end your parking.\nMake sure to take the and let us know what you feel about Parkour.\nThat's it folks.Have fun!"
                  "",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  letterSpacing: 1,
                 ),maxLines:50,presetFontSizes: [24,20,16,12,8,4,],
            )

          ],
        ),
      ),
    );
  }
}
