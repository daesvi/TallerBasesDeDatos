use library_management_system;

/* 
Consulta para obtener todos los libros de un autor espec�fico. Para esto, deber�
declarar una variable asociada al autor, para que la consulta sea m�s din�mica.
NOTA: busque c�mo declarar una variable en Sql Server.
*/

DECLARE @nombreAutor VARCHAR(50) = 'Gabriel Garc�a M�rquez';
SELECT *
FROM Libros l
WHERE l.autorId = (
    SELECT id
    FROM Autores
	where nombre = @nombreAutor
);


/* 
Consulta para obtener todos los libros de una categor�a determinada. Para esto,
deber� declarar una variable asociada a la categor�a, para que la consulta sea m�s
din�mica. NOTA: busque c�mo declarar una variable en Sql Server.
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
Consulta para obtener todos los libros de Gabriel Garc�a M�rquez, y que hayan
sido publicados despu�s de 1970.
*/
DECLARE @nombreAutor VARCHAR(50) = 'Gabriel Garc�a M�rquez';

SELECT *
FROM Libros l
WHERE l.autorId = (
    SELECT id
    FROM Autores
	where nombre = @nombreAutor
)
AND l.fechaPublicacion > '1970';

/* Consulta para obtener todos los libros de la categor�a Terror y publicados despu�s
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
Consulta para obtener todos los libros cuyo t�tulo contenga la palabra Harry.
*/

SELECT *
FROM Libros l
WHERE l.titulo LIKE '%Harry%';

/* 
Crea un procedimiento almacenado que calcule la cantidad de libros publicados por
una editorial espec�fica. El procedimiento debe tomar el nombre de la editorial como
par�metro de entrada y devolver el n�mero total de libros publicados por esa
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
Crea un procedimiento almacenado que devuelva la lista de los libros m�s recientes
por categor�a. El procedimiento debe tomar la categor�a como par�metro de entrada
y devolver una lista de libros ordenados por fecha de publicaci�n, de manera que se
muestre el libro m�s reciente de cada categor�a.
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

EXEC LibrosRecientesPorCategoria @nombreCategoria = 'Ficci�n';