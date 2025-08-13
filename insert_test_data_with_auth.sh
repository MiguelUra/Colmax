#!/bin/bash

# Script para insertar datos de prueba en Supabase con autenticación
# Configuración de Supabase
SUPABASE_URL="https://tedljwemjofhtkptiyon.supabase.co"
SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRlZGxqd2Vtam9maHRrcHRpeW9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUwODgyNzMsImV4cCI6MjA3MDY2NDI3M30.qTwYnZsAEn9LQI_aVwOJguNjl3JXMqLes6m4rv-GShA"

echo "Paso 1: Aplicando políticas de RLS para product_categories..."

# Aplicar las políticas de RLS usando SQL directo
curl -X POST "$SUPABASE_URL/rest/v1/rpc/exec_sql" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "sql": "CREATE POLICY IF NOT EXISTS \"Anyone can view product categories\" ON public.product_categories FOR SELECT USING (is_active = true); CREATE POLICY IF NOT EXISTS \"Authenticated users can insert categories\" ON public.product_categories FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);"
  }'

echo "\n\nPaso 2: Registrando usuario de prueba..."

# Registrar un usuario de prueba
USER_RESPONSE=$(curl -s -X POST "$SUPABASE_URL/auth/v1/signup" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "admin@colmax.test",
    "password": "ColmaxTest123!",
    "data": {
      "full_name": "Administrador de Prueba",
      "role": "dueno"
    }
  }')

echo "Respuesta del registro: $USER_RESPONSE"

# Extraer el access_token de la respuesta
ACCESS_TOKEN=$(echo $USER_RESPONSE | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

if [ -z "$ACCESS_TOKEN" ]; then
  echo "Error: No se pudo obtener el access token. Intentando con login..."
  
  # Intentar hacer login si el usuario ya existe
  LOGIN_RESPONSE=$(curl -s -X POST "$SUPABASE_URL/auth/v1/token?grant_type=password" \
    -H "apikey: $SUPABASE_ANON_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "email": "admin@colmax.test",
      "password": "ColmaxTest123!"
    }')
  
  echo "Respuesta del login: $LOGIN_RESPONSE"
  ACCESS_TOKEN=$(echo $LOGIN_RESPONSE | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)
fi

if [ -z "$ACCESS_TOKEN" ]; then
  echo "Error: No se pudo autenticar. Saliendo..."
  exit 1
fi

echo "\n\nPaso 3: Insertando categorías de productos con usuario autenticado..."

# Insertar categorías de productos con el token de autenticación
CATEGORIES_RESPONSE=$(curl -s -X POST "$SUPABASE_URL/rest/v1/product_categories" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Prefer: return=representation" \
  -d '[
    {
      "name": "Bebidas",
      "description": "Refrescos, jugos, agua y bebidas alcohólicas",
      "icon_name": "local_drink",
      "is_active": true
    },
    {
      "name": "Comida",
      "description": "Alimentos preparados, snacks y comida rápida",
      "icon_name": "restaurant",
      "is_active": true
    },
    {
      "name": "Lácteos",
      "description": "Leche, queso, yogurt y productos lácteos",
      "icon_name": "local_grocery_store",
      "is_active": true
    },
    {
      "name": "Panadería",
      "description": "Pan, galletas, pasteles y productos de panadería",
      "icon_name": "bakery_dining",
      "is_active": true
    },
    {
      "name": "Limpieza",
      "description": "Productos de limpieza y cuidado del hogar",
      "icon_name": "cleaning_services",
      "is_active": true
    },
    {
      "name": "Higiene Personal",
      "description": "Productos de cuidado personal e higiene",
      "icon_name": "face",
      "is_active": true
    },
    {
      "name": "Medicinas",
      "description": "Medicamentos básicos y productos farmacéuticos",
      "icon_name": "local_pharmacy",
      "is_active": true
    },
    {
      "name": "Frutas y Vegetales",
      "description": "Frutas frescas, vegetales y productos agrícolas",
      "icon_name": "eco",
      "is_active": true
    }
  ]')

echo "Respuesta de categorías: $CATEGORIES_RESPONSE"

echo "\n\nPaso 4: Insertando usuario en la tabla public.users..."

# Obtener el ID del usuario de la respuesta de autenticación
USER_ID=$(echo $USER_RESPONSE | grep -o '"id":"[^"]*' | cut -d'"' -f4)
if [ -z "$USER_ID" ]; then
  USER_ID=$(echo $LOGIN_RESPONSE | grep -o '"id":"[^"]*' | cut -d'"' -f4)
fi

if [ ! -z "$USER_ID" ]; then
  USER_INSERT_RESPONSE=$(curl -s -X POST "$SUPABASE_URL/rest/v1/users" \
    -H "apikey: $SUPABASE_ANON_KEY" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -H "Prefer: return=representation" \
    -d "{
      \"id\": \"$USER_ID\",
      \"email\": \"admin@colmax.test\",
      \"full_name\": \"Administrador de Prueba\",
      \"role\": \"dueno\",
      \"phone\": \"809-555-0100\",
      \"is_active\": true
    }")
  
  echo "Respuesta de inserción de usuario: $USER_INSERT_RESPONSE"
fi

echo "\n\n=== RESUMEN ==="
echo "✅ Usuario de prueba creado: admin@colmax.test"
echo "✅ Categorías de productos insertadas"
echo "✅ Usuario agregado a la tabla public.users"
echo "\nCredenciales de prueba:"
echo "Email: admin@colmax.test"
echo "Password: ColmaxTest123!"
echo "\nAhora puedes usar estas credenciales en la aplicación Flutter para probar el login."
echo "\nPara insertar más datos (colmados, productos), puedes usar el USER_ID: $USER_ID"