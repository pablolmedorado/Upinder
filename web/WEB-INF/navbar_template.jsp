<%@taglib prefix="s" uri="/struts-tags"%>
<div class="navbar-fixed">
    <nav>
        <div class="nav-wrapper indigo darken-4">
            <a href="goDashboard.action" class="brand-logo"><div class="valign-wrapper"><img src="img/upinderlogo.png" style="max-height: 40px;">Upinder</div></a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li>
                    <a href="goNotificaciones.action">
                        <i class="material-icons right">notifications</i>
                        <s:if test="%{numNoLeidas > 0}">
                            <span class="new badge"><s:property value='numNoLeidas'/></span>
                        </s:if>
                    </a>
                </li>
                <li><a href="goMensajes.action"><i class="material-icons">forum</i></a></li>
                <li><a href="goMatches.action"><i class="material-icons">whatshot</i></a></li>
                <li><a href="goPerfil.action"><i class="material-icons">perm_identity</i></a></li>
                <li><a href="doLogout.action"><i class="material-icons">power_settings_new</i></a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li class="logo">
                    <a id="logo-container" href="goDashboard.action" class="brand-logo">
                        <img src="img/upinderlogo.png" style="max-height: 70px;">
                    </a>
                </li>
                <li><a href="goNotificaciones.action">Notificaciones<s:if test="%{numNoLeidas > 0}">
                            <span class="new badge"><s:property value='numNoLeidas'/></span>
                        </s:if></a></li>
                <li><a href="goMensajes.action">Mensajes</a></li>
                <li><a href="goMatches.action">Matches</a></li>
                <li><a href="goPerfil.action">Perfil</a></li>
                <li><a href="doLogout.action">Logout</a></li>
            </ul>
        </div>
    </nav>
</div>