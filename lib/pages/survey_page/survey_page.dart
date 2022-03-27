import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_management/api/api.dart';
import 'package:parking_management/controllers/authController.dart';
import 'package:parking_management/pages/survey_page/questions.dart';
import 'package:parking_management/util/animations.dart';

class SurveyPage extends StatelessWidget {
  SurveyPage({Key key}) : super(key: key)
  {
    {
      questionsList = [];
      List<String> questions = [
        "1. Did you like our service?",
        "2. Rate Your Experience Out Of 5",
        "3. Would this be useful as an actual service",
        "4. Your Review:",
      ];

      for (var element in questions) {
        //print("16-survey_page.dart ${element}");
        questionsList.add(Questions(element, ""));
      }
     // print("19-surveypage.dart $questionsList");
    }
  }

  static List questionsList = [];

  // static List get questionsObjectList {
  //   questionsList = [];
  //   List<String> questions = [
  //     "1. Did you like our service",
  //     "2. Rate Your Experience Out Of 5",
  //     "3. Would this be a useful service if we made this available for the public",
  //     "4. Your Review:",
  //   ];
  //
  //   for (var element in questions) {
  //     print("16-survey_page.dart ${element}");
  //     questionsList.add(Questions(element, ""));
  //   }
  //   print("19-surveypage.dart $questionsList");
  //   return questionsList;
  // }


final AuthController controller=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
        () {
          if(controller.surveyGiven.value=="false") {
            return FadeAnimation(
              1.0, SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AutoSizeText(
                    "Take this Survey and let us know what you feel about ParkOur:",
                    style: TextStyle(
                        fontSize: 28, letterSpacing: 1, fontWeight: FontWeight.bold,fontFamily: "OpenSans"),
                    maxLines: 3,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GenerateSurveyQuestion(index: 0, options: ['Yes', 'No']),
                GenerateSurveyQuestion(
                    index: 1, options: ['1', '2', '3', '4', '5']),
                GenerateSurveyQuestion(index: 2, options: ['Yes', 'No']),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: Text(
                              questionsList[3].question,
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontFamily: "OpenSans",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/1.3,
                        child: Card(
                          elevation: 5,
                          child: TextFormField(
                            cursorColor: Colors.deepPurple,
                            controller: controller.reviewController,
                            maxLines: 5,
                            maxLength: 256,
                            decoration: InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      )
                    ]),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple[100],
                          spreadRadius: 10,
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      child: Container(
                          height: 50, child: Center(child: Text("Submit"))),
                      onPressed: () async {
                        questionsList[3].answer = controller.reviewController.text;
                        if (questionsList[0].answer == "" ||
                            questionsList[1].answer == "" ||
                            questionsList[2].answer == "") {
                          return null;
                        }
                        var response =await ApiRequests.submitSurvey(
                          questionsList[0].answer,
                          questionsList[1].answer,
                          questionsList[2].answer,
                          review: questionsList[3].answer,
                        );
                        if(response.statusCode==200)
                          {
                            print("Submitted");
                            controller.surveyGiven.value="true";
                          }
                        else
                          {
                            print("rejected");
                          }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
          )),
            );
          }
          else
            {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0,top: 40),
                child: FittedBox(child: Text("Your Survey has been recorded!",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 70,fontFamily: "OpenSans"),),),
              );
            }
        },
    );
  }
}

class GenerateSurveyQuestion extends StatefulWidget {
  GenerateSurveyQuestion({Key key, this.index, this.options}) : super(key: key);
  int index;
  List<String> options;

  @override
  State<GenerateSurveyQuestion> createState() => _GenerateSurveyQuestionState();
}

class _GenerateSurveyQuestionState extends State<GenerateSurveyQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Text(
                SurveyPage.questionsList[widget.index].question,
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    fontFamily: "OpenSans",
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= 1182) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(widget.options.length, (index) {
                  return Flexible(
                    child: RadioListTile(
                      title: Text(
                        widget.options[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      groupValue: SurveyPage.questionsList[widget.index].answer,
                      value: widget.options[index],
                      activeColor: Colors.deepPurple,
                      visualDensity: VisualDensity.comfortable,
                      onChanged: (value) {
                        setState(() {
                          SurveyPage.questionsList[widget.index].answer = value;
                        });
                      },
                    ),
                  );
                }));
          } else {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.options.length, (index) {
                  return Flexible(
                    child: RadioListTile(
                      title: Text(
                        widget.options[index],
                        style: TextStyle(color: Colors.black),
                      ),
                      groupValue: SurveyPage.questionsList[widget.index].answer,
                      value: widget.options[index],
                      activeColor: Colors.deepPurple,
                      onChanged: (value) {
                        setState(() {
                          SurveyPage.questionsList[widget.index].answer = value;
                        });
                      },
                    ),
                  );
                }));
          }
        }),
        SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
