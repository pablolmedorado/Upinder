<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Alta de usuario</title>
        <script>
            $(document).ready(function () {
                $('select').material_select();

                var anios = moment().subtract(18, 'years');
                $('.datepicker').pickadate({
                    max: anios.toDate(),
                    selectMonths: true,
                    selectYears: 42,
                    closeOnSelect: true,
                    closeOnClear: true,
                    formatSubmit: 'yyyy-mm-dd',
                    hiddenName: true
                });

                $('#checklopd').change(function () {
                    $('#submit').toggleClass('disabled');
                });
                
                $('#modal-trigger').click(function(){
                    event.preventDefault();
                    $('#lopdmodal').openModal();
                });
                
                Materialize.updateTextFields();
            });
        </script>
    </head>
    <body>
        <nav>
            <div class="nav-wrapper indigo darken-4">
                <a href="goDashboard.action" class="brand-logo center"><div class="valign-wrapper"><img src="img/upinderlogo.png" style="max-height: 40px;">Upinder</div></a>
            </div>
        </nav>
        <div class="container">
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Alta de usuario</span>
                    <div class="center-align" style="clear: both">
                        <span class="red-text text-darken-3">
                            <s:fielderror/><s:actionerror/>
                        </span>
                    </div>
                    <form method="POST" action="doAlta.action">
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">account_circle</i>
                                <input id="nombre" name="nombre" type="text" class="validate">
                                <label for="nombre">Nombre</label>
                            </div>
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">account_circle</i>
                                <input id="apellidos" name="apellidos" type="text" class="validate">
                                <label for="apellidos">Apellidos</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">email</i>
                                <input id="email" name="email" type="email" class="validate">
                                <label for="email">Email</label>
                            </div>
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">vpn_key</i>
                                <input id="password" name="password" type="password" class="validate">
                                <label for="password">Password</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">cake</i>
                                <input id="fechanac" name="fechanac" type="date" class="datepicker">
                                <label for="fechanac">Fecha de Nacimiento</label>
                            </div>
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">school</i>
                                <s:select name="titulacion" id="titulacion" list="titulaciones" listKey="id" listValue="nombre"></s:select>
                                <label for="titulacion">Titulacion</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">wc</i>
                                <s:select name="sexo" id="sexo" list="sexos" listKey="id" listValue="nombre"></s:select>
                                <label for="sexo">Sexo</label>
                            </div>
                            <div class="input-field col s12 m6">
                                <i class="material-icons prefix">wc</i>
                                <s:select name="quebusca" id="quebusca" list="sexos" listKey="id" listValue="nombre" value="2"></s:select>
                                <label for="quebusca">Busca</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col s12">
                                <label for="lopd">LOPD</label>
                                <p id="lopd">
                                    <input type="checkbox" id="checklopd" />
                                    <label for="checklopd">Confirmo haber leido y aceptar la <a id="modal-trigger">LOPD</a></label>
                                </p>                                       
                            </div>
                        </div>
                        <div class="row">
                            <div style="float: right; margin-right: 10px;">
                                <button id="submit" class="btn waves-effect waves-light disabled" type="submit" name="action">Enviar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div id="lopdmodal" class="modal">
            <div class="modal-content">
                <h4>LOPD</h4>
                <p>Aceptación LOPD: Confidencialidad y protección de datos</p>
                <p>A efecto de lo previsto en la Ley Orgánica 15/1999, de 13 de diciembre,
                    de Protección de Datos de Carácter Personal, UPINDER Informa al Usuario 
                    de la existencia de un fichero automatizado de datos de carácter personal 
                    creado por y para  UPINDER y bajo su responsabilidad,con la finalidad de 
                    realizar el mantenimiento y la gestión de la realización con el Usuario, 
                    así como las labores de información. En el momento de la aceptación  de 
                    las presentes condiciones generales, UPINDER , precisará del Usuario la 
                    aportación de unos datos imprescindibles para la prestación de nuestros 
                    servicios.</p>
                <p>*** "Registro de ficheros y formularios"  ***</p>
                <p>La cumplimentación del formulario de registro es obligatoria para acceder y disfrutar de los servicios ofrecidos por UPINDER.</p>
            </div>
            <div class="modal-footer">
                <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Entendido</a>
            </div>
        </div>
    </body>
</html>
