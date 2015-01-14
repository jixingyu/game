<?php include('_header.php');?>
<style type="text/css">
#desc {
	display: none;
	position: absolute;
	margin: 0px 15px 0px 15px;
	border-radius: 5px;
	padding: 2px;
	background-color: #FEF8B2;
	box-shadow: 0 0 6px rgba(0, 0, 0, 0.5);
}
.box {
	border-radius: 5px;
	font-size: 14px;
	border: 1px dashed rgba(0, 0, 0, 0.3);
}
#info-title {
	background:url(assets/turntable/info.png) no-repeat 0 0;
	padding: 3px 5px 0px 10px;
	border-radius: 3px 3px 3px 0;
	color:#ffffff;
	height:22px;
	margin:-1px;
	padding-bottom: 5px;
}
#info {
	overflow-y: auto;
	padding-left: 6px;
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
	<div id="desc">
		<div class="box">
			<div id="info-title">游戏说明：</div>
			<div id="info">
				<?php echo $desc;?>
			</div>
		</div>
	</div>

<?php include('_footer.php');?>