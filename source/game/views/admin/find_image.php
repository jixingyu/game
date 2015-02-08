<?php include('_header.php');?>

<div class="row">
    <div class="col-lg-8">
        <h1 class="page-header">找东西图片</h1>

        <div class="text-num">
            <form role="form" action="/admin/find/editImage<?php if (isset($image['id'])) echo '/' . $image['id'];?>" method="post" enctype="multipart/form-data">
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
                            <label>上传图片</label>
                            <input type="file" name="up_image">
                            <?php if (!empty($image['path'])) :?>
                            <image src="<?php echo $image['path'];?>" style="max-width:600px;">
                            <?php endif;?>
                        </div>
                        <div class="form-group">
                            <label>关联标签</label>
                            <div>
                            <?php foreach ($taglist as $key => $val) :?>
                                <label class="checkbox-inline">
                                    <input type="checkbox" value="<?php echo $val['id'];?>" name="tags[]" <?php if (isset($val['checked']) && $val['checked']) echo 'checked="checked"';?>><?php echo $val['name'];?>
                                </label>
                            <?php endforeach;?>
                            <div>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">提交</button>
            </form>
        </div>
    </div>
</div>

<?php include('_footer.php');?>