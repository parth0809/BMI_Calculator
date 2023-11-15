import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/results_page.dart';
import 'package:bmi_calculator/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';
import 'icon_card.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  late Gender Selected_gender = Gender.male;
  int height = 180;
  int weight = 60;
  int age = 20;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: ReusableCard(
                      onPress: () {
                        setState(() {
                          Selected_gender = Gender.male;
                        });
                      },
                      colour: Selected_gender == Gender.male
                          ? Color(activeCardColor)
                          : Color(inActiveCardColor),
                      cardChild: IconContext("Male", FontAwesomeIcons.mars)),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        Selected_gender = Gender.female;
                      });
                    },
                    colour: Selected_gender == Gender.female
                        ? Color(activeCardColor)
                        : Color(inActiveCardColor),
                    cardChild: IconContext("Female", FontAwesomeIcons.venus),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ReusableCard(
              colour: Color(activeCardColor),
              cardChild: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "HEIGHT",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF8d8e98),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      Text("cm",
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFF8d8e98)))
                    ],
                  ),
                  SliderTheme(
                    child: Slider(
                      value: height.toDouble(),
                      min: 120,
                      max: 220,
                      onChanged: (double value) {
                        setState(() {
                          height = value.round();
                        });
                      },
                    ),
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      thumbColor: Color(0xFFEB1555),
                      inactiveTrackColor: Colors.grey,
                      overlayColor: Color(0x29EB1555),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
                    ),
                  )
                ],
              ),
              onPress: () {},
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ReusableCard(
                  colour: Color(inActiveCardColor),
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Weight",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF8d8e98),
                        ),
                      ),
                      Text(
                        weight.toString(),
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundItemButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                weight--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RoundItemButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              })
                        ],
                      ),
                    ],
                  ),
                  onPress: () {},
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: Color(inActiveCardColor),
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "AGE",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF8d8e98),
                        ),
                      ),
                      Text(
                        age.toString(),
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RoundItemButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: () {
                              setState(() {
                                age--;
                              });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RoundItemButton(
                              icon: FontAwesomeIcons.plus,
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              })
                        ],
                      ),
                    ],
                  ),
                  onPress: () {},
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              CalculatorBrain calc =
                  CalculatorBrain(height: height, weight: weight);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Results(
                            BMIResult: calc.CalculateBMI(),
                            resultText: calc.getResult(),
                            interpretation: calc.getInterpretation(),
                          )));
            },
            child: Container(
              child: Center(
                child: Text(
                  "Calculate",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              color: const Color(bottomContainerColor),
              margin: const EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(bottom: 10),
              width: double.infinity,
              height: bottomContainerHeight,
            ),
          )
        ],
      ),
    );
  }
}

class RoundItemButton extends StatelessWidget {
  const RoundItemButton({required this.icon, required this.onPressed});
  final VoidCallback onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      elevation: 0,
      constraints: BoxConstraints.tightFor(width: 56, height: 56),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
      onPressed: onPressed,
    );
  }
}
