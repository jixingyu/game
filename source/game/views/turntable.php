<?php include('_header.php');?>
<style type="text/css">
#desc {
	display: none;
	position: absolute;
	color: white;
	overflow-y: auto;
	width: 94%;
} 
</style>
<script type="text/javascript">
var isLogin = <?php echo $isLogin;?>;
var turntableImage = '<?php echo $image;?>';
var freeNum = <?php echo $freeNum;?>;

</script>
<script type="text/javascript" src="<?php echo base_url('assets/js/turntable.js');?>"></script>

	<div id="game"></div>
	<div id="orientation"></div>
	<div id="desc"><?php echo $desc;?></div>

<?php include('_footer.php');?>