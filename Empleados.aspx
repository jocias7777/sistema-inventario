 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="PerfilesSA_WebApp.Empleados" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Gestión de Empleados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        :root {
            --sidebar-bg: #1e293b;
            --sidebar-active: #f97316;
            --primary-color: #1e40af;
            --success-color: #10b981;
            --text-muted: #64748b;
        }

        body {
            background-color: #f3f4f6;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 228px;
            background-color: var(--sidebar-bg);
            color: white;
            padding: 0;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 40px;
            height: 40px;
            background-color: var(--primary-color);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .logo-text {
            font-weight: 700;
            font-size: 16px;
            letter-spacing: 0.5px;
        }

        .logo-subtitle {
            font-size: 11px;
            color: #94a3b8;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-label {
            padding: 8px 20px;
            font-size: 11px;
            font-weight: 600;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .menu-item {
            display: flex;
            align-items: center;
            padding: 12px 20px;
            color: #cbd5e1;
            text-decoration: none;
            transition: all 0.2s;
            gap: 12px;
            font-size: 14px;
        }

        .menu-item:hover {
            background-color: rgba(255, 255, 255, 0.05);
            color: white;
        }

        .menu-item.active {
            background-color: var(--primary-color);
            color: white;
            font-weight: 500;
        }

        .menu-icon {
            font-size: 18px;
            width: 20px;
        }

        .sidebar-footer {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 12px;
            color: #94a3b8;
        }

        /* Top Breadcrumb */
        .top-breadcrumb {
            background: white;
            padding: 20px 32px;
            margin-left: 228px;
            color: #0f172a;
            display: flex;
            align-items: center;
            font-size: 22px;
            font-weight: 600;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border-bottom: 1px solid #e2e8f0;
        }

        /* Main Content */
        .main-content {
            margin-left: 228px;
            padding: 32px;
        }

        .page-header {
            margin-bottom: 24px;
        }

        .page-header h1 {
            font-size: 28px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 4px;
        }

        .page-header p {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 0;
        }

        /* Stats Cards */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .stat-icon.primary {
            background-color: #dbeafe;
            color: #1e40af;
        }

        .stat-icon.success {
            background-color: #d1fae5;
            color: #10b981;
        }

        .stat-icon.muted {
            background-color: #f1f5f9;
            color: #64748b;
        }

        .stat-content h3 {
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0;
        }

        .stat-content p {
            font-size: 13px;
            color: var(--text-muted);
            margin-bottom: 0;
        }

        /* Filters */
        .filters-container {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 12px;
            margin-bottom: 24px;
        }

        .search-box {
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        .search-box input {
            padding-left: 40px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            height: 40px;
        }

        .search-box input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.1);
        }

        .form-select {
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            height: 40px;
            width: 250px;
        }

        .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.1);
        }

        /* Table */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead {
            background-color: #f8fafc;
        }

        .table thead th {
            font-size: 13px;
            font-weight: 600;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            padding: 16px;
            border-bottom: 2px solid #e2e8f0;
        }

        .table tbody td {
            padding: 16px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            font-size: 14px;
        }

        .table tbody tr:hover {
            background-color: #f8fafc;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .employee-name {
            font-weight: 500;
            color: #0f172a;
            display: block;
        }

        .employee-gender {
            font-size: 13px;
            color: var(--text-muted);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 500;
        }

        .status-badge.active {
            background-color: #d1fae5;
            color: #059669;
        }

        .status-badge.active::before {
            content: '';
            width: 6px;
            height: 6px;
            background-color: #10b981;
            border-radius: 50%;
        }

        .status-badge.inactive {
            background-color: #f1f5f9;
            color: #64748b;
        }

        .status-badge.inactive::before {
            content: '';
            width: 6px;
            height: 6px;
            background-color: #94a3b8;
            border-radius: 50%;
        }

        /* Buttons */
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 16px;
        }

        .btn-primary:hover {
            background-color: #1e3a8a;
        }

        .btn-action {
            width: 32px;
            height: 32px;
            padding: 0;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 6px;
            border: 1px solid #e2e8f0;
            background: white;
            color: #64748b;
            transition: all 0.2s;
        }

        .btn-action:hover {
            border-color: var(--primary-color);
            color: var(--primary-color);
            background-color: #f0f7ff;
        }

        /* Modal */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .modal-empleado {
            background: white;
            border-radius: 8px;
            width: 90%;
            max-width: 650px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header-empleado {
            padding: 20px 24px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header-empleado h4 {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 28px;
            color: #64748b;
            cursor: pointer;
            line-height: 1;
            padding: 0;
            width: 32px;
            height: 32px;
        }

        .modal-body-empleado {
            padding: 24px;
        }

        .form-row {
            display: grid;
            gap: 16px;
            margin-bottom: 20px;
        }

        .form-row.single-column {
            grid-template-columns: 1fr;
        }

        .form-row.two-columns {
            grid-template-columns: 1fr 1fr;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #374151;
            margin-bottom: 6px;
        }

        .required {
            color: #ef4444;
        }

        .form-group input[type="text"],
        .form-group input[type="date"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.1);
        }

        .calculated-field {
            margin-top: 6px;
            font-size: 13px;
            color: var(--text-muted);
        }

        .modal-footer-empleado {
            padding: 16px 24px;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-modal-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 16px;
            color: white;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn-modal-primary:hover {
            background-color: #1e3a8a;
        }

        .btn-modal-secondary {
            background-color: whitesmoke;
            border: 1px solid #d1d5db;
            padding: 8px 26px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            font-size: 14px;
        }

        .btn-modal-secondary:hover {
            background-color: #f8fafc;
        }

        .message {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .message-success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #6ee7b7;
        }

        .message-error {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }

        /* Estilo para departamentos inactivos en dropdown */
        .dept-inactive {
            color: #94a3b8;
            font-style: italic;
        }
    </style>
    <script type="text/javascript">
        function calcularEdad() {
            var fechaNac = document.getElementById('<%= txtFechaNacimiento.ClientID %>').value;
            if (fechaNac) {
                var hoy = new Date();
                var nacimiento = new Date(fechaNac);
                var edad = hoy.getFullYear() - nacimiento.getFullYear();
                var mes = hoy.getMonth() - nacimiento.getMonth();
                if (mes < 0 || (mes === 0 && hoy.getDate() < nacimiento.getDate())) {
                    edad--;
                }
                document.getElementById('spanEdad').innerText = edad + ' años';
            }
        }

        function calcularTiempoLaboral() {
            var fechaIng = document.getElementById('<%= txtFechaIngreso.ClientID %>').value;
            if (fechaIng) {
                var hoy = new Date();
                var ingreso = new Date(fechaIng);
                var años = hoy.getFullYear() - ingreso.getFullYear();
                var meses = hoy.getMonth() - ingreso.getMonth();
                if (meses < 0) {
                    años--;
                    meses += 12;
                }
                document.getElementById('spanTiempoLaboral').innerText = años + ' años y ' + meses + ' meses';
            }
        }

        function abrirModal() {
            document.getElementById('<%= pnlModal.ClientID %>').style.display = 'flex';
        }

        function cerrarModal() {
            document.getElementById('<%= pnlModal.ClientID %>').style.display = 'none';
        }

        function buscarEmpleado() {
            var input = document.getElementById('txtBuscar');
            var filter = input.value.toUpperCase().replace(/\s/g, '');
            var table = document.getElementById('<%= gvEmpleados.ClientID %>');
            var rows = table.getElementsByTagName('tr');

            for (var i = 1; i < rows.length; i++) {
                var row = rows[i];

                // Obtener el nombre del primer span de la primera celda
                var nombreCell = row.cells[0];
                var nombreSpan = nombreCell.getElementsByClassName('employee-name')[0];
                var nombre = nombreSpan ? (nombreSpan.textContent || nombreSpan.innerText) : '';

                // Obtener el DPI de la segunda celda
                var dpi = row.cells[1].textContent || row.cells[1].innerText;

                var dpiSinEspacios = dpi.toUpperCase().replace(/\s/g, '');
                var nombreUpper = nombre.toUpperCase().replace(/\s/g, '');

                if (nombreUpper.indexOf(filter) > -1 || dpiSinEspacios.indexOf(filter) > -1) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- TOP BREADCRUMB -->
        <div class="top-breadcrumb">
            Empleados
        </div>

        <!-- SIDEBAR -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="logo">
                    <div class="logo-icon">
                        <i class="bi bi-bar-chart-fill"></i>
                    </div>
                    <div>
                        <div class="logo-text">PERFILES</div>
                        <div class="logo-subtitle">S.A.</div>
                    </div>
                </div>
            </div>

            <div class="sidebar-menu">
                <div class="menu-label">MÓDULOS</div>
                <a href="Empleados.aspx" class="menu-item active">
                    <i class="bi bi-people-fill menu-icon"></i>
                    <span>Empleados</span>
                </a>
                <a href="Departamentos.aspx" class="menu-item">
                    <i class="bi bi-building menu-icon"></i>
                    <span>Departamentos</span>
                </a>
                <a href="Reporte.aspx" class="menu-item">
                    <i class="bi bi-file-earmark-bar-graph menu-icon"></i>
                    <span>Reportes</span>
                </a>
            </div>

            <div class="sidebar-footer">
                <div><strong>Sistema de Control</strong></div>
                <div>Gestión de Empleados</div>
            </div>
        </div>

        <!-- MAIN CONTENT -->
        <div class="main-content">
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-start page-header">
                <div>
                    <h1>Gestión de Empleados</h1>
                    <p>Administra el registro de empleados</p>
                </div>
                <button type="button" class="btn btn-primary" onclick="abrirModal()">
                    <i class="bi bi-plus-lg me-2"></i>
                    Nuevo Empleado
                </button>
            </div>

            <asp:Label ID="lblMensaje" runat="server" CssClass="message" Visible="false"></asp:Label>

            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-icon primary">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Label ID="lblTotalEmpleados" runat="server" Text="0"></asp:Label></h3>
                        <p>Total Empleados</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon success">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Label ID="lblActivos" runat="server" Text="0"></asp:Label></h3>
                        <p>Activos</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon muted">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Label ID="lblInactivos" runat="server" Text="0"></asp:Label></h3>
                        <p>Inactivos</p>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="filters-container">
                <div class="search-box">
                    <i class="bi bi-search"></i>
                    <input type="text" id="txtBuscar" class="form-control"
                           placeholder="Buscar por nombre o DPI..."
                           onkeyup="buscarEmpleado()">
                </div>
                <asp:DropDownList ID="ddlFiltroDepartamento" runat="server" CssClass="form-select"
                    AutoPostBack="True" OnSelectedIndexChanged="ddlFiltroDepartamento_SelectedIndexChanged">
                </asp:DropDownList>
            </div>

            <!-- TABLA -->
            <div class="table-container">
                <asp:GridView ID="gvEmpleados" runat="server" AutoGenerateColumns="False"
                    OnRowCommand="gvEmpleados_RowCommand" CssClass="table">
                    <Columns>
                        <asp:TemplateField HeaderText="Nombre">
                            <ItemTemplate>
                                <span class="employee-name"><%# Eval("Nombres") %></span>
                                <span class="employee-gender"><%# Eval("Sexo").ToString() == "M" ? "Masculino" : "Femenino" %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DPI">
                            <ItemTemplate>
                                <%# FormatDPI(Eval("DPI").ToString()) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="FechaNacimiento" HeaderText="Edad" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="NombreDepartamento" HeaderText="Departamento" />
                        <asp:BoundField DataField="FechaIngreso" HeaderText="Antigüedad" DataFormatString="{0:d}" />
                        <asp:TemplateField HeaderText="Estado">
                            <ItemTemplate>
                                <span class='status-badge <%# Convert.ToBoolean(Eval("Activo")) ? "active" : "inactive" %>'>
                                    <%# Convert.ToBoolean(Eval("Activo")) ? "Activo" : "Inactivo" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEditar" runat="server" CommandName="Editar"
                                    CommandArgument='<%# Eval("IdEmpleado") %>'
                                    CssClass="btn-action" CausesValidation="false">
                                    <i class="bi bi-pencil"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- MODAL -->
        <asp:Panel ID="pnlModal" runat="server" CssClass="modal-overlay" style="display:none;">
            <div class="modal-empleado">
                <div class="modal-header-empleado">
                    <h4><asp:Literal ID="litTituloModal" runat="server" Text="Nuevo Empleado"></asp:Literal></h4>
                    <button type="button" class="modal-close" onclick="cerrarModal()">×</button>
                </div>

                <div class="modal-body-empleado">
                    <!-- FILA 1: Nombres Completos -->
                    <div class="form-row single-column">
                        <div class="form-group">
                            <label>Nombres Completos <span class="required">*</span></label>
                            <asp:TextBox ID="txtNombres" runat="server" MaxLength="150" placeholder="Nombres y apellidos"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombres" runat="server" ControlToValidate="txtNombres"
                                ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- FILA 2: DPI y NIT -->
                    <div class="form-row two-columns">
                        <div class="form-group">
                            <label>DPI <span class="required">*</span></label>
                            <asp:TextBox ID="txtDPI" runat="server" MaxLength="20" placeholder="13 dígitos"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDPI" runat="server" ControlToValidate="txtDPI"
                                ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <label>NIT</label>
                            <asp:TextBox ID="txtNIT" runat="server" MaxLength="20" placeholder="Opcional"></asp:TextBox>
                        </div>
                    </div>

                    <!-- FILA 3: Fecha Nacimiento y Sexo -->
                    <div class="form-row two-columns">
                        <div class="form-group">
                            <label>Fecha de Nacimiento <span class="required">*</span></label>
                            <asp:TextBox ID="txtFechaNacimiento" runat="server" TextMode="Date" onchange="calcularEdad()"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFechaNac" runat="server" ControlToValidate="txtFechaNacimiento"
                                ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="calculated-field">Edad: <span id="spanEdad">0 años</span></div>
                        </div>

                        <div class="form-group">
                            <label>Sexo <span class="required">*</span></label>
                            <asp:DropDownList ID="ddlSexo" runat="server">
                                <asp:ListItem Value="">Seleccionar</asp:ListItem>
                                <asp:ListItem Value="M">Masculino</asp:ListItem>
                                <asp:ListItem Value="F">Femenino</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="ddlSexo"
                                InitialValue="" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- FILA 4: Fecha Ingreso y Departamento -->
                    <div class="form-row two-columns">
                        <div class="form-group">
                            <label>Fecha de Ingreso <span class="required">*</span></label>
                            <asp:TextBox ID="txtFechaIngreso" runat="server" TextMode="Date" onchange="calcularTiempoLaboral()"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFechaIng" runat="server" ControlToValidate="txtFechaIngreso"
                                ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <div class="calculated-field">Tiempo laborando: <span id="spanTiempoLaboral">0 años y 0 meses</span></div>
                        </div>

                        <div class="form-group">
                            <label>Departamento <span class="required">*</span></label>
                            <asp:DropDownList ID="ddlDepartamento" runat="server">
                                <asp:ListItem Value="0">Seleccionar departamento</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvDepartamento" runat="server" ControlToValidate="ddlDepartamento"
                                InitialValue="0" ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- FILA 5: Dirección -->
                    <div class="form-row single-column">
                        <div class="form-group">
                            <label>Dirección</label>
                            <asp:TextBox ID="txtDireccion" runat="server" MaxLength="255" placeholder="Opcional"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="modal-footer-empleado">
                    <button type="button" class="btn-modal-secondary" onclick="cerrarModal()">Cancelar</button>
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Empleado" CssClass="btn-modal-primary" OnClick="btnGuardar_Click" />
                    <asp:HiddenField ID="hfIdEmpleado" runat="server" Value="0" />
                </div>

            </div>
        </asp:Panel>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>