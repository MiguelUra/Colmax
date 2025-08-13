-- Insertar categorías de productos
-- Ejecutar este archivo primero

INSERT INTO public.product_categories (name, description, icon_name, is_active) VALUES
('Bebidas', 'Refrescos, jugos, agua y bebidas alcohólicas', 'local_drink', true),
('Comida', 'Alimentos preparados, snacks y comida rápida', 'restaurant', true),
('Lácteos', 'Leche, queso, yogurt y productos lácteos', 'local_grocery_store', true),
('Panadería', 'Pan, galletas, pasteles y productos de panadería', 'bakery_dining', true),
('Limpieza', 'Productos de limpieza y cuidado del hogar', 'cleaning_services', true),
('Higiene Personal', 'Productos de cuidado personal e higiene', 'face', true),
('Medicinas', 'Medicamentos básicos y productos farmacéuticos', 'local_pharmacy', true),
('Frutas y Vegetales', 'Frutas frescas, vegetales y productos agrícolas', 'eco', true),
('Carnes y Pescados', 'Carnes frescas, embutidos y pescados', 'set_meal', true),
('Dulces y Snacks', 'Golosinas, chocolates y aperitivos', 'cake', true);

-- Verificar inserción
SELECT * FROM public.product_categories ORDER BY name;