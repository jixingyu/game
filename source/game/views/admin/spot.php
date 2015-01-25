<?php include('_header.php');?>

<div class="row">
    <div class="col-lg-8">
        <h1 class="page-header">找茬</h1>

        <div class="text-num">
            <form role="form" action="/admin/spot" method="post" enctype="multipart/form-data">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        基础设定
                    </div>
                    <div class="panel-body">
                        <p>
                            每轮游戏初试时间
                            <input type="text" name="initial_time" value="<?php echo $config['initial_time'];?>">
                            秒，每轮游戏总共20关，每轮游戏从游戏库随机抽出20个关卡组成一个完整的一轮游戏。
                        </p>
                        <p>
                            每轮游戏送
                            <input type="text" name="free_reminder" value="<?php echo $config['free_reminder'];?>">
                            个提醒，以后每个提醒
                            <input type="text" name="reminder_points" value="<?php echo $config['reminder_points'];?>">
                            积分，总共只能消费
                            <input type="text" name="max_reminder" value="<?php echo $config['max_reminder'];?>">
                            次
                        </p>
                        <p>
                            每次点对增加时间
                            +<input type="text" name="right_add_time" value="<?php echo $config['right_add_time'];?>">
                            秒，每次点错增加时间
                            -<input type="text" name="wrong_sub_time" value="<?php echo $config['wrong_sub_time'];?>">
                            秒
                        </p>
                        <p>
                            每次延长
                            <input type="text" name="time_chunk" value="<?php echo $config['time_chunk'];?>">
                            秒消耗
                            <input type="text" name="time_chunk_points" value="<?php echo $config['time_chunk_points'];?>">
                            积分，每轮游戏只能消费
                            <input type="text" name="max_time_chunk" value="<?php echo $config['max_time_chunk'];?>">
                            次
                        </p>
                        <p>
                            游戏说明：
                            <textarea class="form-control" name="description" rows="3"><?php echo $config['description'];?></textarea>
                        </p>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        奖励设定(每账号限1次)
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped mission">
                                <thead>
                                    <tr>
                                        <th><a href="javascript:void(0);" onclick="addMission();"><i class="fa fa-plus-square"> 添加</a></th>
                                        <th>过关数</th>
                                        <th>奖励积分</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($config['mission'] as $k => $mission) :?>
                                    <tr>
                                        <td><?php echo $k + 1;?></td>
                                        <td><input type="text" name="mlevel[]" value="<?php echo $mission['level'];?>"></td>
                                        <td><input type="text" name="mpoints[]" value="<?php echo $mission['points'];?>"></td>
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
<script type="text/javascript">
function addMission() {
    id = $("table.mission tr").length;
    var text = '<tr>'
             + '<td>' + id + '</td>'
             + '<td><input type="text" name="mlevel[]" value=""></td>'
             + '<td><input type="text" name="mpoints[]" value=""></td>'
             + '</tr>';
    $("table.mission tbody").append(text);
}
</script>

<?php include('_footer.php');?>