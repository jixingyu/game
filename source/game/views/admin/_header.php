<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>游戏后台</title>

    <link href="<?php echo base_url('assets/css/bootstrap.min.css');?>" rel="stylesheet">
    <link href="<?php echo base_url('assets/css/plugins/metisMenu/metisMenu.min.css');?>" rel="stylesheet">
    <link href="<?php echo base_url('assets/css/sb-admin-2.css');?>" rel="stylesheet">
    <link href="<?php echo base_url('assets/font-awesome-4.1.0/css/font-awesome.min.css');?>" rel="stylesheet" type="text/css">
    <link href="<?php echo base_url('assets/css/game.css');?>" rel="stylesheet">
</head>

<body>

    <div class="wrapper">

<?php
    $tab    = $this->uri->segment(2);
    $subTab = $this->uri->segment(3);
?>

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		    <div class="navbar-header">
		        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
		            <span class="sr-only">Toggle navigation</span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		            <span class="icon-bar"></span>
		        </button>
		        <a class="navbar-brand" href="index.html">Admin</a>
		    </div>
		    <!-- /.navbar-header -->

		    <ul class="nav navbar-top-links navbar-right">
		        <!-- /.dropdown -->
		        <li class="dropdown">
		            <a class="dropdown-toggle" data-toggle="dropdown" href="#">
		            	<?php echo $username;?>
		                <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
		            </a>
		            <ul class="dropdown-menu dropdown-user">
		                <li><a href="/admin/passport/resetPwd"><i class="fa fa-gear fa-fw"></i> 重置密码</a>
		                </li>
		                <li class="divider"></li>
		                <li><a href="/admin/logout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
		                </li>
		            </ul>
		            <!-- /.dropdown-user -->
		        </li>
		        <!-- /.dropdown -->
		    </ul>
		    <!-- /.navbar-top-links -->

		    <div class="navbar-default sidebar" role="navigation">
		        <div class="sidebar-nav navbar-collapse">
		            <ul class="nav" id="side-menu">
		                <li<?php echo ($tab == 'dashboard') ? ' class="active"' : '';?>>
		                    <a href="/admin/dashboard"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
		                </li>
		                <li<?php echo ($subTab == 'resetPwd') ? ' class="active"' : '';?>>
		                    <a href="/admin/passport/resetPwd"><i class="fa fa-edit fa-fw"></i> 重置密码</a>
		                </li>
		                <li<?php echo ($tab == 'turntable') ? ' class="active"' : '';?>>
		                    <a href="#"><i class="fa fa-edit fa-fw"></i> 转盘<span class="fa arrow"></span></a>
		                    <ul class="nav nav-second-level">
		                        <li>
		                            <a href="/admin/turntable">游戏参数配置</a>
		                        </li>
		                        <li>
		                            <a href="">统计</a>
		                        </li>
		                    </ul>
		                    <!-- /.nav-second-level -->
		                </li>
		                <li<?php echo ($tab == 'carrace') ? ' class="active"' : '';?>>
		                    <a href="#"><i class="fa fa-edit fa-fw"></i> 赛马 / 赛车<span class="fa arrow"></span></a>
		                    <ul class="nav nav-second-level">
		                        <li>
		                            <a href="">游戏参数配置</a>
		                        </li>
		                        <li>
		                            <a href="">统计</a>
		                        </li>
		                    </ul>
		                    <!-- /.nav-second-level -->
		                </li>
		                <li<?php echo ($tab == 'quickspot') ? ' class="active"' : '';?>>
		                    <a href="#"><i class="fa fa-edit fa-fw"></i> 找茬<span class="fa arrow"></span></a>
		                    <ul class="nav nav-second-level">
		                        <li>
		                            <a href="">游戏参数配置</a>
		                        </li>
		                        <li>
		                            <a href="">统计</a>
		                        </li>
		                    </ul>
		                    <!-- /.nav-second-level -->
		                </li>
		                <li<?php echo ($tab == 'finding') ? ' class="active"' : '';?>>
		                    <a href="#"><i class="fa fa-edit fa-fw"></i> 找东西<span class="fa arrow"></span></a>
		                    <ul class="nav nav-second-level">
		                        <li>
		                            <a href="">游戏参数配置</a>
		                        </li>
		                        <li>
		                            <a href="">统计</a>
		                        </li>
		                    </ul>
		                    <!-- /.nav-second-level -->
		                </li>
		                <li>
		                    <a href="#"><i class="fa fa-sitemap fa-fw"></i> Multi-Level Dropdown<span class="fa arrow"></span></a>
		                    <ul class="nav nav-second-level">
		                        <li>
		                            <a href="#">Second Level Item</a>
		                        </li>
		                        <li>
		                            <a href="#">Second Level Item</a>
		                        </li>
		                        <li>
		                            <a href="#">Third Level <span class="fa arrow"></span></a>
		                            <ul class="nav nav-third-level">
		                                <li>
		                                    <a href="#">Third Level Item</a>
		                                </li>
		                                <li>
		                                    <a href="#">Third Level Item</a>
		                                </li>
		                                <li>
		                                    <a href="#">Third Level Item</a>
		                                </li>
		                                <li>
		                                    <a href="#">Third Level Item</a>
		                                </li>
		                            </ul>
		                            <!-- /.nav-third-level -->
		                        </li>
		                    </ul>
		                    <!-- /.nav-second-level -->
		                </li>
		            </ul>
		        </div>
		        <!-- /.sidebar-collapse -->
		    </div>
		    <!-- /.navbar-static-side -->
		</nav>