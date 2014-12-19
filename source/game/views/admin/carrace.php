<?php include('_header.php');?>

<div class="row">
    <div class="col-lg-8">
        <h1 class="page-header">赛车</h1>

        <div class="text-num">
            <form role="form" action="/admin/carrace" method="post" enctype="multipart/form-data">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        基础设定
                    </div>
                    <div class="panel-body">
                        <p>
                            每注积分
                            <input type="text" name="chip" value="<?php echo $config['chip'];?>">
                        </p>
                        <p>
                            当用户连续赢
                            <input type="text" name="cont_win_num" value="<?php echo $config['cont_win_num'];?>">
                            次，则接下来
                            <input type="text" name="force_lose_num" value="<?php echo $config['force_lose_num'];?>">
                            次必输，然后重新计数；
                        </p>
                        <p>
                            当用户累计输
                            <input type="text" name="lose_num" value="<?php echo $config['lose_num'];?>">
                            场次比赛或者累计输
                            <input type="text" name="lose_points" value="<?php echo $config['lose_points'];?>">
                            积分，可以在下次下注
                            <input type="text" name="force_win_points" value="<?php echo $config['force_win_points'];?>">
                            以下的情况下必中一次，然后重新计数。
                        </p>
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
                                        <th>奖励倍数</th>
                                        <th>排除概率</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($prizeArr as $prize) :?>
                                    <tr>
                                        <td>第<?php echo $prize;?>名</td>
                                        <td><input type="text" name="multiple<?php echo $prize;?>" value="<?php echo $config['multiple'][$prize];?>"></td>
                                        <td><input type="text" name="exclude_prob<?php echo $prize;?>" value="<?php echo $config['exclude_prob'][$prize];?>">%</td>
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