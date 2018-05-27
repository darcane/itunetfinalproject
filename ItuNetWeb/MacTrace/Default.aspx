﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="MacTrace_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" Runat="Server">
    ITUNET - Find MAC
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
    <li class="breadcrumb-item">
        <a href="/Default.aspx"><i class="fa fa-dashboard"></i>&nbsp;Dashboard</a>
    </li>
    <li class="breadcrumb-item active"><i class="fa fa-sitemap"></i>&nbsp;Find a MAC</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" Runat="Server">
    <h2>Find a MAC Address</h2>
    <div class="row">
        <div class="col col-xl-4">
            <div class="form-group">
                <label>Enter a MAC address</label>
            </div>
            <div class="form-group input-group">
                <asp:TextBox ID="tbMacAddress" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                <div class="input-group-append">
                    <asp:LinkButton ID="lbFindMac" CssClass="btn btn-success" runat="server" OnClick="lbFindMac_Click" ClientIDMode="Static">
                        <i class="fa fa-search"></i>&nbsp;Search
                    </asp:LinkButton>
                </div>
            </div>
            <div class="form-group">
                <label for="ddlDevice">Choose a Device to begin search</label>
                <asp:DropDownList ID="ddlDevice" runat="server" DataTextField="Display" DataValueField="Ip" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:GridView ID="gvRes" runat="server"></asp:GridView>
            </div>
        </div>
        <div class="col col-xl-6">
            <asp:GridView ID="gv" runat="server"></asp:GridView>
            <asp:Repeater runat="server" ID="rp">
                <ItemTemplate>
                    <span class="tableJson" data-content='<%#GetDataItem() %>'>test</span>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div id="test"></div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" Runat="Server">
    <script src="/Scripts/jquery-mask/jquery.mask.js"></script>
    <script type="text/javascript">
        $(document).ready(() => {
            $("#tbMacAddress").mask('HH:HH:HH:HH:HH:HH', {
                translation: {
                    'H': { pattern: /[A-Fa-f0-9]/ }
                },
                placeholder: "00:00:00:00:00:00"
            });

            $.each($(".tableJson"), (index,value) => {
                var tableJson = $(value).data('content');
                var div = $("<div>").addClass("card text-center");
                var divHeader = $("<div>").addClass("card-header").html(tableJson.ip + " - " + tableJson.host);
                var divBody = $("<div>").addClass("card-body table-responsive p-0 m-0");
                var table = $("<table>").addClass("table table-sm table-bordered table-dark text-white m-0");
                var tbody = $("<tbody>");
                var tr1 = $("<tr>");
                var tr2 = $("<tr>");
                for (var i = 0; i < tableJson.fa; i++) {
                    var td = $("<td>").html("0/" + (i + 1) + "<br />");
                    var img = $("<img>");
                    if ($.inArray(i + 1, tableJson.facon) != -1) img.attr("src", "/Content/Network.png");
                    else if ($.inArray(i + 1, tableJson.facd) != -1) img.attr("src", "/Content/ico_green.png");
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
                    else if ($.inArray(i + 1, tableJson.gicd) != -1) img.attr("src", "/Content/ico_green.png");
                    else img.attr("src", "/Content/ico_red.png");
                    td.append(img);
                    tr2.append(td);
                }

                $("#test").append(div.append(divHeader).append(divBody.append(table.append(tbody.append(tr1).append(tr2)))));
            });
        });
    </script>
</asp:Content>

