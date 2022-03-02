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


$usuario = $_GET["Usuario"];
$contrasenia = $_GET["Contrasenia"];

if($usuario == '' or $contrasenia == ''){
    echo 'Debes introducir un usuario y una contraseña';
}else{
    $cosulta = mysqli_query($conexion, "SELECT * FROM ingresar WHERE Usuario = '$usuario' and Contrasenia = '$contrasenia'");
    $ver = mysqli_num_rows($cosulta);
    if($ver>0){
        echo '1';
    }else{
        echo 'Usuario o contraseña incorrecta';
    }
}

mysqli_close($conexion);

