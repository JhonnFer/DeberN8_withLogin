import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../models/food_item_model.dart';
import '../widgets/food_card.dart';
import '../widgets/order_summary.dart';
import '../../providers/auth_provider.dart';
import '../../providers/order_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool entregaDomicilio = true;
  bool sinPicante = false;
  int tipoEnvio = 0; // 0 normal, 1 express
  String busqueda = '';
  String categoriasSeleccionada = '';

  @override
  Widget build(BuildContext context) {
    final foodItemsAsync = ref.watch(foodItemsProvider);
    final cartState = ref.watch(cartProvider);
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Pedidos'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: _openSummary,
              ),
              if (cartState.totalItems > 0)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${cartState.totalItems}',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Mi Perfil'),
                onTap: () => _showProfileDialog(),
              ),
              PopupMenuItem(
                child: const Text('Mis Pedidos'),
                onTap: () => context.pushNamed('orders'),
              ),
              PopupMenuItem(
                child: const Text('Cerrar Sesión'),
                onTap: () => _handleLogout(context),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: currentUser.when(
                data: (user) => Text(
                  'Bienvenido, ${user?.email ?? 'Usuario'}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                loading: () => const Text(
                  'Cargando...',
                  style: TextStyle(color: Colors.white),
                ),
                error: (_, __) => const Text(
                  'Usuario',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                _showProfileDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt),
              title: const Text('Mis Pedidos'),
              onTap: () {
                Navigator.pop(context);
                context.pushNamed('orders');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: () => _handleLogout(context),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buscador
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Buscar comida...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (v) => setState(() => busqueda = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: () {}, child: const Text('Buscar')),
                ],
              ),
              const SizedBox(height: 12),

              // Opciones de entrega
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Entrega a domicilio'),
                        const Spacer(),
                        Switch(
                          value: entregaDomicilio,
                          onChanged: (v) =>
                              setState(() => entregaDomicilio = v),
                        ),
                      ],
                    ),
                    if (entregaDomicilio)
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Ingresa tu dirección...',
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (v) {
                          final cartNotifier = ref.read(cartProvider.notifier);
                          cartNotifier.setDeliveryInfo(
                              entregaDomicilio, v, null);
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Banner de promoción
              SizedBox(
                height: 140,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.fastfood,
                                  size: 48, color: Colors.grey),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Promoción: Combo Familiar - 20% OFF',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Menú con datos de Supabase
              Expanded(
                child: foodItemsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar el menú: $error',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => ref.refresh(foodItemsProvider),
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  ),
                  data: (foodItemsData) {
                    final menuItems =
                        foodItemsData.map((e) => FoodItem.fromMap(e)).toList();

                    // Filtrar por búsqueda
                    final filteredItems = busqueda.isEmpty
                        ? menuItems
                        : menuItems
                            .where((item) => item.nombre
                                .toLowerCase()
                                .contains(busqueda.toLowerCase()))
                            .toList();

                    if (filteredItems.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search_off,
                                size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            Text(
                                'No se encontraron resultados para "$busqueda"'),
                          ],
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return FoodCard(
                          nombre: item.nombre,
                          precio: item.precio,
                          disponible: item.disponible,
                          onTap: () => _showItemDetails(item),
                          onAddToCart: () => _addToCart(item),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton.icon(
                onPressed: _openSummary,
                icon: const Icon(Icons.receipt_long),
                label: Text('Resumen (${cartState.totalItems})'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).reset();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Carrito vaciado')),
                  );
                },
                child: const Text('Limpiar'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contacta con soporte')),
                ),
                child: const Text('Soporte'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addToCart(FoodItem item) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final cartItem = CartItem(
      foodItemId: item.id,
      nombre: item.nombre,
      precio: item.precio,
      cantidad: 1,
    );
    cartNotifier.addItem(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.nombre} añadido al carrito'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showItemDetails(FoodItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.nombre),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Precio: \$${item.precio.toStringAsFixed(2)}'),
            if (item.descripcion != null) ...[
              const SizedBox(height: 8),
              Text('Descripción: ${item.descripcion}'),
            ],
            if (item.categoria != null) ...[
              const SizedBox(height: 8),
              Text('Categoría: ${item.categoria}'),
            ],
            const SizedBox(height: 8),
            Text(
              'Disponible: ${item.disponible ? "Sí" : "No"}',
              style: TextStyle(
                color: item.disponible ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              _addToCart(item);
              Navigator.pop(context);
            },
            child: const Text('Agregar al Carrito'),
          ),
        ],
      ),
    );
  }

  void _openSummary() {
    showModalBottomSheet(
      context: context,
      builder: (_) => const OrderSummary(),
    );
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mi Perfil'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text('Actualizar en Supabase'),
              ),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text('Teléfono'),
                subtitle: Text('No configurado'),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Dirección'),
                subtitle: Text('No configurada'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      final loginNotifier = ref.read(loginStateNotifierProvider.notifier);
      await loginNotifier.logout();
      if (mounted) {
        context.go('/login');
      }
    }
  }
}
