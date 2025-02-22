#!/bin/bash

# Esperar a que la base de datos esté lista
while ! nc -z db 3306; do
  sleep 1
done

# Aplicar migraciones
python manage.py migrate

# Crear superusuario si no existe
python manage.py shell -c "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'adminpassword') if not User.objects.filter(username='admin').exists() else None"

# Ejecutar el servidor
python manage.py runserver 0.0.0.0:8000
