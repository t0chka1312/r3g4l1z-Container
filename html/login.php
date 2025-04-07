<?php include("menu.php"); ?>
<div class="container">
  <h2>Acceso de clientes VIP</h2>
  <form method="post">
    <label>Usuario:</label>
    <input type="text" name="user" required>
    
    <label>Contraseña:</label>
    <input type="password" name="pass" required>

    <button type="submit">Entrar</button>
  </form>

  <?php
  if ($_SERVER["REQUEST_METHOD"] === "POST") {
      echo "<p>Usuario o contraseña incorrectos.</p>";
  }
  ?>
</div>
