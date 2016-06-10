<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Mi Perfil</title>
        <script>
            $(document).ready(function () {
                $(".button-collapse").sideNav();
                $('.modal-trigger').leanModal();
                
                $("#notiEmail").prop('checked', <s:property value="notiEmail"/>);            
                
                $('select').val(<s:property value="quebusca"/>);
                $('select').material_select();
            });
        </script>
        <style>
            .modal.modal-fixed-footer.baja {
                height: 300px;
            }
        </style>
    </head>
    <body>
        <s:include value="navbar_template.jsp"/>
        <div class="container">
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Foto de perfil</span>
                    <div class="center-align" style="clear: both">
                        <img src="img/<s:property value='rutafoto' default='no_user.png'/>" alt="" class="circle responsive-img" style="max-height: 250px;">
                    </div>
                    <s:form action="doSubirFoto.action" method="post" enctype="multipart/form-data">
                        <s:hidden name="dePerfil" value="true"/>
                        <s:hidden name="titulo" value="Foto de perfil"/>
                        <div class="row">
                            <div class="file-field input-field col s12">
                                <div class="btn">
                                    <span>Seleccionar</span>
                                    <s:file name="foto"/>
                                </div>
                                <div class="file-path-wrapper">
                                    <input class="file-path validate" type="text">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div style="float: right; margin-right: 10px;">
                                <s:submit value="Cargar" cssClass="btn waves-effect waves-light"/>
                            </div>
                        </div>
                    </s:form>
                </div>
            </div>
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Datos Personales</span>
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_circle</i>
                            <input disabled name="nombre" type="text" value="<s:property value="#session.user.nombre"/>">
                            <label for="nombre">Nombre</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">account_circle</i>
                            <input disabled name="apellidos" type="text" value="<s:property value="#session.user.apellidos"/>">
                            <label for="apellidos">Apellidos</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">email</i>
                            <input disabled name="email" type="text" value="<s:property value="#session.user.email"/>">
                            <label for="email">Email</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">school</i>
                            <input disabled name="titulacion" type="text" value="<s:property value="#session.user.titulacion.nombre"/>">
                            <label for="titulacion">Titulacion</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">cake</i>
                            <input disabled name="fechanac" type="text" value="<s:property value="#session.user.fechanac"/>">
                            <label for="fechanac">Fecha de Nacimiento</label>
                        </div>
                        <div class="input-field col s12 m6">
                            <i class="material-icons prefix">wc</i>
                            <input disabled name="sexo" type="text" value="<s:property value="#session.user.tipoSexoBySexo.nombre"/>">
                            <label for="sexo">Sexo</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Preferencias</span>
                    <div class="center-align" style="clear: both">
                        <span class="red-text text-darken-3">
                            <s:fielderror/><s:actionerror/>
                        </span>
                    </div>
                    <form method="POST" action="doModificarPerfil.action">
                        <div class="row">
                            <div class="input-field col s12 m6">
                                <s:select name="quebusca" id="quebusca" list="sexos" listKey="id" listValue="nombre"></s:select>
                                <label for="quebusca">Busca</label>
                            </div>
                            <div class="input-field col s12 m6">
                                <input name="notiEmail" type="checkbox" id="notiEmail" />
                                <label for="notiEmail">Notificaciones por correo</label>
                            </div>
                        </div>
                        <div class="row">
                            <div style="float: right; margin-right: 10px;">
                                <button class="btn waves-effect waves-light" type="submit" name="action">Guardar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Fotos<a class="right modal-trigger" href="#cargarFoto"><i class="material-icons" style="font-size: 2rem; color: black;">queue</i></a></span>
                    <div class="row">
                    <s:iterator value="fotos">
                        <div class="col s12 m6 l4" style="margin-bottom: 15px;">
                            <div class="row">
                                <div class="col s12 center-align">
                                    <img height="200" src="img/<s:property value='url' default='no_user.png'/>">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s12 center-align">
                                    <a href="goFoto.action?id=<s:property value='id'/>" title="Ir a la foto"><i class="material-icons" style="color: black;">open_in_new</i></a>
                                    <a href="doSetFotoPerfil.action?id=<s:property value='id'/>" title="Seleccionar como foto de perfil"><i class="material-icons" style="color: black;">account_box</i></a>
                                    <a href="deleteFoto.action?id=<s:property value='id'/>" title="Eliminar foto"><i class="material-icons" style="color: red;">delete</i></a>
                                </div>
                            </div>
                        </div>
                    </s:iterator>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Resetear dislikes</span>
                    <div class="row">
                        <div class="col s12">
                            <a class="waves-effect waves-light btn amber darken-4" href="doClearDislikes.action">Resetear dislikes</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Eliminar cuenta</span>
                    <div class="row">
                        <div class="col s12">
                            <a class="modal-trigger waves-effect waves-light btn red" href="#modalBaja">Eliminar cuenta</a>
                        </div>
                    </div>
                </div>
            </div>
            <div id="cargarFoto" class="modal">
                <div class="modal-content">
                    <h4>Carga de foto</h4>
                    <s:form action="doSubirFoto.action" method="post" enctype="multipart/form-data">
                        <s:hidden name="dePerfil" value="false"/>
                        <div class="row">
                            <div class="input-field col s12">
                                <input id="titulo" name="titulo" type="text" class="validate" required>
                                <label for="titulo">Titulo</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="file-field input-field col s12">
                                <div class="btn">
                                    <span>Seleccionar</span>
                                    <s:file name="foto"/>
                                </div>
                                <div class="file-path-wrapper">
                                    <input class="file-path validate" type="text">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div style="float: right; margin-right: 10px;">
                                <s:submit value="Cargar" cssClass="btn waves-effect waves-light"/>
                            </div>
                        </div>
                    </s:form>
                </div>
                <div class="modal-footer">
                    <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat">Cerrar</a>
                </div>
            </div>
            <div id="modalBaja" class="modal modal-fixed-footer baja">
                <div class="modal-content">
                    <h4>Confirmación de eliminación</h4>
                    <p>¿Está seguro que desea eliminar la cuenta?</p>
                    <p>Este proceso es irreversible y eliminará todos sus datos de Upinder.</p>
                </div>
                <div class="modal-footer">
                    <a href="doEliminarUsuario.action" class="modal-action modal-close waves-effect waves-green btn-flat ">Eliminar</a>
                    <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">Cancelar</a>
                </div>
            </div>
        </div>
    </body>
</html>
