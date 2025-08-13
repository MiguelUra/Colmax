-- Políticas para product_categories
-- Permitir que todos puedan ver las categorías de productos
CREATE POLICY "Anyone can view product categories" ON public.product_categories
  FOR SELECT USING (is_active = true);

-- Permitir que usuarios autenticados puedan insertar categorías (para datos de prueba)
-- En producción, esto debería ser solo para administradores
CREATE POLICY "Authenticated users can insert categories" ON public.product_categories
  FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

-- Permitir que usuarios autenticados puedan actualizar categorías
-- En producción, esto debería ser solo para administradores
CREATE POLICY "Authenticated users can update categories" ON public.product_categories
  FOR UPDATE USING (auth.uid() IS NOT NULL);