<!DOCTYPE html>
<html>
  <head>
    <title>Korektor</title>
    <meta charset="utf-8">

    <link rel="stylesheet" href="branding/public/css/lindat.css" type="text/css" />
    <link rel="stylesheet" href="korektor.css" type="text/css" />

    <script src="//code.jquery.com/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="branding/public/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js" type="text/javascript"></script>
  </head>

  <body id="lindat-services">
    <?php require('branding/header.htm')?>
    <div class="container-fluid">
      <div class="container">
        <!-- breadcrumb -->
        <ul class="breadcrumb">
          <li><a href="http://lindat.mff.cuni.cz/">LINDAT/CLARIN</a></li>
          <li><a href="http://lindat.mff.cuni.cz/services/">Services</a></li>
          <li class="active">Korektor</li>
        </ul>

        <!-- Service title -->
        <h1 class="text-center">Korektor</h1>

        <!-- menu -->
        <ul class="nav nav-tabs text-center" style="margin-bottom: 10px">
          <li <?php if ($main_page == 'info.php') echo ' class="active"'?>><a href="info.php"><span class="fa fa-info-circle"></span> About</a></li>
          <li <?php if ($main_page == 'demo.php') echo ' class="active"'?>><a href="demo.php"><span class="fa fa-cogs"></span> Run</a></li>
          <li <?php if ($main_page == 'api-reference.php') echo ' class="active"'?>><a href="api-reference.php"><span class="fa fa-list"></span> REST API Documentation</a></li>
        </ul>
