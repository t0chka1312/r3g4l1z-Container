<?php include("menu.php");

function randomFolder($length = 8) {
    return substr(str_shuffle("abcdefghijklmnopqrstuvwxyz0123456789"), 0, $length);
}

$uploadSuccess = false;
$subfolder = "";

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_FILES["fileToUpload"])) {
    $subfolder = randomFolder();
    $target_dir = "uploads/$subfolder/";
    mkdir($target_dir, 0755, true);

    $filename = basename($_FILES["fileToUpload"]["name"]);
    $target_file = $target_dir . $filename;

    $imageFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
    $forbidden = ["php", "php3", "php4", "php5", "phps"];

    if (in_array($imageFileType, $forbidden)) {
        echo "<div class='container'><p>Tipo de archivo no permitido.</p></div>";
    } else {
        if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
            $uploadSuccess = true;
        } else {
            echo "<div class='container'><p>Error al subir el archivo.</p></div>";
        }
    }
}
?>

<div class="container">
  <h2>Sube tu diseño de regaliz personalizado</h2>
  <p>Aquí puedes subir tu diseño personalizado para que el resto de usuarios pueda verlos, recuerda que cada usuario tiene un ID para la subida de sus diseños:</p>
  <form method="post" enctype="multipart/form-data">
    <input type="file" name="fileToUpload" required>
    <button type="submit">Subir</button>
  </form>

  <?php
  if ($uploadSuccess) {
      echo "<p>Archivo subido correctamente.</p>";
      echo "<!-- ID:$subfolder -->";
  }
  ?>
</div>
