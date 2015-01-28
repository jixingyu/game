<?php include('_header.php');?>
<style type="text/css">
#desc {
	display: none;
	position: absolute;
	color: #C0572D;
	overflow-y: auto;
}
</style>
<script type="text/javascript">
var isLogin = <?php echo $isLogin;?>;
var turntableImage = '<?php echo $image;?>';
var freeNum = <?php echo $freeNum;?>;
var todayNum = <?php echo $todayNum;?>;
var consumePoints = <?php echo $consumePoints;?>;
var nickname = '<?php echo $nickname ?: "匿名";?>';
var userpoints = <?php echo $points;?>;
var desc = "<?php echo $desc;?>";
</script>
<script type="text/javascript" src="<?php echo base_url('assets/js/turntable.js');?>"></script>

	<div id="game"></div>
	<div id="orientation"></div>

<?php include('_footer.php');?>