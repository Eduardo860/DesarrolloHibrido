import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/number_input.dart';
import '../widgets/op_button.dart';
import '../widgets/result_display.dart';
import '../widgets/limited_text_input.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final _aCtrl = TextEditingController();
  final _bCtrl = TextEditingController();
  final _textCtrl = TextEditingController();

  num? _resultado;
  int _maxChars = 0;
  String? _errorMsg; 

  @override
  void dispose() {
    _aCtrl.dispose();
    _bCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  num? _parseNum(String v) {
    if (v.trim().isEmpty) return null;
    return num.tryParse(v.trim());
  }

  void _limpiar() {
    setState(() {
      _aCtrl.clear();
      _bCtrl.clear();
      _textCtrl.clear();
      _resultado = null;
      _maxChars = 0;
      _errorMsg = null;
    });
  }

  void _calcular(String op) {
    final a = _parseNum(_aCtrl.text);
    final b = _parseNum(_bCtrl.text);

    if (a == null || b == null) {
      setState(() {
        _resultado = null;
        _maxChars = 0;
        _errorMsg = 'Ingresa ambos números';
        _textCtrl.clear();
      });
      return;
    }

    num r;
    switch (op) {
      case '+':
        r = a + b;
        break;
      case '-':
        r = a - b;
        break;
      case '×':
        r = a * b;
        break;
      case '÷':
        if (b == 0) {
          setState(() {
            _resultado = double.nan;
            _maxChars = 0;
            _errorMsg = 'División entre 0';
            _textCtrl.clear();
          });
          return;
        }
        r = a / b;
        break;
      default:
        r = 0;
    }


    if (r < 0) {
      setState(() {
        _resultado = r;
        _maxChars = 0;
        _errorMsg = 'Resultado negativo: no se permite';
        _textCtrl.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El resultado fue negativo y no es permitido')),
      );
      return;
    }

    final permitido = r.floor();
    final clamped = permitido.clamp(0, 200);

    setState(() {
      _resultado = r;
      _maxChars = clamped;
      _errorMsg = null; 
      _textCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(titleText: 'AppBar Calculadora'), 
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                     Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                      child: Text(
                        'Calculadora Flutter',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color:Colors.indigo),
                      ),
                    ),
                    
                    Row(
                      children: [
                        Expanded(child: NumberInput(controller: _aCtrl, hint: 'Número 1')),
                        const SizedBox(width: 12),
                        Expanded(child: NumberInput(controller: _bCtrl, hint: 'Número 2')),
                      ],
                    ),
                   Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 18.0),
                      child: Text(
                        'Selecciona una operación:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.indigo),
                      ),
                    ),

                    const SizedBox(height: 16),



                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        OpButton(text: '+', onTap: () => _calcular('+')),
                        OpButton(text: '-', onTap: () => _calcular('-')),
                        OpButton(text: '×', onTap: () => _calcular('×')),
                        OpButton(text: '÷', onTap: () => _calcular('÷')),
                      ],
                    ),
                    const SizedBox(height: 16),

                    
                    Row(
                      children: [
                        Expanded(child: ResultDisplay(value: _resultado)),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: _limpiar,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Limpiar'),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    
                    LimitedTextInput(
                      controller: _textCtrl,
                      maxChars: _maxChars,
                      helper:
                          'Solo escribir la cantidad de caracteres que dio como resultado',
                      errorText: _errorMsg, 
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
