// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:u_lime/result.dart';

class UlimeStepper extends StatefulWidget {
  const UlimeStepper({Key? key}) : super(key: key);

  @override
  _UlimeStepperState createState() => _UlimeStepperState();
}

class _UlimeStepperState extends State<UlimeStepper> {
  double k = 1, mg2 = 1, ca = 1, al = 1;
  double y = 1, dpth = 1, hal = 1, rpm = 1;
  double surface = 100, ve = 1, x = 1, LQ1 = 1, LQ2 = 1;
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  DateTime timeBackPressed = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final defference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = defference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const message = "Press back again to exit";
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff54B175),
          elevation: 0,
          title: const Text("U-Lime"),
          centerTitle: true,
          toolbarHeight: 40,
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0xff54B175))),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: StepperType.horizontal,
                  physics: const ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: const Text(''),
                      content: _step1(),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text(''),
                      content: _step2(),
                      isActive: _currentStep >= 1,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: const Text(''),
                      content: _step3(),
                      isActive: _currentStep >= 2,
                      state: _currentStep >= 3
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                  controlsBuilder:
                      (BuildContext context, ControlsDetails details) {
                    return Container(
                      margin: const EdgeInsets.only(top: 40),
                      child: Row(children: [
                        if (_currentStep >= 1) ...[
                          Expanded(
                            child: ElevatedButton(
                              child: const Text(
                                "BACK",
                                style: TextStyle(
                                    color: Color(0xff54B175), fontSize: 18),
                              ),
                              onPressed: details.onStepCancel,
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xff54B175),
                                  )),
                            ),
                          ),
                          const SizedBox(width: 10)
                        ],
                        Expanded(
                            child: ElevatedButton(
                          child: txtNextCalcule(),
                          onPressed: details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xff54B175),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        )),
                      ]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  txtNextCalcule() {
    if (_currentStep == 2) {
      return const Text(
        "Calculate",
        style: TextStyle(color: Colors.white, fontSize: 18),
      );
    } else {
      return const Text(
        "NEXT",
        style: TextStyle(color: Colors.white, fontSize: 18),
      );
    }
  }

  continued() {
    final isLastStep = _currentStep == 2;
    if (isLastStep) {
      calculate(k, ca, mg2, al, y, dpth, hal, rpm, surface, ve, x);
      setState(() {
        LQ1 = LQ1;
        LQ2 = LQ2;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ResultPage(LQ1: LQ1.toString(), LQ2: LQ2.toString())),
      );
    } else {
      setState(() => _currentStep += 1);
    }
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  Widget _step1() {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "K (mg/dm\u00B3)",
              ),
              onChanged: (value) => k = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "Ca\u00B2\u207A (mg/dm\u00B3)",
              ),
              onChanged: (value) => ca = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "Mg\u00B2\u207A (mg/dm\u00B3)",
              ),
              onChanged: (value) => mg2 = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "Al\u00B3\u207A (cmolᶜ/dm\u00B3)",
              ),
              onChanged: (value) => al = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _step2() {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "Y = f (soil buffer capacity)",
              ),
              onChanged: (value) => y = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "dpth (in Cm)",
              ),
              onChanged: (value) => dpth = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "H + Al (cmolᶜ/dm\u00B3)",
              ),
              onChanged: (value) => hal = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "RPN (Real Power of Neutralization in %)",
              ),
              onChanged: (value) => rpm = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _step3() {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "Surface (in %)",
              ),
              onChanged: (value) => surface = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText: "Ve (Desired V base saturation in %)",
              ),
              onChanged: (value) => ve = double.parse(value),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                labelText:
                    "X = f (crop demand for Ca\u00B2\u207A + Mg\u00B2\u207A)",
              ),
              onChanged: (value) => x = double.parse(value),
            ),
          ),
          if (LQ1 != 1) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "LQ1 : ",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                Text(
                  LQ1.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ],
          if (LQ2 != 1) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  "LQ2 : ",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                Text(
                  LQ2.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  calculate(k, ca, mg2, al, y, dpth, hal, rpm, surface, ve, x) {
    var a = (k / 39.1) / 10;
    var sb = a + ca + mg2;

    var t = sb + al;
    var m = 100 * (al / t);

    var T_ = sb + hal;
    var va = 100 * (sb / T_);

    var LR1 = y * al + (x - (ca + mg2));

    var LR2 = ((ve - va) * T_) / 100;

    LQ1 = (LR1 / rpm) * (surface / 100) * (dpth / 20) * 100;

    LQ2 = (LR2 / rpm) * (surface / 100) * (dpth / 20) * 100;
  }
}
