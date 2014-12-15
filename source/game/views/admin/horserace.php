<?php include('_header.php');?>

<div class="row">
    <div class="col-lg-8">
        <h1 class="page-header">赛马</h1>

        <div class="text-num">
            <form role="form" action="/admin/turntable" method="post" enctype="multipart/form-data">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        设定
                    </div>
                    <div class="panel-body">
                        <p>
                            每天免费转盘次数
                            <input type="text" name="free_num" value="<?php echo $config['free_num'];?>">
                            次，每次转盘消耗
                            <input type="text" name="consume_points" value="<?php echo $config['consume_points'];?>">
                            积分
                        </p>
                        <p>
                            1等奖
                            <input type="text" name="points1" value="<?php echo $config['points'][1];?>">
                            积分；2等奖
                            <input type="text" name="points2" value="<?php echo $config['points'][2];?>">
                            积分；鼓励奖
                            <input type="text" name="points3" value="<?php echo $config['points'][3];?>">
                            积分
                        </p>
                        <p>
                            初始几率设定为：
                            <input type="text" name="prob1" value="<?php echo $config['prob'][1];?>">%，
                            <input type="text" name="prob2" value="<?php echo $config['prob'][2];?>">%，
                            <input type="text" name="prob3" value="<?php echo $config['prob'][3];?>">%，
                            <?php echo 100 - $config['prob'][1] - $config['prob'][2] - $config['prob'][3];?>%
                        </p>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        进阶设定
                    </div>
                    <div class="panel-body">
                        <p>每个账号有连续计数项</p>
                        <p>单个账号，每
                        <input type="text" name="range2" value="<?php echo $config['range'][2];?>">
                        次必中1次2等奖，每
                        <input type="text" name="range1" value="<?php echo $config['range'][1];?>">
                        次必中1次1等奖，</p>
                        <p>当几率或者必中奖后，连续基数未到要求的，则无法再次获得该奖，例如：每百次中1次2等奖，玩家在第56次中2等奖，则第57到第100次都不会再中2等奖，101次开始重新统计；</p>

                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        总体设定
                    </div>
                    <div class="panel-body">
                        <p>
                            当天中奖总次数：1等奖达到
                            <input type="text" name="max1" value="<?php echo $config['max'][1];?>">
                            次，2等奖达到
                            <input type="text" name="max2" value="<?php echo $config['max'][2];?>">
                            次，参与奖达到
                            <input type="text" name="max3" value="<?php echo $config['max'][3];?>">
                            次，则所有账号不会再次出现奖励
                        </p>
                        <p>
                            奖品具体内容可通过游戏后台设置
                        </p>
                        <p>
                            每日零点，游戏后台根据当天中奖概率、客户访问量统计数据，出具相应报表，业务人员可根据情况调整中奖概率
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
                        <p>
                            奖品角度范围：
                            鼓励奖
                            <input type="text" name="angle0" value="<?php echo $config['angle'][0];?>">
                            , 1等奖
                            <input type="text" name="angle1" value="<?php echo $config['angle'][1];?>">
                            ，2等奖
                            <input type="text" name="angle2" value="<?php echo $config['angle'][2];?>">
                            ，3等奖
                            <input type="text" name="angle3" value="<?php echo $config['angle'][3];?>">
                        </p>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">提交</button>
            </form>
        </div>
    </div>
</div>

<?php include('_footer.php');?>