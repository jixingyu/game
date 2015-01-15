<?php include('_header.php');?>
<script type="text/javascript">
var config = '<?php echo $config;?>';
config = JSON.parse(config);
</script>
<script type="text/javascript" src="<?php echo base_url('assets/js/spot.js');?>"></script>

	<div id="game"></div>
	<div id="orientation"></div>

<?php include('_footer.php');?>