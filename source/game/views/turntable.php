<?php include('_header.php');?>
<script type="text/javascript">
var isLogin = <?php echo $isLogin;?>;
var turntableImage = '<?php echo $image;?>';
var freeNum = <?php echo $freeNum;?>;
var desc = "<?php echo $desc;?>";
</script>
<script type="text/javascript" src="<?php echo base_url('assets/js/turntable.js');?>"></script>

	<div id="game"></div>
	<div id="orientation"></div>
	<div id="desc" style="display:none;"><?php echo $desc;?></div>

<script type="text/javascript">

</script>
<?php include('_footer.php');?>