<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>

        <title>Upinder Login</title>
        <script>
            $(document).ready(function () {
                Materialize.updateTextFields();
                $('.modal-trigger').click(function () {
                    event.preventDefault();
                    console.log("holi");
                    $('#modal1').openModal();
                });
            });
        </script>
    </head>
    <body>
        <nav>
            <div class="nav-wrapper indigo darken-4">
                <a href="goDashboard.action" class="brand-logo center"><div class="valign-wrapper"><img src="img/upinderlogo.png" style="max-height: 40px;">Upinder</div></a>
            </div>
        </nav>
        <div class="container" style="margin-top: 5%">
            <div class="row">
                <div class="col s12 m6 offset-m3 card-panel">
                    <span class="red-text text-darken-3 center-align">
                        <s:actionerror></s:actionerror>
                    </span>                    
                </div>
            </div>
            <div class="row">
                <form class="col s12 m6 offset-m3" method="post" action="doLogin.action">
                    <div class="row">
                        <div class="input-field col s12">
                            <i class="material-icons prefix">account_circle</i>
                            <input id="email" name="email" type="email" class="validate" required>
                            <label for="email">Email</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12">
                            <i class="material-icons prefix">vpn_key</i>
                            <input id="password" name="password" type="password" class="validate" required>
                            <label for="password">Password</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12">
                            <div style="float: right;">
                                <button class="btn waves-effect waves-light" type="submit" name="action">Login
                                    <i class="material-icons right">input</i>
                                </button>
                            </div>                            
                        </div>                        
                    </div>
                    <div class="row">
                        <div class="col s12 center-align">
                            <a href="goAlta.action"><i class="material-icons">perm_identity</i>&nbsp;Nuevo usuario</a>
                        </div>
                        <div class="col s12 center-align">
                            <a href="#!" data-target="modal1" class="modal-trigger"><i class="material-icons">vpn_key</i>&nbsp;He olvidado mi contraseña</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div id="modal1" class="modal">
            <div class="modal-content">
                <h4>Recuperación de contraseña</h4>
                <p>Si has olvidado tu contraseña recuerda que cuando te diste de alta recibiste un email con tus datos de acceso.</p>
                <p>En caso de que hayas extraviado ese email o simplemente necesites restablecer tu contraseña puedes ponerte en contacto con los administradores de Upinder mediante la direccion 
                    <a href="mailto:soporte.upinder@gmail.com?subject=Restablecimiento%20de%20contraseña&body=He%20olvidado%20mi%20contraseña%20y%20me%20gustaria%20recibir%20una nueva.%20Gracias." target="_top">soporte.upinder@gmail.com</a>
                </p>
                <p>Recuerda que el email debe ser enviado desde la cuenta upo.es con la que te diste de alta y tus nuevas credenciales serán enviadas allí.</p>
            </div>
            <div class="modal-footer">
                <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Aceptar</a>
            </div>
        </div>
    </body>
</html>
