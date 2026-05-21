<?php
session_start(); // mécanisme utilisé pour la gestion des sessions pour les connexions
include('routes.php');
?>

<!doctype html>
<html lang="fr">

<head>
	<meta charset="utf-8" />
	<link rel="shortcut icon" href="skin/favicon.ico" />
	<link rel="icon" href="skin/favicon_anime.gif" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta name="keywords" content="<?php echo $keywords; ?>" />
	<meta name="description" content="<?php echo $description; ?>" />
	<meta name="robots" content="index,follow,all" />
	<title><?php echo $title; ?></title>

	<link href="css/style.css" rel="stylesheet" type="text/css" />

	<!-- bootstrap en version v5.2.3 -->
	<link href="vendor/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

	<!-- jquery en version v3.6.3  -->
	<script src="vendor/jquery/dist/jquery.min.js"></script>

	<!-- datatable en version v1.13.1  -->
	<link href="vendor/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
	<script src="vendor/datatables.net/js/jquery.dataTables.min.js"></script>
	<script src="vendor/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>

	<!-- https://icons.getbootstrap.com/#usage bibliotheque d'icones bootstrap 5 -->
	<link rel="stylesheet" href="vendor/bootstrap-icons/font/bootstrap-icons.css">

</head>

<body>

	<header>
		<?php include('bandeau.php'); ?>
	</header>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<?php include('menu.php'); ?>
	</nav>

	<div class="container">
		<?php include($affiche); ?>
	</div>

	<!-- Footer -->
	<footer class="page-footer font-small blue pt-4"">
		<?php include('pied_page.php'); ?>
	</footer>
	<!-- Footer -->

</body>
</html>