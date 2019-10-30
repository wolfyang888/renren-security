$(function () {
    $("#jqGrid").jqGrid({
        url: baseURL + 'sys/sysuserrole/list',
        datatype: "json",
        colModel: [			
			{ label: 'id', name: 'id', index: 'id', width: 50, key: true },
			{ label: '用户ID', name: 'userId', index: 'user_id', width: 80 }, 			
			{ label: '角色ID', name: 'roleId', index: 'role_id', width: 80 }			
        ],
		viewrecords: true,
        height: 385,
        rowNum: 10,
		rowList : [10,30,50],
        rownumbers: true, 
        rownumWidth: 25, 
        autowidth:true,
        multiselect: true,
        pager: "#jqGridPager",
        jsonReader : {
            root: "page.list",
            page: "page.currPage",
            total: "page.totalPage",
            records: "page.totalCount"
        },
        prmNames : {
            page:"page", 
            rows:"limit", 
            order: "order"
        },
        gridComplete:function(){
        	//隐藏grid底部滚动条
        	$("#jqGrid").closest(".ui-jqgrid-bdiv").css({ "overflow-x" : "hidden" }); 
        }
    });
});
var setting = {
    data: {
        simpleData: {
            enable: true,
            idKey: "username",
            pIdKey: "deptId",
            rootPId: 1
        },
        key: {
            url:"nourl",
            name:"username",
        }
    }
};
var ztree;

var role_setting = {
    data: {
        simpleData: {
            enable: true,
            idKey: "role_name",
            pIdKey: "deptId",
            rootPId: 1
        },
        key: {
            url:"nourl",
            name:"roleName",
        }
    }
};
var role_ztree;


var vm = new Vue({
	el:'#rrapp',
	data:{
		showList: true,
		title: null,
		sysUserRole: {},
        roleList:{},
        user:{},
	},
	methods: {
		query: function () {
			vm.reload();
		},
		add: function(){
			vm.showList = false;
			vm.title = "新增";
			vm.sysUserRole = {id:null,userId:null,roleId:null};

			// 获取用户信息sysUserRole

			vm.getUserTree();
            //获取角色信息
            this.getRoleList();
		},
		update: function (event) {
			var id = getSelectedRow();
			if(id == null){
				return ;
			}
			vm.showList = false;
            vm.title = "修改";
            
            vm.getInfo(id)
		},
		saveOrUpdate: function (event) {
		    $('#btnSaveOrUpdate').button('loading').delay(1000).queue(function() {
                var url = vm.sysUserRole.id == null ? "sys/sysuserrole/save" : "sys/sysuserrole/update";
                $.ajax({
                    type: "POST",
                    url: baseURL + url,
                    contentType: "application/json",
                    data: JSON.stringify(vm.sysUserRole),
                    success: function(r){
                        if(r.code === 0){
                             layer.msg("操作成功", {icon: 1});
                             vm.reload();
                             $('#btnSaveOrUpdate').button('reset');
                             $('#btnSaveOrUpdate').dequeue();
                        }else{
                            layer.alert(r.msg);
                            $('#btnSaveOrUpdate').button('reset');
                            $('#btnSaveOrUpdate').dequeue();
                        }
                    }
                });
			});
		},
		del: function (event) {
			var ids = getSelectedRows();
			if(ids == null){
				return ;
			}
			var lock = false;
            layer.confirm('确定要删除选中的记录？', {
                btn: ['确定','取消'] //按钮
            }, function(){
               if(!lock) {
                    lock = true;
		            $.ajax({
                        type: "POST",
                        url: baseURL + "sys/sysuserrole/delete",
                        contentType: "application/json",
                        data: JSON.stringify(ids),
                        success: function(r){
                            if(r.code == 0){
                                layer.msg("操作成功", {icon: 1});
                                $("#jqGrid").trigger("reloadGrid");
                            }else{
                                layer.alert(r.msg);
                            }
                        }
				    });
			    }
             }, function(){
             });
		},
		getInfo: function(id){
			$.get(baseURL + "sys/sysuserrole/info/"+id, function(r){
                vm.sysUserRole = r.sysUserRole;
            });
		},
		reload: function (event) {
			vm.showList = true;
			var page = $("#jqGrid").jqGrid('getGridParam','page');
			$("#jqGrid").jqGrid('setGridParam',{ 
                page:page
            }).trigger("reloadGrid");
		},
        // 获取角色列表
        getRoleList: function(){
            $.get(baseURL + "sys/role/select", function(r){
                role_ztree = $.fn.zTree.init($("#roleTree"), role_setting, r.list);
                var node = role_ztree.getNodeByParam("roleName", vm.sysUserRole.role_name);
                vm.roleList = r.list;
                if(node != null){
                    ztree.selectNode(node);
                    vm.sysUserRole.role_name = node.roleName;
                }
            });
        },
        // 获取用户列表
        getUserTree: function(){
            //加载用户树
            $.get(baseURL + "sys/user/list/", function(r){
                ztree = $.fn.zTree.init($("#userTree"), setting, r.page.list);
                var node = ztree.getNodeByParam("username", vm.user.username);
                if(node != null){
                    ztree.selectNode(node);
                    vm.sysUserRole.userId = node.userId;
                }

            })

        },
        // 显示树性控件
        userTree: function(){
            layer.open({
                type: 1,
                offset: '50px',
                skin: 'layui-layer-molv',
                title: "选择用户",
                area: ['300px', '450px'],
                shade: 0,
                shadeClose: false,
                content: jQuery("#userLayer"),
                btn: ['确定', '取消'],
                btn1: function (index) {
                    var node = ztree.getSelectedNodes();
                    //选择上级部门
                    vm.sysUserRole.userId = node[0].userId;
                    layer.close(index);
                }
            });
        },
        // 显示树性控件
        roleTree: function(){
            layer.open({
                type: 1,
                offset: '50px',
                skin: 'layui-layer-molv',
                title: "选择角色",
                area: ['300px', '450px'],
                shade: 0,
                shadeClose: false,
                content: jQuery("#roleLayer"),
                btn: ['确定', '取消'],
                btn1: function (index) {
                    var node = role_ztree.getSelectedNodes();
                    //选择上级部门
                    vm.sysUserRole.roleId = node[0].roleId;
                    layer.close(index);
                }
            });
        },
        getDept: function(){
            //加载部门树
            $.get(baseURL + "sys/dept/list", function(r){
                ztree = $.fn.zTree.init($("#deptTree"), setting, r);
                var node = ztree.getNodeByParam("deptId", vm.user.deptId);
                if(node != null){
                    ztree.selectNode(node);

                    vm.user.deptName = node.name;
                }
            })
        },
	}
});