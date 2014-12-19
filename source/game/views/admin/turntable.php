<?php include('_header.php');?>

<div class="row">
    <div class="col-lg-8">
        <h1 class="page-header">转盘</h1>

        <div class="text-num">
            <form role="form" action="/admin/turntable" method="post" enctype="multipart/form-data">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        基础设定
                    </div>
                    <div class="panel-body">
                        <p>
                            每天免费转盘次数
                            <input type="text" name="free_num" value="<?php echo $config['free_num'];?>">
                            次，每次转盘消耗
                            <input type="text" name="consume_points" value="<?php echo $config['consume_points'];?>">
                            积分
                        </p>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        转盘图片
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label>上传转盘图片(PNG)</label>
                            <input type="file" name="upImage">
                        </div>
                        <?php if (!empty($config['image'])) :?>
                        <image src="<?php echo $config['image'];?>">
                        <?php endif;?>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        奖励设定
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>中奖几率(1位小数)</th>
                                        <th>奖品(数字则为积分)</th>
                                        <th>必中次数</th>
                                        <th>每天中奖数限制</th>
                                        <th>奖品角度范围</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($prizeArr as $prize) :?>
                                    <tr>
                                        <td><?php echo $prize;?>等奖</td>
                                        <td><input type="text" name="prob<?php echo $prize;?>" value="<?php echo $config['prob'][$prize];?>">%</td>
                                        <td><input type="text" style="width:100px" name="awards<?php echo $prize;?>" value="<?php echo $config['awards'][$prize];?>"></td>
                                        <td><input type="text" name="range<?php echo $prize;?>" value="<?php echo $config['range'][$prize];?>"></td>
                                        <td><input type="text" name="max<?php echo $prize;?>" value="<?php echo $config['max'][$prize];?>"></td>
                                        <td><input type="text" name="angle<?php echo $prize;?>" value="<?php echo $config['angle'][$prize];?>"></td>
                                    </tr>
                                    <?php endforeach;?>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.table-responsive -->
                    </div>
                    <!-- /.panel-body -->
                </div>

                <button type="submit" class="btn btn-primary">提交</button>
            </form>
        </div>
    </div>
</div>

<?php include('_footer.php');?>