<%@ page language="C#" autoeventwireup="true" inherits="JSSZ_YHQX, App_Web_iu4tvaae" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<link rel="stylesheet" type="text/css" href="../Content/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../Content/themes/icon.css" />
	<link rel="stylesheet" type="text/css" href="../CSS/demo.css" />
    <link href="../CSS/style1.css" type="text/css" rel="stylesheet" />
    <link href="../CSS/style.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="../JS/jquery.min.js"></script>
    <script type="text/javascript" src="../JS/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../JS/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../JS/mainScript.js"></script>
    <script type="text/javascript" src="../JS/Main.js"></script>
    <script src="../JS/Jpageoffice.js" type="text/javascript"></script>
    <script src="../WdatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
    function setNodeStyle(text, jsdm) {
        var objs = document.getElementById("TreeVie").getElementsByTagName("a");
        $("#TreeVie a").css('fontWeight', '');
        for (var i = 0; i < objs.length; i++) {
            if (objs[i].innerText == text) {
                objs[i].style.fontWeight = "bold";
                $("#ifr12").attr("src", "USERQX.aspx?JSDM=" + jsdm + "");
            }
        }
    }
</script>
</head>
<body>
    <form runat="server" class="easyui-layout" fit="true" style="width:100%; height:100%;"  >
        <div data-options="region:'west'" title="角色名称"  style="width:20%;">
            <div style="width:100%; height:100%;" id="TreeVie">
                <asp:TreeView runat="server" ID="TreeView1"></asp:TreeView>
            </div>
        </div>
        <div  data-options="region:'center'"  title="角色授权" style="width:80%;">
             <iframe  id="ifr12" name="ifr" style="width: 100%; height:100%;"frameborder="0"; marginheight="0" marginwidth="0"></iframe>
        </div>         
    </form>   
</body>
</html>