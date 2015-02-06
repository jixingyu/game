<?php include('_header.php');?>

<div class="row">
    <div class="col-lg-8">
        <h1 class="page-header"><?php if (isset($tag['id'])) echo '修改标签'; else echo '新增标签';?></h1>

        <div class="text-num">
            <form role="form" action="/admin/find/editTag<?php if (isset($tag['id'])) echo '/' . $tag['id'];?>" method="post" enctype="multipart/form-data">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        标签设定
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label>标签名</label>
                            <input type="text" name="name" style="width:200px;" value="<?php if (!empty($tag['name'])) echo $tag['name'];?>">
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">提交</button>
            </form>
        </div>
    </div>
</div>

<?php include('_footer.php');?>