<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Departamentos.aspx.cs" Inherits="PerfilesSA_WebApp.Departamentos" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Gestión de Departamentos</title>
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

        .dept-name {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 500;
            color: #0f172a;
        }

        .dept-icon {
            width: 40px;
            height: 40px;
            background-color: #f1f5f9;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            color: #64748b;
        }

        .dept-description {
            color: var(--text-muted);
            font-size: 14px;
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
            font-size: 14px;
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
            margin-right: 4px;
        }

        .btn-action:hover {
            border-color: var(--primary-color);
            color: var(--primary-color);
            background-color: #f0f7ff;
        }

        .btn-action-toggle {
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

        .btn-action-toggle:hover {
            border-color: #f97316;
            color: #f97316;
            background-color: #fff7ed;
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

        .modal-departamento {
            background: white;
            border-radius: 8px;
            width: 90%;
            max-width: 580px;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header-departamento {
            padding: 20px 24px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header-departamento h4 {
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

        .modal-body-departamento {
            padding: 24px;
        }

        .form-row {
            margin-bottom: 20px;
        }

        .form-row.single-column {
            width: 100%;
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
        .form-group textarea {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            font-size: 14px;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(30, 64, 175, 0.1);
        }

        .modal-footer-departamento {
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
            font-size: 14px;
            color: white;
            cursor: pointer;
        }

        .btn-modal-primary:hover {
            background-color: #1e3a8a;
        }

        .btn-modal-secondary {
            background-color: white;
            color: #64748b;
            border: 1px solid #d1d5db;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 14px;
            cursor: pointer;
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

        /* Modal Confirmación */
        .modal-confirm {
            background: white;
            border-radius: 8px;
            width: 90%;
            max-width: 480px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
        }

        .modal-confirm-header {
            padding: 20px 24px;
            border-bottom: 1px solid #e2e8f0;
        }

        .modal-confirm-header h4 {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
            color: #0f172a;
        }

        .modal-confirm-body {
            padding: 24px;
            color: #475569;
            font-size: 14px;
            line-height: 1.6;
        }

        .modal-confirm-footer {
            padding: 16px 24px;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-modal-danger {
            background-color: #dc2626;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 13px;
            cursor: pointer;
        }

        .btn-modal-danger:hover {
            background-color: #b91c1c;
        }

        .btn-modal-success {
            background-color: #10b981;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 13px;
            cursor: pointer;
        }

        .btn-modal-success:hover {
            background-color: #059669;
        }

        /* Toast Notification */
        .toast-container {
            position: fixed;
            bottom: 24px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 9999;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .toast-notification {
            background: white;
            border-radius: 8px;
            padding: 14px 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 400px;
            animation: slideUp 0.3s ease-out;
        }

        .toast-notification.success {
            background: white;
            border: 1px solid #10b981;
        }

        .toast-notification.warning {
            background: #1e293b;
            color: white;
        }

        .toast-notification.error {
            background: white;
            border: 1px solid #ef4444;
        }

        .toast-icon {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
        }

        .toast-notification.success .toast-icon {
            background-color: #10b981;
            color: white;
        }

        .toast-notification.warning .toast-icon {
            background-color: transparent;
            color: #fbbf24;
            font-size: 20px;
        }

        .toast-notification.error .toast-icon {
            background-color: #ef4444;
            color: white;
        }

        .toast-content {
            flex: 1;
        }

        .toast-message {
            font-size: 14px;
            font-weight: 500;
        }

        .toast-notification.success .toast-message {
            color: #0f172a;
        }

        .toast-notification.warning .toast-message {
            color: white;
        }

        .toast-notification.error .toast-message {
            color: #0f172a;
        }

        @keyframes slideUp {
            from {
                transform: translateY(100px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes slideDown {
            from {
                transform: translateY(0);
                opacity: 1;
            }
            to {
                transform: translateY(100px);
                opacity: 0;
            }
        }

        .toast-notification.hiding {
            animation: slideDown 0.3s ease-out forwards;
        }
    </style>
    <script type="text/javascript">
        function abrirModal() {
            document.getElementById('<%= pnlModal.ClientID %>').style.display = 'flex';
        }

        function cerrarModal() {
            document.getElementById('<%= pnlModal.ClientID %>').style.display = 'none';
        }

        function abrirModalConfirm() {
            document.getElementById('<%= pnlModalConfirm.ClientID %>').style.display = 'flex';
        }

        function cerrarModalConfirm() {
            document.getElementById('<%= pnlModalConfirm.ClientID %>').style.display = 'none';
        }

        function showToast(type, message) {
            var container = document.getElementById('toastContainer');

            var toast = document.createElement('div');
            toast.className = 'toast-notification ' + type;

            var icon = '';
            if (type === 'success') {
                icon = '✓';
            } else if (type === 'warning') {
                icon = '⚠';
            } else if (type === 'error') {
                icon = '✕';
            }

            toast.innerHTML = `
                <div class="toast-icon">${icon}</div>
                <div class="toast-content">
                    <div class="toast-message">${message}</div>
                </div>
            `;

            container.appendChild(toast);

            setTimeout(function () {
                toast.classList.add('hiding');
                setTimeout(function () {
                    container.removeChild(toast);
                }, 300);
            }, 3500);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <!-- TOP BREADCRUMB -->
        <div class="top-breadcrumb">
            Departamentos
        </div>

        <!-- TOAST CONTAINER -->
        <div class="toast-container" id="toastContainer"></div>

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
                <a href="Empleados.aspx" class="menu-item">
                    <i class="bi bi-people-fill menu-icon"></i>
                    <span>Empleados</span>
                </a>
                <a href="Departamentos.aspx" class="menu-item active">
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
                    <h1>Gestión de Departamentos</h1>
                    <p>Administra los departamentos de la empresa</p>
                </div>
                <button type="button" class="btn btn-primary" onclick="abrirModal()">
                    <i class="bi bi-plus-lg me-2"></i>
                    Nuevo Departamento
                </button>
            </div>

            <asp:Label ID="lblMensaje" runat="server" CssClass="message" Visible="false"></asp:Label>

            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-icon primary">
                        <i class="bi bi-building"></i>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Label ID="lblTotalDepartamentos" runat="server" Text="0"></asp:Label></h3>
                        <p>Total Departamentos</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon success">
                        <i class="bi bi-power"></i>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Label ID="lblActivos" runat="server" Text="0"></asp:Label></h3>
                        <p>Activos</p>
                    </div>
                </div>
                <div class="stat-card">
                    <div class="stat-icon muted">
                        <i class="bi bi-power"></i>
                    </div>
                    <div class="stat-content">
                        <h3><asp:Label ID="lblInactivos" runat="server" Text="0"></asp:Label></h3>
                        <p>Inactivos</p>
                    </div>
                </div>
            </div>

            <!-- TABLA -->
            <div class="table-container">
                <asp:GridView ID="gvDepartamentos" runat="server" AutoGenerateColumns="False" 
                    OnRowCommand="gvDepartamentos_RowCommand" CssClass="table">
                    <Columns>
                        <asp:TemplateField HeaderText="Nombre">
                            <ItemTemplate>
                                <div class="dept-name">
                                    <div class="dept-icon">
                                        <i class="bi bi-building"></i>
                                    </div>
                                    <span><%# Eval("NombreDepartamento") %></span>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Descripción">
                            <ItemTemplate>
                                <span class="dept-description"><%# Eval("Descripcion") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
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
                                    CommandArgument='<%# Eval("IdDepartamento") %>'
                                    CssClass="btn-action" CausesValidation="false">
                                    <i class="bi bi-pencil"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnToggleEstado" runat="server" CommandName="ToggleEstado" 
                                    CommandArgument='<%# Eval("IdDepartamento") %>'
                                    CssClass="btn-action-toggle" CausesValidation="false">
                                    <i class="bi bi-power"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- MODAL EDITAR/CREAR -->
        <asp:Panel ID="pnlModal" runat="server" CssClass="modal-overlay" style="display:none;">
            <div class="modal-departamento">
                <div class="modal-header-departamento">
                    <h4><asp:Literal ID="litTituloModal" runat="server" Text="Nuevo Departamento"></asp:Literal></h4>
                    <button type="button" class="modal-close" onclick="cerrarModal()">×</button>
                </div>

                <div class="modal-body-departamento">
                    <!-- FILA 1: Nombre Departamento -->
                    <div class="form-row single-column">
                        <div class="form-group">
                            <label>Nombre <span class="required">*</span></label>
                            <asp:TextBox ID="txtNombre" runat="server" MaxLength="100" placeholder="Nombre del departamento"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" 
                                ErrorMessage="Campo requerido" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <!-- FILA 2: Descripción -->
                    <div class="form-row single-column">
                        <div class="form-group">
                            <label>Descripción</label>
                            <asp:TextBox ID="txtDescripcion" runat="server" MaxLength="255" TextMode="MultiLine" 
                                Rows="4" placeholder="Descripción del departamento"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="modal-footer-departamento">
                    <button type="button" class="btn-modal-secondary" onclick="cerrarModal()">Cancelar</button>
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Departamento" CssClass="btn-modal-primary" OnClick="btnGuardar_Click" />
                    <asp:HiddenField ID="hfIdDepartamento" runat="server" Value="0" />
                </div>
            </div>
        </asp:Panel>

        <!-- MODAL CONFIRMACIÓN -->
        <asp:Panel ID="pnlModalConfirm" runat="server" CssClass="modal-overlay" style="display:none;">
            <div class="modal-confirm">
                <div class="modal-confirm-header">
                    <h4><asp:Literal ID="litTituloConfirm" runat="server"></asp:Literal></h4>
                </div>
                <div class="modal-confirm-body">
                    <asp:Literal ID="litMensajeConfirm" runat="server"></asp:Literal>
                </div>
                <div class="modal-confirm-footer">
                    <button type="button" class="btn-modal-secondary" onclick="cerrarModalConfirm()">Cancelar</button>
                    <asp:Button ID="btnConfirmarAccion" runat="server" OnClick="btnConfirmarAccion_Click" CausesValidation="false" />
                    <asp:HiddenField ID="hfIdDepartamentoConfirm" runat="server" />
                    <asp:HiddenField ID="hfEstadoActual" runat="server" />
                    <asp:HiddenField ID="hfCantidadEmpleados" runat="server" />
                    <asp:HiddenField ID="hfNombreDepartamento" runat="server" />
                </div>
            </div>
        </asp:Panel>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
