import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class AddEditScreen extends StatefulWidget {
  const AddEditScreen({super.key});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final ApiService _api = ApiService();
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _imgCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  bool isSaving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _codeCtrl.dispose();
    _imgCtrl.dispose();
    _qtyCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    final qty = int.parse(_qtyCtrl.text.trim());
    final unitPrice = int.parse(_priceCtrl.text.trim());

    final product = Product(
      name: _nameCtrl.text.trim(),
      code: int.parse(_codeCtrl.text.trim()),
      img: _imgCtrl.text.trim(),
      qty: qty,
      unitPrice: unitPrice,
      totalPrice: qty * unitPrice,
    );

    try {
      await _api.createProduct(product);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added')),
      );
      Navigator.pop(context, true); // true = home screen refresh korbe
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }

  String? requiredField(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return null;
  }

  String? numberField(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    if (int.tryParse(v.trim()) == null) return 'Number dao';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: requiredField,
              ),
              TextFormField(
                controller: _codeCtrl,
                decoration: const InputDecoration(labelText: 'Product Code'),
                keyboardType: TextInputType.number,
                validator: numberField,
              ),
              TextFormField(
                controller: _imgCtrl,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: requiredField,
              ),
              TextFormField(
                controller: _qtyCtrl,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: numberField,
              ),
              TextFormField(
                controller: _priceCtrl,
                decoration: const InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
                validator: numberField,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSaving ? null : save,
                  child: isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}