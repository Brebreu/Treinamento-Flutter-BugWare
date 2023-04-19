import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FinalView(),
    );
  }
}

class FinalView extends StatefulWidget {
  const FinalView({Key? key}) : super(key: key);

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  late String password;
  bool senhaEscondida = false;
  double strength = 0;
  // 0: Sem senha no campo
  // 1/4: senha fraca
  // 2/4: senha media
  // 3/4: senha forte
  // 1: senha perfeita

  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");

  String displayText = '';

  void checkPassword(String value) {
    password = value.trim();

    if (password.isEmpty) {
      setState(() {
        strength = 0;
        displayText = 'Insira sua senha';
      });
    } else if (password.length < 6) {
      setState(() {
        strength = 1 / 4;
        displayText = 'Sua senha é pequena';
      });
    } else if (password.length < 8) {
      setState(() {
        strength = 2 / 4;
        displayText = 'Sua senha é aceitável porém não é segura';
      });
    } else {
      if (!letterReg.hasMatch(password) || !numReg.hasMatch(password)) {
        setState(() {
          strength = 3 / 4;
          displayText = 'Sua senha é segura mais da pra melhorar';
        });
      } else {
        setState(() {
          strength = 1;
          displayText = 'Sua senha é perfeita';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: strength <= 1 / 4
                ? Colors.red
                : strength == 2 / 4
                ? Colors.yellow
                : strength == 3 / 4
                ? Colors.blue
                : Colors.green,
            title: const Text('Treinamento BugWare'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => checkPassword(value),
                  obscureText: senhaEscondida,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: strength <= 1 / 4
                                  ? Colors.red
                                  : strength == 2 / 4
                                  ? Colors.yellow
                                  : strength == 3 / 4
                                  ? Colors.blue
                                  : Colors.green,
                              width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          senhaEscondida ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            senhaEscondida = !senhaEscondida;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: 'Senha'),
                ),
                const SizedBox(
                  height: 30,
                ),
                LinearProgressIndicator(
                  value: strength,
                  backgroundColor: Colors.grey[300],
                  color: strength <= 1 / 4
                      ? Colors.red
                      : strength == 2 / 4
                      ? Colors.yellow
                      : strength == 3 / 4
                      ? Colors.blue
                      : Colors.green,
                  minHeight: 15,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  displayText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: strength <= 1 / 4
                          ? Colors.red
                          : strength == 2 / 4
                          ? Colors.yellow
                          : strength == 3 / 4
                          ? Colors.blue
                          : Colors.green),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: strength < 1 / 2 ? null : () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        strength <= 1 / 4
                            ? Colors.red
                            : strength == 2 / 4
                            ? Colors.yellow
                            : strength == 3 / 4
                            ? Colors.blue
                            : Colors.green,
                      ),
                    ),
                    child: const Text('Continue'))
              ],
            ),
          )),
    );
  }
}