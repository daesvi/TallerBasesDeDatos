use library_management_system;

/* 
Consulta para obtener todos los libros de un autor específico. Para esto, deberá
declarar una variable asociada al autor, para que la consulta sea más dinámica.
NOTA: busque cómo declarar una variable en Sql Server.
*/

DECLARE @nombreAutor VARCHAR(50) = 'Gabriel García Márquez';
SELECT *
FROM Libros l
WHERE l.autorId = (
    SELECT id
    FROM Autores
	where nombre = @nombreAutor
);


/* 
Consulta para obtener todos los libros de una categoría determinada. Para esto,
deberá declarar una variable asociada a la categoría, para que la consulta sea más
dinámica. NOTA: busque cómo declarar una variable en Sql Server.
*/

DECLARE @nombreCategoria VARCHAR(50) = 'Terror';
SELECT *
FROM Libros l
WHERE l.categoriaId = (
    SELECT id
    FROM Categorias
	where nombre = @nombreCategoria
);


/*
Consulta para obtener todos los libros de Gabriel García Márquez, y que hayan
sido publicados después de 1970.
*/
DECLARE @nombreAutor VARCHAR(50) = 'Gabriel García Márquez';

SELECT *
FROM Libros l
WHERE l.autorId = (
    SELECT id
    FROM Autores
	where nombre = @nombreAutor
)
AND l.fechaPublicacion > '1970';

/* Consulta para obtener todos los libros de la categoría Terror y publicados después
de 1976. */

DECLARE @nombreCategoria VARCHAR(50) = 'Terror';

SELECT *
FROM Libros l
WHERE l.categoriaId = (
    SELECT id
    FROM Categorias
	where nombre = @nombreCategoria
)
AND l.fechaPublicacion > '1976';

/* 
Consulta para obtener todos los libros cuyo título contenga la palabra Harry.
*/

SELECT *
FROM Libros l
WHERE l.titulo LIKE '%Harry%';

/* 
Crea un procedimiento almacenado que calcule la cantidad de libros publicados por
una editorial específica. El procedimiento debe tomar el nombre de la editorial como
parámetro de entrada y devolver el número total de libros publicados por esa
editorial.
*/

CREATE PROCEDURE CantidadLibrosPorEditorial
    @nombreEditorial VARCHAR(50)
AS
BEGIN
    SELECT COUNT(*) 
	FROM Libros l
	WHERE l.editorialId = (
    SELECT id
    FROM Editoriales
	where nombre = @nombreEditorial
)
END

EXEC CantidadLibrosPorEditorial @nombreEditorial = 'Salamandra';

/*
Crea un procedimiento almacenado que devuelva la lista de los libros más recientes
por categoría. El procedimiento debe tomar la categoría como parámetro de entrada
y devolver una lista de libros ordenados por fecha de publicación, de manera que se
muestre el libro más reciente de cada categoría.
*/

CREATE PROCEDURE LibrosRecientesPorCategoria
    @nombreCategoria VARCHAR(50)
AS
BEGIN
    SELECT * 
	FROM Libros l
	WHERE l.categoriaId = (
    SELECT id
    FROM Categorias
	where nombre = @nombreCategoria
)
ORDER BY l.fechaPublicacion DESC;
END

EXEC LibrosRecientesPorCategoria @nombreCategoria = 'Ficción';