# 🍽️ TheMealDB Flutter App

Una aplicación Flutter construida con Clean Architecture y BLoC que consume la API de [TheMealDB](https://www.themealdb.com/api.php) para explorar recetas del mundo, guardarlas como favoritas y buscar platillos por nombre.

---

## 📱 Características

- 🔍 Búsqueda de recetas por nombre
- 📋 Listado paginado (infinite scroll)
- 💖 Favoritos con persistencia local (`shared_preferences`)
- 🌐 Consumo de API REST con manejo de errores
- 💥 Animaciones premium (Hero, transición fade+zoom, explosión de corazones)
- 🧼 Arquitectura limpia: `presentation`, `domain`, `data`
- 🌐 Soporte para múltiples idiomas con `AppLocalizations`
- 🎨 Responsive UI con `sizer` + diseño modular

## 🛠️ Estructura del proyecto

lib/
├── core/                  # Temas, constantes, helpers, localizations
├── features/recipes/      # Lógica principal (Clean Architecture)
│   ├── data/              # Datasources, Models, Repositories
│   ├── domain/            # Entities, Repositories
│   └── presentation/      # UI (Pages, Widgets, BLoC)
├── injection_container.dart
└── main.dart

## 🧪 Api usada

Se utiliza la API pública gratuita de TheMealDB.
	•	Endpoint búsqueda: https://www.themealdb.com/api/json/v1/1/search.php?s=
	•	Endpoint por ID: https://www.themealdb.com/api/json/v1/1/lookup.php?i=
