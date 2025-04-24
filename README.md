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