<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SnmpTest.aspx.cs" Inherits="SnmpTest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" Runat="Server">
    <style type="text/css">
        .table{
            /*width:auto !important;*/
            font-size:smaller !important;
        }
        img{
            width:24px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" Runat="Server">
    <div class="form-group">
        <asp:TextBox ID="tbOid" runat="server" CssClass="form-control"></asp:TextBox>
        <asp:LinkButton ID="lbGet" runat="server" CssClass="btn btn-danger" OnClick="lbGet_Click">Test Oid</asp:LinkButton>
    </div>
    <asp:GridView ID="gv" runat="server">

    </asp:GridView>
    <div class="row">
        <div class="col-md-10">
            <div class="col-md-12">

                <div class="card text-center">
                    <div class="card-header">
                        10.0.100.100 - darcane
                    </div>
                    <div class="card-body">
                        <table class="table table-sm table-bordered bg-secondary text-white p-3">
                            <tbody>
                                <tr>
                                    <td>Fa0/1<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/2<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/3<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/4<br/><img src="Content/ico_green.png" /></td>
                                    <td>Fa0/5<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/6<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/7<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/8<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/9<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/10<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/11<br/><img src="Content/ico_red.png" /></td>
                                    <td colspan="2">LOGO</td>
                                    <%--<td rowspan="2" class="align-items-center"><img src="https://dwglogo.com/wp-content/uploads/2016/05/Cisco_logo.svg_.png" height="126"/></td>--%>
                                </tr>
                                <tr>
                                    <td>Fa0/12<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/13<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/14<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/15<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/16<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/17<br/><img src="Content/ico_yellow.png" /></td>
                                    <td>Fa0/18<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/19<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/20<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/21<br/><img src="Content/ico_red.png" /></td>
                                    <td>Fa0/22<br/><img src="Content/ico_red.png" /></td>
                                    <td>Gi0/1<br/><img src="Content/ico_red.png" /></td>
                                    <td>Gi0/2<br/><img src="Content/ico_red.png" /></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div id="test" class=""></div>
            </div>
        </div>
        <div class="text-center col-md-2 border border-danger">
            &nbsp;
        </div>
    </div>
    <span id="tableJson" data-content='{"fa": 48, "gi" : 2, "con" : [4,6,11], "gicon": [1,2], "ip" : "10.0.100.100", "host" : "darcane" }'></span>
    <div class="row">
    </div>
    

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" Runat="Server">
    <script type="text/javascript">
        $(document).ready(() => {
            var tableJson = $("#tableJson").data('content');

            var div = $("<div>").addClass("card text-center");
            var divHeader = $("<div>").addClass("card-header").html(tableJson.ip + " - " + tableJson.host);
            var divBody = $("<div>").addClass("card-body table-responsive");
            var table = $("<table>").addClass("table table-sm table-bordered table-dark text-white p-3 shadow");
            var tbody = $("<tbody>");
            var tr1 = $("<tr>");
            var tr2 = $("<tr>");
            for (var i = 0; i < tableJson.fa; i++) {
                var td = $("<td>").html("0/" + (i + 1) + "<br />");
                var img = $("<img>");
                if ($.inArray(i + 1, tableJson.con) != -1) img.attr("src", "/Content/ico_green.png");
                else img.attr("src", "/Content/ico_red.png");
                td.append(img);
                if (i % 2 == 0) {
                    tr1.append(td);
                }
                else {
                    tr2.append(td);
                }
            }
            var logoTd = $("<td>").attr("colspan", tableJson.gi).html("LOGO");
            tr1.append(logoTd);
            for (var i = 0; i < tableJson.gi; i++) {
                var td = $("<td>").html("0/" + (i + 1) + "<br />");
                var img = $("<img>");
                if ($.inArray(i + 1, tableJson.gicon) != -1) img.attr("src", "/Content/Network.png");
                else img.attr("src", "/Content/ico_red.png");
                td.append(img);
                tr2.append(td);
            }

            $("#test").append(div.append(divHeader).append(divBody.append(table.append(tbody.append(tr1).append(tr2)))));
            //alert($("#tableJson").data('content').fa);
        });
    </script>
</asp:Content>

