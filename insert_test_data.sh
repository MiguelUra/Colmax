#!/bin/bash

# Script para insertar datos de prueba en Supabase
# Configuración de Supabase
SUPABASE_URL="https://tedljwemjofhtkptiyon.supabase.co"
SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRlZGxqd2Vtam9maHRrcHRpeW9uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTUwODgyNzMsImV4cCI6MjA3MDY2NDI3M30.qTwYnZsAEn9LQI_aVwOJguNjl3JXMqLes6m4rv-GShA"

echo "Insertando categorías de productos..."

# Insertar categorías de productos
curl -X POST "$SUPABASE_URL/rest/v1/product_categories" \
  -H "apikey: $SUPABASE_ANON_KEY" \
  -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
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
  ]'

echo "\n\nCategorías insertadas exitosamente!"
echo "\nPara insertar más datos (colmados, productos, etc.), necesitas:"
echo "1. Registrar usuarios en la aplicación"
echo "2. Obtener sus IDs de la tabla auth.users"
echo "3. Crear colmados con esos owner_ids"
echo "4. Insertar productos asociados a esos colmados"
echo "\nPuedes usar la aplicación Flutter para registrar usuarios y luego continuar con más datos de prueba."