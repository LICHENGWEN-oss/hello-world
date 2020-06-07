<%@ page language="C#" masterpagefile="~/MasterPage.master" autoeventwireup="true" inherits="JSSZ_JSSZ, App_Web_iu4tvaae" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
        <input type="button" class="button5"  value="刷新" onclick ="getlist('', '', '')" />
        <input class="button5" onclick="jsAddData()" type="button" value="添加" />  
        <input type="button" class="button5" value="删除" onclick="Del()" />
        <input type="button" class="button5" value="取消删除" onclick="Cdel()" />
        <input id="Button11" class="button5"  type="button" value="保存"  onclick="SetValues()" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" Runat="Server">
    <div id="divTreeListView"></div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder4" Runat="Server">
<input type="hidden" id="hidindexid" value="JSDM" />
<input type="hidden"   id="hidcheckid" />
//<input type="hidden" id="hidNewLine" />   
//<input type="hidden" id="hide_par" runat="server" /> 
//<input type="hidden" id="HidMc" runat="server" /> 
<input type="hidden" id="hide_ccjb" runat="server" /> 
<script type="text/javascript">
    $(document).ready(function () {
        getlist('', '', '');
    });
    //获得列表
    function getlist(objtr, objid, intimagecount) {
        var rtnstr = JSSZ_JSSZ.LoadList(objtr, objid, intimagecount).value;
        if (objtr == "" && objid == "" && intimagecount == "")
            document.getElementById("divTreeListView").innerHTML = rtnstr;
        //角色名称不能重复
        $("#divTreeListView tr").find("input[name^='txtNAME']").change(function () {
            var par = this.parentNode.parentNode.id;
            var parvalue = $("#" + par + " input[name^='txtNAME']").val(); //找到当前行的角色名
            var selmbwj = $("#divTreeListView tr[id!='" + par + "']").find("input[name^='txtNAME']"); //找到所有的角色名
            var count = 0;
            for (var i = 0; i < selmbwj.length; i++) {
                var values = selmbwj[i].value;
                if (values == parvalue) {
                    count += 1;
                }
                else {
                    count;
                }
            }
            if (count > 0) {
                alert("角色名不能重复...");
                $("#" + par + " input[name^='txtNAME']").val("");
            }
        });
    }

    //添加数据
    function jsAddData() {
        if ($("#hidNewLine").val() == "")
            $("#hidNewLine").val(JSSZ_JSSZ.AddData().value);
        $("#divTreeListView table").append($("#hidNewLine").val().replace('{000}', $("#divTreeListView tr").length).replace('{000}', $("#divTreeListView tr").length));
        //角色名称不能重复
        $("#divTreeListView tr").find("input[name^='txtNAME']").change(function () {
            var par = this.parentNode.parentNode.id;
            var parvalue = $("#" + par + " input[name^='txtNAME']").val(); //找到当前行的角色名
            var selmbwj = $("#divTreeListView tr[id!='" + par + "']").find("input[name^='txtNAME']"); //找到所有的角色名
            var count = 0;
            for (var i = 0; i < selmbwj.length; i++) {
                var values = selmbwj[i].value;
                if (values == parvalue) {
                    count += 1;
                }
                else {
                    count;
                }
            }
            if (count > 0) {
                alert("角色名不能重复...");
                $("#" + par + " input[name^='txtNAME']").val("");
            }
        });
    }
    function SetValues() {
        var nameValue="";
        var name = $("#divTreeListView input[name^=txtNAME]");
        for (var i = 0; i < name.length; i++) {
            if (name[i].value.replace(/(\s*$)/g, "") == "") {
                //alert("名称不能为空！");
                nameValue = "名称不能为空！";
               break;
            }
       }
        var objnulls = $("[ISNULLS=N]");
        var strnullmessage = "";
        for (i = 0; i < objnulls.length; i++) {
            if (objnulls[i].value == "") {
                strnullmessage = '"' + objnulls[i].getAttribute("ISNULLMESSAGE") + '"不能为空';
                break;
            }
        }
        obj = document.getElementsByName("readimage");
        var delid = "";
        var edtid = new Array();
        var edtobjfileds = "";
        var edtobjvalues = new Array();
        objss = $("img[name=readimage][src$='delete.gif']").parent().parent(); //删除
        for (var i = 0; i < objss.length; i++) {
            delid = delid + ',' + $("#" + objss[i].id + " td[name$=td" + $("#hidindexid").val() + "]").html();
            if (delid == ",1" || delid == ",2") {
                var delnulls = $("[ISNULLS=N]");
                var delnullmessage = "";
                for (j = 0; j < delnulls.length; j++) {
                    if (delnulls[j].value == "SYSTEM" || delnulls[j].value == "everyone") {
                        delnullmessage = '"' + delnulls[j].value + '"是系统固定角色不能删除';
                        alert(delnullmessage);
                        return false;
                    }
                }
            }
            else {
                break;
            }
        }
        objss = $("img[src$='edit.jpg'],img[src$='new.jpg']").parent().parent(); //新增和修改
        for (var i = 0; i < objss.length; i++) {
            if (strnullmessage != "") {
                alert(strnullmessage);
                return false;
            }
            if (nameValue != "") {
                alert(nameValue);
                return false;
            }
            var objtd = $("tr[id=" + objss[i].id + "] td");
            var objfileds = "";
            var objvalues = "";
            for (var j = 2; j < objtd.length; j++) {
                if (objtd[j].getAttribute("name") == "td" + $("#hidindexid").val())
                    edtid[edtid.length] = objtd[j].innerHTML;
                else {
                    var objinput = objtd[j].getElementsByTagName("input");
                    if (objinput.length > 0) {
                        if (objinput[0].name.substring(0, 3) == "txt") {
                            objvalues += "|" + objinput[0].value;
                            objfileds += "," + objinput[0].name.substring(3);
                        }
                        else if (objinput[0].name.substring(0, 3) == "sel") {
                            objvalues += "|" + objinput[0].value;
                            objfileds += "," + objinput[0].name.substring(3);
                        }
                        else if (objinput[0].name.substring(0, 3) == "chk") {
                            if (objinput[0].checked)
                                objvalues += "|1";
                            else
                                objvalues += "|0";
                            objfileds += "," + objinput[0].name.substring(3);
                        } else if (objinput[0].name.substring(0, 4) == "tsel") {
                            //                        objvalues += "|" + objinput[0].value.split('.')[0];
                            objvalues += "|" + objinput[0].value;
                            objfileds += "," + objinput[0].name.substring(4);
                        }
                    }
                    else {
                        objinput = objtd[j].getElementsByTagName("select");
                        if (objinput.length > 0) {
                            objvalues += "|" + objinput[0].value;
                            objfileds += "," + objinput[0].name.substring(3);
                        }
                    }
                }
            }
            if (objfileds != "") {
                edtobjfileds = objfileds.substring(1);
                edtobjvalues[edtobjvalues.length] = objvalues.substring(1);
            }
        }
        if (edtobjfileds.length > 0)
            jsUpdateData(edtid, edtobjfileds, edtobjvalues);
        if (delid != "")
            jsDeleteData(delid.substring(1));
        $("#hidcheckid").val("");
        getlist('', '', '');
        return true;
    }

    //修改数据
    function jsUpdateData(objid, objfileds, objvalues) {
            var rtn = JSSZ_JSSZ.UpdateData(objid, objfileds, objvalues).value;
            if (rtn != "" && rtn.substring(0, 1) == "0") {
                if (rtn.length > 1) {
                    alert(rtn.substring(1));
                }
            }
            else {
                alert("保存成功！");
            }
        }
   //删除
        function jsDeleteData(obj) {
            var detjs = JSSZ_JSSZ.DeleteJsdm(obj).value;
            if (detjs) {
                alert("此角色已在流程中设置，请先删除流程后，在删除该角色！");
            }
            else {
                var rtn = JSSZ_JSSZ.DeleteData(obj).value;
                alert(rtn);
            }
    }
    
</script>
</asp:Content>
