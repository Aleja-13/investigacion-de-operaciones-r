# Investigación de operaciones en R: programación lineal, DEA, colas y cadenas de Markov

Cuatro herramientas de decisión aplicadas con R: optimización con programación lineal, eficiencia con DEA, simulación de colas y cadenas de Markov.

## Qué encontrarás aquí

| Archivo | Qué hace |
|---|---|
| `scripts/programacion_lineal.R` | Programación lineal con `lpSolve`: maximización de utilidad de una mueblería con restricciones de recursos. |
| `scripts/dea_eficiencia.R` | Análisis envolvente de datos (DEA) con el paquete `deaR`. |
| `scripts/simulacion_de_colas.R` | Simulación de colas con `simmer` y `queueing` variando la tasa de llegada. |
| `scripts/cadenas_de_markov.R` | Cadena de Markov: distribución inicial y matriz de transición. |

## Cómo ejecutarlo

1. Descarga o clona este repositorio y abre RStudio.
2. Fija la carpeta del repositorio como directorio de trabajo (`Session > Set Working Directory`).
3. Los scripts leen los datos desde la carpeta `datos/`. Instala los paquetes que falten con `install.packages("nombre")`.

**Paquetes usados:** `deaR`, `lpSolve`, `queueing`, `simmer`, `simmer.plot`, `xlsReadWrite`, `xlsx`.

## Datos

El script de DEA necesita su base de datos, que no está incluida todavía.

## Autoría

Código y análisis de Alejandra, con fines educativos y de portafolio. Más sobre mi trabajo en analítica de datos: [alejadata.pro](https://alejadata.pro/).
