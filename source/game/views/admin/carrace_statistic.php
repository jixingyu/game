<?php include('_header.php');?>

<div class="row">
    <div class="col-md-12">
        <h1 class="page-header">统计</h1>
    </div>
    <!-- /.col-md-12 -->
</div>
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                赛车
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <form class="form-inline" role="form" action="/admin/turntable/statistic" method="get">
                    <!-- /.table-responsive -->
                    <div class="form-group">
                        <label class="control-label">开始：</label>
                        <div class="input-group date date_start" data-date-format="yyyy-mm-dd" data-link-format="yyyy-mm-dd">
                            <input class="form-control" size="10" name="start" type="text" value="<?php echo $start;?>" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label">结束：</label>
                        <div class="input-group date date_end" data-date-format="yyyy-mm-dd" data-link-format="yyyy-mm-dd">
                            <input class="form-control" size="10" name="end" type="text" value="<?php echo $end;?>" readonly>
                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                        </div>
                    </div>
                    <input name="submit" type="submit" class="btn btn-primary" value="确定">
                    <input name="button" type="button" class="btn btn-primary" value="导出Excel">
                </form>

                <?php if (empty($logs)) :?>
                    <h4 class="text-center" style="margin-top:30px">没有记录</h4>
                <?php else :?>
                    <div class="table-responsive" style="margin-top:30px">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>UID</th>
                                    <th>消耗积分</th>
                                    <th>摇奖结果</th>
                                    <th>时间</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($logs as $key => $row) :?>
                                <tr>
                                    <td><?php echo $row['uid'];?></td>
                                    <td><?php echo $row['consume_points'];?></td>
                                    <td class="center"><?php echo $row['prize'] ? $row['prize'] . '等奖' : '未中奖'; ?></td>
                                    <td class="center"><?php echo date('Y-m-d H:i', $row['create_time']);?></td>
                                </tr>
                                <?php endforeach;?>
                            </tbody>
                        </table>
                        <?php echo $this->pagination->create_links();?>
                    </div>
                <?php endif;?>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
</div>

<!-- /#page-wrapper -->
<script type="text/javascript">
    $('.date_start').datetimepicker({
        language:  'zh-CN',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
    $('.date_end').datetimepicker({
        language:  'zh-CN',
        weekStart: 1,
        todayBtn:  1,
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2,
        forceParse: 0
    });
</script>

<?php include('_footer.php');?>