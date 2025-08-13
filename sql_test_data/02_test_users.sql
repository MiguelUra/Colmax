-- Insertar usuarios de prueba
-- IMPORTANTE: Estos usuarios deben ser registrados primero a través de Supabase Auth
-- Luego ejecutar este script para agregar la información adicional

-- Usuarios de prueba (reemplazar los UUIDs con los IDs reales de Supabase Auth)
-- Ejemplo de cómo insertar después del registro:

/*
-- Usuario 1: Dueño de colmado
INSERT INTO public.users (id, email, full_name, phone, role, is_active) VALUES
('REEMPLAZAR_CON_UUID_REAL', 'dueno1@colmax.test', 'Carlos Rodríguez', '809-555-0101', 'dueno', true);

-- Usuario 2: Otro dueño de colmado
INSERT INTO public.users (id, email, full_name, phone, role, is_active) VALUES
('REEMPLAZAR_CON_UUID_REAL', 'dueno2@colmax.test', 'María González', '809-555-0102', 'dueno', true);

-- Usuario 3: Cliente
INSERT INTO public.users (id, email, full_name, phone, role, is_active) VALUES
('REEMPLAZAR_CON_UUID_REAL', 'cliente1@colmax.test', 'Juan Pérez', '809-555-0201', 'cliente', true);

-- Usuario 4: Otro cliente
INSERT INTO public.users (id, email, full_name, phone, role, is_active) VALUES
('REEMPLAZAR_CON_UUID_REAL', 'cliente2@colmax.test', 'Ana Martínez', '809-555-0202', 'cliente', true);

-- Usuario 5: Repartidor
INSERT INTO public.users (id, email, full_name, phone, role, is_active) VALUES
('REEMPLAZAR_CON_UUID_REAL', 'repartidor1@colmax.test', 'Luis Fernández', '809-555-0301', 'repartidor', true);

-- Usuario 6: Otro repartidor
INSERT INTO public.users (id, email, full_name, phone, role, is_active) VALUES
('REEMPLAZAR_CON_UUID_REAL', 'repartidor2@colmax.test', 'Pedro Jiménez', '809-555-0302', 'repartidor', true);
*/

-- INSTRUCCIONES:
-- 1. Registra estos usuarios en tu aplicación Flutter o directamente en Supabase Auth
-- 2. Obtén los UUIDs reales de la tabla auth.users
-- 3. Reemplaza 'REEMPLAZAR_CON_UUID_REAL' con los UUIDs correspondientes
-- 4. Ejecuta las consultas INSERT

-- Credenciales sugeridas para el registro:
-- dueno1@colmax.test / ColmaxTest123!
-- dueno2@colmax.test / ColmaxTest123!
-- cliente1@colmax.test / ColmaxTest123!
-- cliente2@colmax.test / ColmaxTest123!
-- repartidor1@colmax.test / ColmaxTest123!
-- repartidor2@colmax.test / ColmaxTest123!

-- Consulta para obtener los UUIDs después del registro:
-- SELECT id, email FROM auth.users WHERE email LIKE '%colmax.test';

-- Verificar inserción
-- SELECT * FROM public.users ORDER BY role, full_name;