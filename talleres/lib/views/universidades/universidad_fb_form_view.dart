import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/universidades_fb.dart';
import '../../services/universidades_service.dart';

class UniversidadFbFormView extends StatefulWidget {
  final String? id;

  const UniversidadFbFormView({super.key, this.id});

  @override
  State<UniversidadFbFormView> createState() => _UniversidadFbFormViewState();
}

class _UniversidadFbFormViewState extends State<UniversidadFbFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nitController = TextEditingController();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _paginaWebController = TextEditingController();
  bool _inicializado = false;

  void _llenarCampos(UniversidadFb uni) {
    if (_inicializado) return;
    _nitController.text = uni.nit;
    _nombreController.text = uni.nombre;
    _direccionController.text = uni.direccion;
    _telefonoController.text = uni.telefono;
    _paginaWebController.text = uni.paginaWeb;
    _inicializado = true;
  }

  Future<void> _guardar({String? id}) async {
    if (!_formKey.currentState!.validate()) return;

    final universidad = UniversidadFb(
      id: id ?? '',
      nit: _nitController.text.trim(),
      nombre: _nombreController.text.trim(),
      direccion: _direccionController.text.trim(),
      telefono: _telefonoController.text.trim(),
      paginaWeb: _paginaWebController.text.trim(),
    );

    try {
      if (widget.id == null) {
        await UniversidadService.addUniversidad(universidad);
      } else {
        await UniversidadService.updateUniversidad(widget.id!, universidad);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              widget.id == null
                  ? 'Universidad creada exitosamente'
                  : 'Universidad actualizada exitosamente',
            ),
          ),
        );
        context.pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _paginaWebController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final esNuevo = widget.id == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(esNuevo ? 'Crear Universidad' : 'Editar Universidad'),
      ),
      body: esNuevo
          ? _buildForm(context, null)
          : StreamBuilder<UniversidadFb?>(
              stream: UniversidadService.watchUniversidadById(widget.id!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('Universidad no encontrada'));
                }
                final uni = snapshot.data!;
                _llenarCampos(uni);
                return _buildForm(context, uni.id);
              },
            ),
    );
  }

  Widget _buildForm(BuildContext context, String? id) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _input(_nitController, 'NIT'),
            const SizedBox(height: 16),
            _input(_nombreController, 'Nombre'),
            const SizedBox(height: 16),
            _input(_direccionController, 'Dirección'),
            const SizedBox(height: 16),
            _input(_telefonoController, 'Teléfono', tipo: TextInputType.phone),
            const SizedBox(height: 16),
            _input(_paginaWebController, 'Página Web', tipo: TextInputType.url),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => _guardar(id: id),
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label, {
    TextInputType tipo = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: tipo,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) => (v == null || v.isEmpty) ? 'Campo obligatorio' : null,
    );
  }
}
