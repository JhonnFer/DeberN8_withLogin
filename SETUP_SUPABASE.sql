-- =================================================================
-- SETUP INICIAL PARA SUPABASE
-- =================================================================
-- Ejecuta estos comandos SQL en el editor SQL de tu proyecto Supabase
-- (https://app.supabase.com -> Proyecto -> SQL Editor)
-- =================================================================

-- 1. TABLA DE USUARIOS (profile)
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email VARCHAR(255) NOT NULL UNIQUE,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  telefono VARCHAR(20),
  direccion TEXT,
  ciudad VARCHAR(100),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Crear índices
CREATE INDEX idx_users_email ON users(email);

-- Enable RLS
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- Policies for users table
CREATE POLICY "Users can read their own data" ON users
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own data" ON users
  FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can insert their own data" ON users
  FOR INSERT WITH CHECK (auth.uid() = id);

-- =================================================================
-- 2. TABLA DE ITEMS DE COMIDA
CREATE TABLE IF NOT EXISTS food_items (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  descripcion TEXT,
  precio DECIMAL(10, 2) NOT NULL,
  imagen VARCHAR(500),
  categoria VARCHAR(100),
  disponible BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Crear índices
CREATE INDEX idx_food_items_categoria ON food_items(categoria);
CREATE INDEX idx_food_items_disponible ON food_items(disponible);

-- Enable RLS
ALTER TABLE food_items ENABLE ROW LEVEL SECURITY;

-- Policies for food_items table (todos pueden leer)
CREATE POLICY "Anyone can read food items" ON food_items
  FOR SELECT USING (true);

-- =================================================================
-- 3. TABLA DE PEDIDOS
CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  estado VARCHAR(50) DEFAULT 'pending', -- pending, completed, cancelled
  total DECIMAL(10, 2) NOT NULL DEFAULT 0,
  entrega_domicilio BOOLEAN DEFAULT TRUE,
  direccion_entrega TEXT,
  notas TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Crear índices
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_estado ON orders(estado);
CREATE INDEX idx_orders_created_at ON orders(created_at);

-- Enable RLS
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;

-- Policies for orders table
CREATE POLICY "Users can read their own orders" ON orders
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Users can create their own orders" ON orders
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own orders" ON orders
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own orders" ON orders
  FOR DELETE USING (auth.uid() = user_id);

-- =================================================================
-- 4. TABLA DE ITEMS DE PEDIDOS
CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  food_item_id INTEGER NOT NULL REFERENCES food_items(id),
  cantidad INTEGER NOT NULL DEFAULT 1,
  precio DECIMAL(10, 2) NOT NULL,
  notas TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Crear índices
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_food_item_id ON order_items(food_item_id);

-- Enable RLS
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;

-- Policies for order_items table
CREATE POLICY "Users can read items from their orders" ON order_items
  FOR SELECT USING (
    order_id IN (
      SELECT id FROM orders WHERE user_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert items for their orders" ON order_items
  FOR INSERT WITH CHECK (
    order_id IN (
      SELECT id FROM orders WHERE user_id = auth.uid()
    )
  );

-- =================================================================
-- DATOS DE EJEMPLO
-- =================================================================
-- Insertar algunos items de comida de ejemplo
INSERT INTO food_items (nombre, descripcion, precio, categoria, disponible)
VALUES
  ('Hamburguesa Simple', 'Pan, carne, lechuga, tomate', 3.50, 'Hamburguesas', TRUE),
  ('Hamburguesa Doble', 'Pan, doble carne, queso, lechuga, tomate', 5.50, 'Hamburguesas', TRUE),
  ('Pizza Margherita', 'Salsa, mozzarella, tomate fresco', 8.00, 'Pizzas', TRUE),
  ('Pizza Pepperoni', 'Salsa, mozzarella, pepperoni', 9.00, 'Pizzas', TRUE),
  ('Alitas BBQ', 'Alitas de pollo con salsa BBQ', 6.50, 'Entradas', TRUE),
  ('Papas Fritas', 'Papas crujientes con sal', 2.50, 'Acompañamientos', TRUE),
  ('Refresco Pequeño', 'Refresco en vaso pequeño', 1.50, 'Bebidas', TRUE),
  ('Cerveza Artesanal', 'Cerveza artesanal local', 4.00, 'Bebidas', TRUE)
ON CONFLICT DO NOTHING;

-- =================================================================
-- TRIGGER PARA ACTUALIZAR TIMESTAMPS
-- =================================================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = CURRENT_TIMESTAMP;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Aplicar trigger a users
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Aplicar trigger a food_items
CREATE TRIGGER update_food_items_updated_at BEFORE UPDATE ON food_items
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Aplicar trigger a orders
CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON orders
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =================================================================
-- FUNCIONES ÚTILES
-- =================================================================
-- Función para calcular el total del pedido automáticamente
CREATE OR REPLACE FUNCTION calculate_order_total()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE orders 
  SET total = (SELECT SUM(precio * cantidad) FROM order_items WHERE order_id = NEW.order_id)
  WHERE id = NEW.order_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para recalcular el total cuando se agregan items
CREATE TRIGGER recalculate_order_total AFTER INSERT OR UPDATE ON order_items
  FOR EACH ROW EXECUTE FUNCTION calculate_order_total();
