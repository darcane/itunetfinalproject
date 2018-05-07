<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DeviceAdd.aspx.cs" Inherits="Device_DeviceAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphTitle" runat="Server">
    ITUNET - Add Device
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <style type="text/css">
        .input-group .input-group-prepend .input-group-text {
            width: 112px;
        }

        .qrimage {
            width: 300px;
        }

        .progress {
            height: 38px;
        }

        .progress-bar {
            height: 38px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphBreadcrumb" runat="Server">
    <li class="breadcrumb-item">
        <a href="/Default.aspx"><i class="fa fa-dashcube"></i>&nbsp;Dashboard</a>
    </li>
    <li class="breadcrumb-item">
        <a href="/Device/Default.aspx"><i class="fa fa-keyboard-o"></i>&nbsp;Device</a>
    </li>
    <li class="breadcrumb-item active"><i class="fa fa-plus"></i>&nbsp;Add Device</li>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="cphContent" runat="Server">
    <h2>Add Device</h2>
    <div class="alert alert-info alert-dismissible">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">x</button>
        By giving IP Address; program will automatically detect the device and add to the system.
    </div>
    <div class="row">
        <div class="col-lg-4">
            <div class="form-group input-group">
                <div class="input-group-prepend">
                    <span class="input-group-text">IP Address</span>
                </div>
                <asp:TextBox ID="tbIPAddress" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                <div class="input-group-append">
                    <asp:LinkButton ID="lbAddDevice" CssClass="btn btn-success" runat="server" OnClick="lbAddDevice_Click" ClientIDMode="Static">
                        <i class="fa fa-plus"></i> Add Device
                    </asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="progress" style="display: none">
                <div id="loadingBar" class="progress-bar progress-bar-striped progress-bar-animated bg-success" style="width: 0%"></div>
            </div>
        </div>
    </div>
    <asp:Panel ID="pnlAfterAdd" runat="server" Visible="false" ClientIDMode="Static">
        <div class="row">
            <div class="col-4">
                <fieldset disabled>
                    <div class="form-group input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Host Name</span>
                        </div>
                        <asp:TextBox ID="tbHostName" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Device Type</span>
                        </div>
                        <asp:TextBox ID="tbDeviceType" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="form-group input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Device Key</span>
                        </div>
                        <asp:TextBox ID="tbDeviceKey" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </fieldset>
                <div class="form-group input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text">Building</span>
                    </div>
                    <asp:DropDownList ID="ddlBuilding" runat="server" DataValueField="BuildingId" DataTextField="BuildingName" CssClass="form-control"></asp:DropDownList>
                </div>
                <div class="form-group">
                    <asp:Panel ID="pnlDeviceNotExist" runat="server" Visible="true">
                        <asp:LinkButton ID="lbSaveDevice" runat="server" CssClass="btn btn-primary pull-right" OnClick="lbSaveDevice_Click" ClientIDMode="Static">
                            <i class="fa fa-save"></i>&nbsp;Save Device
                        </asp:LinkButton>
                    </asp:Panel>
                    <asp:Panel ID="pnlDeviceExist" runat="server" Visible="false">
                        <div class="alert alert-danger">Device already exist!</div>
                        <asp:LinkButton ID="lbUpdateDevice" runat="server" CssClass="btn btn-info pull-right" OnClick="lbUpdateDevice_Click">
                            <i class="fa fa-refresh"></i>&nbsp;Update Device
                        </asp:LinkButton>
                    </asp:Panel>
                </div>
            </div>
            <div class="col-8">
                <div class="row">
                    <div class="col-4">
                        <img runat="server" id="imgQR" class="qrimage" src="#" />
                    </div>
                    <div class="col-8">
                        <asp:GridView runat="server" ID="gv"></asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="cphFooterJs" runat="Server">
    <script src="/Scripts/jquery-mask/jquery.mask.js"></script>
    <script type="text/javascript">
        $(document).ready(() => {
            $("#tbIPAddress").mask('0ZZ.0ZZ.0ZZ.0ZZ', {
                translation: {
                    'Z': {
                        pattern: /[0-9]/, optional: true
                    }
                },
                placeholder: "___.___.___.___"
            });
            $('#tbIPAddress').mask('099.099.099.099');

            if ($("#pnlAfterAdd").length) {
                $("#lbAddDevice").children("i").removeClass("fa-plus").addClass("fa-spin fa-spinner");
                $("#lbAddDevice").addClass("disabled");
            };

            $("#lbAddDevice").one("click", (e) => {
                e.preventDefault();
                $("#lbAddDevice").children("i").removeClass("fa-plus").addClass("fa-spin fa-spinner");
                $("#lbAddDevice").addClass("disabled");
                triggerProgressBar();
            });
        });

        function triggerProgressBar() {
            animateProgressBar();
            $(".progress").show();
            var progress = 1;
            var increment = 0.5;
            var messages = [
                "Connecting device...",
                "Getting Device informations...",
                "Getting interface informations...",
                "Generating DeviceKey...",
                "Generating QR Code...",
            ];
            function animateProgressBar() {
                setTimeout(() => {
                    increment = (Math.random() * (0.1 - 3) + 3);
                    console.log(increment);
                    progress += increment;
                    if (progress < 101) {
                        $("#loadingBar").css("width", progress + "%");
                        $("#loadingBar").html(messages[parseInt(progress / 20)]);
                        animateProgressBar();
                    } else {
                        $("#loadingBar").html("Completed!");
                        setTimeout(() => {
                            var f = new Function($("#lbAddDevice").attr("href"));
                            return (f());
                        }, 1000);
                    }
                }, 50);
            }
        }


    </script>
</asp:Content>

