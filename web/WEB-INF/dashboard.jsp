<%@taglib prefix="s" uri="/struts-tags"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <s:include value="imports_template.jsp"/>
        
        <title>Upinder</title>
        <script>
            $(document).ready(function () {
                $(".button-collapse").sideNav();
                $('#edad').text(moment().diff("<s:property value='fechanac'/>", 'years'));
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
            <s:if test="usuarioCompatible">
                <div class="card">
                    <div class="card-content">
                        <span class="card-title"><s:property value='nombre'/>,&nbsp;<span id="edad"></span></span>
                        <s:if test="fotos.size()>0">
                            <div class="slick">
                                <s:iterator value="fotos">
                                    <div><img style="max-height: 300px" src="img/<s:property value='url' default='no_user.png'/>"></div>
                                </s:iterator>    
                            </div>
                        </s:if>
                        <s:else>
                            <div class="row">
                                <div class="col s12 center-align">
                                    <img style="max-height: 300px" src="img/no_user.png">
                                </div>
                            </div>
                        </s:else>                        
                    </div>
                    <div class="card-action center-align">
                        <a href="doLike.action?id=<s:property value='id'/>" class="waves-effect waves-light btn-floating btn-large green"><i class="material-icons left">favorite</i>Like</a>
                        <a href="doSuperlike.action?id=<s:property value='id'/>" class="waves-effect waves-light btn-floating btn-large blue"><i class="material-icons left">grade</i>SuperLike</a>
                        <a href="doDislike.action?id=<s:property value='id'/>" class="waves-effect waves-light btn-floating btn-large red"><i class="material-icons left">clear</i>Dislike</a>
                    </div>
                </div>                
            </s:if>
            <s:else>
                <div class="row">
                    <div class="col s12">
                        <div class="card-panel">
                            <p>Actualmente no existen usuarios compatibles contigo. Inténtalo más tarde.</p>
                        </div>
                    </div>
                </div>
            </s:else>
        </div>
    </body>
</html>
