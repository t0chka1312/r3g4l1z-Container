<?php include("menu.php"); ?>
<div class="container">
  <h2>Formulario de Contacto</h2>
  <form method="post">
    <label>Nombre:</label>
    <input type="text" name="nombre" required>
    
    <label>Email:</label>
    <input type="email" name="email" required>

    <label>Mensaje:</label>
    <textarea name="mensaje" rows="5" required></textarea>

    <button type="submit">Enviar</button>
  </form>
</div>
