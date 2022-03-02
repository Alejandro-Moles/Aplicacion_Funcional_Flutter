<?php

$server = "localhost";
$user = "root";
$pass = "clave";
$bd = "BDAlejandroMoles";

//Creamos la conexión
$conexion = mysqli_connect($server, $user, $pass,$bd)
or die("Ha sucedido un error inexperado en la conexion de la base de datos");

if (!$conexion) {
    die("Connection failed: " . mysqli_connect_error());
}
    $cosulta = mysqli_query($conexion, "SELECT Nombre FROM Tareas");


    while($row = mysqli_fetch_array($cosulta))
{
    $Nombre=$row['Nombre'];
    
    echo $Nombre;
}
    


mysqli_close($conexion);