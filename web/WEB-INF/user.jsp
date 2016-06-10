<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Perfil de <s:property value='nombre'/></title>
        <script>
            $(document).ready(function () {
                $('#edad').text(moment().diff("<s:property value='fechanac'/>", 'years'));
                $(".button-collapse").sideNav();
                $('.slick').slick({
                    dots: true,
                    arrows: false,
                    infinite: true,
                    speed: 300,
                    slidesToShow: 1,
                    centerMode: true,
                    variableWidth: true
                });
            });
        </script>
    </head>
    <body>
        <s:include value="navbar_template.jsp"/>
        <div class="container">
            <div class="card">
                <div class="card-content">
                    <span class="card-title"><s:property value='nombre'/>,&nbsp;<span id="edad"></span></span>
                    <div class="center-align" style="clear: both">
                        <img src="img/<s:property value='rutafoto' default='no_user.png'/>" alt="" class="circle responsive-img" style="max-height: 250px;">
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Titulación</span>
                    <div class="row">
                        <div class="col s12 center-align">
                            <span style="font-size: 18px;"><s:property value='titulacion_nombre'/></span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card">
                <div class="card-content">
                    <span class="card-title">Fotos</span>
                    <div class="row">
                        <div class="col s12">
                            <div class="slick">
                                <s:iterator value="fotos" var="foto">
                                    <div><a href="goFoto.action?id=<s:property value='#foto.id'/>"><img style="max-height: 300px" src="img/<s:property value='#foto.url' default='no_user.png'/>"></a></div>
                                </s:iterator>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <s:if test="muestraLike">
            <div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
                <a id="doLike" href="doLike.action?id=<s:property value='id'/>" class="btn-floating btn-large red">
                    <i class="large material-icons">favorite</i>
                </a>
            </div>
        </s:if>
        <s:else>
            <div class="fixed-action-btn" style="bottom: 45px; right: 24px;">
                <a id="goMensajes" href="goMensajes.action?id=<s:property value='id'/>" class="btn-floating btn-large teal">
                    <i class="large material-icons">email</i>
                </a>
            </div>
        </s:else>
    </body>
</html>
