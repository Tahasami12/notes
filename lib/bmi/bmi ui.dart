import 'package:flutter/material.dart';

enum Type { Male, Female }

class Bmi extends StatefulWidget {
  const Bmi({super.key});

  @override
  State<Bmi> createState() => _BmiState();
}

class _BmiState extends State<Bmi> {

  Type selectedGender = Type.Male;

  double height = 165;
  int weight = 70;
  int age = 23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff525252),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Welcome",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),

                const SizedBox(height: 20),

                const Text(
                  "BMI Calculator",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  children: [
                    Expanded(child: _genderCard(Type.Male)),
                    const SizedBox(width: 15),
                    Expanded(child: _genderCard(Type.Female)),
                  ],
                ),

                const SizedBox(height: 25),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // 🔵 Height Card
                    Container(
                      width: 170,
                      height: 466,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [

                          const Text(
                            "Height",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),

                          const SizedBox(height: 20),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                RotatedBox(
                                  quarterTurns: -1,
                                  child: Slider(
                                    value: height,
                                    min: 112,
                                    max: 190,
                                    activeColor: const Color(0xff246AFE),
                                    inactiveColor: Colors.grey.shade300,
                                    onChanged: (value) {
                                      setState(() {
                                        height = value;
                                      });
                                    },
                                  ),
                                ),

                                const SizedBox(width: 15),

                                const Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("190"),
                                    Text("180"),
                                    Text("170"),
                                    Text("160"),
                                    Text("150"),
                                    Text("140"),
                                    Text("130"),
                                    Text("120"),
                                    Text("112"),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    // 🟢 Weight & Age
                    Column(
                      children: [

                        _numberCard(
                          title: "Weight",
                          value: weight,
                          onAdd: () => setState(() => weight++),
                          onRemove: () {
                            setState(() {
                              if (weight > 1) weight--;
                            });
                          },
                        ),

                        const SizedBox(height: 20),

                        _numberCard(
                          title: "Age",
                          value: age,
                          onAdd: () => setState(() => age++),
                          onRemove: () {
                            setState(() {
                              if (age > 1) age--;
                            });
                          },
                        ),

                      ],
                    ),

                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff246AFE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      double bmi =
                          weight / ((height / 100) * (height / 100));

                      String result;

                      if (bmi < 18.5) {
                        result = "Underweight";
                      } else if (bmi < 25) {
                        result = "Normal";
                      } else if (bmi < 30) {
                        result = "Overweight";
                      } else {
                        result = "Obese";
                      }

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Your BMI"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  bmi.toStringAsFixed(1),
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  result,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context),
                                child: const Text("OK"),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      "LET’S GO",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genderCard(Type type) {
    final bool isSelected = selectedGender == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = type;
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              type == Type.Male ? Icons.male : Icons.female,
              size: 20,
              color: isSelected ? Colors.white : Colors.black,
            ),

            const SizedBox(width: 8),

            Text(
              type == Type.Male ? "Male" : "Female",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _numberCard({
    required String title,
    required int value,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Container(
      width: 150,
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            title,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),

          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _circleButton(Icons.remove, onRemove),
              _circleButton(Icons.add, onAdd),
            ],
          ),

        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xff246AFE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
