<!DOCTYPE html>
<html>
    
<head>
  <meta charset="utf-8" />
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
  <meta name="viewport" content="user-scalable=0, initial-scale=1, minimum-scale=1, maximum-scale=1, width=device-width, minimal-ui=1">

  <title><?php echo $title;?></title>
  <link rel="stylesheet" href="assets/css/sweet-alert.css">
  <script src="assets/js/sweet-alert.min.js"></script>
  <script type="text/javascript" src="<?php echo base_url('assets/js/phaser-no-physics.min.js');?>"></script>
  <script type="text/javascript" src="<?php echo base_url('assets/js/ajax.js');?>"></script>
</head>

<body style="margin:0;" bgcolor="<?php echo isset($bgcolor) ? $bgcolor : 'black'; ?>">

