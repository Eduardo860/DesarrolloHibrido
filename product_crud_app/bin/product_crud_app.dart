import 'dart:io';
import '../lib/entities/product.dart';
import '../lib/repository/product_repository.dart';
import '../lib/repository/product_repository_impl.dart';
import '../lib/usecase/create_product.dart';
import '../lib/usecase/get_all_products.dart';
import '../lib/usecase/get_product_by_id.dart';
import '../lib/usecase/update_product.dart';
import '../lib/usecase/delete_product.dart';

void main() async {
  final ProductRepository repo = ProductRepositoryImpl();

  final createUC = CreateProduct(repo);
  final getAllUC = GetAllProducts(repo);
  final getByIdUC = GetProductById(repo);
  final updateUC = UpdateProduct(repo);
  final deleteUC = DeleteProduct(repo);

  while (true) {
    stdout.writeln('''
==== CRUD Products (FakeStoreAPI) ====
1. Crear producto
2. Listar productos
3. Obtener producto por ID
4. Actualizar producto
5. Eliminar producto
0. Salir
Seleccione una opción: 
''');

    final op = stdin.readLineSync()?.trim();

    switch (op) {
      case '1':
        final p = await _askProductInputs();
        final res = await createUC(p);
        res.ok
            ? stdout.writeln('✅ Creado: ${res.data?.toJson()}')
            : stderr.writeln('❌ Error: ${res.message}');
        break;

      case '2':
        final res = await getAllUC();
        if (res.ok && res.data != null) {
          for (final p in res.data!) {
            stdout.writeln('${p.id} | ${p.title} | \$${p.price}');
          }
        } else {
          stderr.writeln('❌ Error: ${res.message}');
        }
        break;

      case '3':
        final id = _askInt('ID del producto: ');
        final res = await getByIdUC(id);
        res.ok
            ? stdout.writeln(res.data?.toJson())
            : stderr.writeln('❌ Error: ${res.message}');
        break;

      case '4':
        final id = _askInt('ID del producto a actualizar: ');
        final p = await _askProductInputs();
        final res = await updateUC(id, p);
        res.ok
            ? stdout.writeln('✅ Actualizado: ${res.data?.toJson()}')
            : stderr.writeln('❌ Error: ${res.message}');
        break;

      case '5':
        final id = _askInt('ID del producto a eliminar: ');
        final res = await deleteUC(id);
        res.ok
            ? stdout.writeln('🗑️ Eliminado correctamente')
            : stderr.writeln('❌ Error: ${res.message}');
        break;

      case '0':
        stdout.writeln('👋 ¡Adiós!');
        return;

      default:
        stdout.writeln('⚠️ Opción no válida.');
    }
  }
}

Future<Product> _askProductInputs() async {
  final title = _ask('Título: ');
  final price = _askDouble('Precio: ');
  final desc = _ask('Descripción: ');
  final category = _ask('Categoría: ');
  final image = _ask('URL de imagen: ');
  return Product(
    title: title,
    price: price,
    description: desc,
    category: category,
    image: image,
  );
}

String _ask(String label) {
  stdout.write(label);
  return stdin.readLineSync()?.trim() ?? '';
}

int _askInt(String label) {
  while (true) {
    final v = _ask(label);
    final n = int.tryParse(v);
    if (n != null) return n;
    stdout.writeln('⚠️ Ingresa un número entero válido.');
  }
}

double _askDouble(String label) {
  while (true) {
    final v = _ask(label);
    final n = double.tryParse(v);
    if (n != null) return n;
    stdout.writeln('⚠️ Ingresa un número decimal válido.');
  }
}
