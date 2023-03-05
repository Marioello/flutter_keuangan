import 'package:flutter/material.dart';
import 'package:flutter_keuangan/constants.dart';
import 'package:flutter_keuangan/models/model.dart';
import 'package:flutter_keuangan/services/database.dart';

class QuizAdd extends StatefulWidget {
  final String uid;
  const QuizAdd({super.key, required this.uid});

  @override
  State<QuizAdd> createState() => _QuizAddState();
}

class _QuizAddState extends State<QuizAdd> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _name = '';
  String _month = '';
  String _nominal = '50000';

  // Declare this variable
  int selectedRadio = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() => selectedRadio = val);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBaseColorLight,
      appBar: AppBar(
        title: Text(
          widget.uid,
          style: const TextStyle(fontSize: 18.0),
        ),
        backgroundColor: appBaseColorDark,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _name,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _name,
                decoration: textInputDecoration.copyWith(hintText: 'Name'),
                validator: (val) {
                  return val!.isEmpty ? 'Silahkan masukan nama bulan' : null;
                },
                onChanged: (val) {
                  setState(() => _name = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _month,
                decoration: textInputDecoration.copyWith(hintText: 'Bulan'),
                validator: (val) {
                  return val!.isEmpty
                      ? 'Silahkan masukan bulan dalam angka'
                      : null;
                },
                onChanged: (val) {
                  setState(() => _month = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                initialValue: _nominal,
                decoration: textInputDecoration.copyWith(hintText: 'Nominal'),
                validator: (val) {
                  return val!.isEmpty ? 'Silahkan masukan nominal' : null;
                },
                onChanged: (val) {
                  setState(() => _nominal = val);
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Payment data = Payment(
                          uid: '',
                          name: _name,
                          nominal: _nominal,
                          month: int.parse(_month),
                        );

                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: widget.uid)
                              .updatePaymentData(data);
                        }
                      },
                      child: const Text(
                        'Buat',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
