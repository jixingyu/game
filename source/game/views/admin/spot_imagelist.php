<?php include('_header.php');?>

<div class="row">
    <div class="col-md-12">
        <h1 class="page-header">找茬图片</h1>
    </div>
    <!-- /.col-md-12 -->
</div>
<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                找茬图片
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <div class="table-responsive" style="margin-top:30px">
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th><a href="/admin/spot/editImage"><i class="fa fa-plus-square"> 添加</a></th>
                                <th>标题</th>
                                <th>修改</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($images as $key => $row) :?>
                            <tr>
                                <td><?php echo $key + 1;?></td>
                                <td><?php echo $row['title'];?></td>
                                <td><a href="/admin/spot/editImage/<?php echo $row['id'];?>">修改</a></td>
                            </tr>
                            <?php endforeach;?>
                        </tbody>
                    </table>

                    <?php if (!empty($images)) echo $this->pagination->create_links();?>
                </div>
            </div>
            <!-- /.panel-body -->
        </div>
        <!-- /.panel -->
    </div>
</div>

<?php include('_footer.php');?>