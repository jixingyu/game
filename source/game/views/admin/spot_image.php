<?php include('_header.php');?>

<div class="row">
    <div class="col-lg-8">
        <h1 class="page-header">找茬图片</h1>

        <div class="text-num">
            <form role="form" action="/admin/spot/editImage<?php if (isset($image['id'])) echo '/' . $image['id'];?>" method="post" enctype="multipart/form-data">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        图片设定
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label>标题</label>
                            <input type="text" name="title" style="width:200px;" value="<?php if (!empty($image['title'])) echo $image['title'];?>">
                        </div>
                        <div class="form-group">
                            <label>上传原始图片</label>
                            <input type="file" name="up_image_ori">
                            <?php if (!empty($image['image_ori'])) :?>
                            <image src="<?php echo $image['image_ori'];?>" style="max-width:600px;">
                            <?php endif;?>
                        </div>
                        <div class="form-group">
                            <label>上传修改后的图片</label>
                            <input type="file" name="up_image_mod">
                            <?php if (!empty($image['image_mod'])) :?>
                            <image src="<?php echo $image['image_mod'];?>" style="max-width:600px;">
                            <?php endif;?>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        不同点坐标设定
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>序号</th>
                                        <th>X坐标</th>
                                        <th>Y坐标</th>
                                        <th>半径(不填默认50像素)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach ($image['coordinate'] as $k => $row) :?>
                                    <tr>
                                        <td><?php echo $k + 1;?></td>
                                        <td><input type="text" name="coordinatex[]" value="<?php echo $row['x'];?>"></td>
                                        <td><input type="text" name="coordinatey[]" value="<?php echo $row['y'];?>"></td>
                                        <td><input type="text" name="radius[]" value="<?php echo isset($row['r']) ? $row['r'] : '';?>"></td>
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