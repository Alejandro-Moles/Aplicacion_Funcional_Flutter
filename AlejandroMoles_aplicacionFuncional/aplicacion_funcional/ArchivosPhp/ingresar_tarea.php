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


$fecha = $_GET["Fecha"];
$nombre = $_GET["Nombre"];
$descripcion = $_GET["Descripcion"];

if($fecha == '' or $nombre == ''){
    echo 'Debes introducir un usuario y una contraseña';
}else{
    $cosulta = mysqli_query($conexion, "INSERT INTO `Tareas` (`Fecha`, `Nombre`, `Descripcion`) VALUES ('$fecha', '$nombre', '$descripcion')");
    echo $cosulta;
}

mysqli_close($conexion);