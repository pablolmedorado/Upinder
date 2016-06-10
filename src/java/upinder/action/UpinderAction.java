package upinder.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;
import upinder.dao.UpinderDAO;
import upinder.modelo.*;

import upinder.util.Mailer;
import java.io.File;

public class UpinderAction extends ActionSupport  implements SessionAware, ServletRequestAware {
    private final String LOGED = "loged";
    private final String PERMISSION = "permission";
    
    private String toast;
    
    private Integer id;
    private String email;
    private String password;
    private String nombre;
    private String apellidos;
    private String fechanac;
    private boolean enlaupo;
    private int quebusca;
    private int titulacion;
    private String notiEmail;
    private String rutafoto;
    private String titulacion_nombre;
    
    private Usuario usuarioCompatible;
    
    private Foto foto;
    
    private String receptor;
    private String mensaje;    
    
    private boolean hasreaccion;
    private boolean muestraLike;
    
    private String texto;
    private Integer numNoLeidas;
    
    private int tipoDenuncia;
    private String declaracion;
    
    private List<TipoSexo> sexos;
    private List<Titulacion> titulaciones;
    private List<Foto> fotos;
    private List<Comentario> comentarios;
    private List<Reaccion> reacciones;
    private List<Usuario> usuarios;
    private List<Mensaje> mensajes;
    private List<Notificacion> notificaciones;
    private List<Match> matches;
    private List<TipoDenuncia> tiposDenuncia;
    
    private UpinderDAO dao;
    private SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
    private Map<String, Object> session;
    private Mailer m;

    private HttpServletRequest servletRequest;
    
    public UpinderAction() {
        dao = new UpinderDAO();
        session = ActionContext.getContext().getSession();
        m = new Mailer();
    }
    
    /*public String execute() throws Exception {
        throw new UnsupportedOperationException("Not supported yet.");
    }*/
    
    // Login
    public String goLogin(){
        return ActionSupport.SUCCESS;
    }
    
    public String doLogin(){
        try{
            Usuario u = dao.login(this.getEmail(), this.getPassword());
            if(u != null){
                if(!u.isActivado()){
                    addActionError("Usuario desactivado. Revise su email.");
                    return ActionSupport.ERROR;
                }
                session.put("user", u);
                session.put("nombre", u.getNombre());
                return ActionSupport.SUCCESS;
            }else{
                addActionError("Login incorrecto");
                return ActionSupport.ERROR;
            }
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }        
    }
    
    
    // Logout
    public String doLogout(){
        session.clear();
        return ActionSupport.SUCCESS;
    }
    
    
    // Alta de usuario
    public String goAlta(){
        try{
            this.setSexos(dao.getSexos());
            this.setTitulaciones(dao.getTitulaciones());
            return ActionSupport.SUCCESS;
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }        
    }
    
    
    // Perfil de usuario
    public String goPerfil(){
        try{
            if(session.containsKey("user")){
                Usuario u = (Usuario)session.get("user");
                System.out.println(u.getTipoSexoByQueBusca().getId());
                System.out.println(u.isEmailNot());
                
                this.setQuebusca(u.getTipoSexoByQueBusca().getId());
                this.setNotiEmail(u.isEmailNot()?"true":"false");

                this.setRutafoto(u.getFotoPerfil());
                this.setFotos(dao.getFotos(u));

                this.setSexos(dao.getSexos());                
                List<Notificacion> not = dao.getNoLeidas(u);
                this.setNumNoLeidas(not.size());
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doModificarPerfil(){
        try{
            if(session.containsKey("user")){
                System.out.println(this.getQuebusca());
                System.out.println(this.getNotiEmail());
                Usuario u = (Usuario)session.get("user");
                u.setTipoSexoByQueBusca(dao.getSexo(this.getQuebusca()));
                u.setEmailNot(this.getNotiEmail()!=null);
                dao.modifyUsuario(u);
                session.put("user", u);
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String deleteFoto(){
        try{
            if(session.containsKey("user")){
                Foto f = dao.getFoto(this.getId());
                Usuario user = (Usuario)session.get("user");
                
                if(f.getUsuario().getId() == user.getId()){
                    String path = servletRequest.getSession().getServletContext().getRealPath("/img");
                    File foto = new File(path, f.getUrl());
                    foto.delete();

                    if(f.isDePerfil()){
                        Usuario u = f.getUsuario();
                        u.setFotoPerfil(null);
                        dao.modifyUsuario(u);
                        session.put("user", u);
                    } 

                    dao.deleteFoto(f);

                    return ActionSupport.SUCCESS;
                }else{
                    return this.PERMISSION;
                }
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doClearDislikes(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                dao.clearDislikes(user.getId());
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doEliminarUsuario(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                dao.deleteUsuario(user);
                session.clear();
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doSetFotoPerfil(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                Foto f = dao.getFoto(this.getId());
                
                if(f.getUsuario().getId() == user.getId()){
                    dao.setFotoPerfil(user, f);
                    user.setFotoPerfil(f.getUrl());
                    dao.modifyUsuario(user);
                    session.put("user", user);
                    return ActionSupport.SUCCESS;
                }else{
                    return this.PERMISSION;
                }
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    
    
    // Vista de usuario    
    public String goUser(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                Usuario u2 = dao.getUsuario(this.getId());
                
                Boolean match = dao.hasMatch(user, u2);
                Boolean superlike = dao.hasSuperlike(u2, user);
                
                if(!match && !superlike){
                    return this.PERMISSION;
                }else{
                    Usuario u = dao.getUsuario(this.getId());
                    this.setRutafoto(u.getFotoPerfil());
                    this.setNombre(u.getNombre());
                    this.setFechanac(formato.format(u.getFechanac()));
                    this.setTitulacion_nombre(u.getTitulacion().getNombre());
                    this.setFotos(dao.getFotos(u2));
                    if(superlike && !match){
                        this.setMuestraLike(superlike);
                    }
                    List<Notificacion> not = dao.getNoLeidas(user);
                    this.setNumNoLeidas(not.size());
                    return ActionSupport.SUCCESS;
                }                
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }      
    }
    
    
    // Dashboard
    public String goDashboard(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                List<Notificacion> not = dao.getNoLeidas(user);
                this.setNumNoLeidas(not.size());
                this.setUsuarioCompatible(dao.getRandomUsuarioCompatible(user));
                if(this.getUsuarioCompatible() != null){
                    this.setId(this.getUsuarioCompatible().getId());
                    this.setNombre(this.getUsuarioCompatible().getNombre());
                    this.setFechanac(formato.format(this.getUsuarioCompatible().getFechanac()));
                    this.setFotos(new ArrayList<Foto>(this.getUsuarioCompatible().getFotos()));
                }
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    
    // Interacciones
    public String doLike(){
        try{
            if(session.containsKey("user")){
                Usuario e = (Usuario)session.get("user");
                Usuario r = dao.getUsuario(this.getId());
                dao.doLike(e, r, false);
                if((dao.hasLike(r, e) || dao.hasSuperlike(r, e)) && !dao.hasMatch(e, r)){
                    dao.newMatch(e, r);
                    Notificacion n1 = dao.newNotificacion(e, r, null, "Match");
                    Notificacion n2 = dao.newNotificacion(r, e, null, "Match");
                    if(e.isEmailNot()){
                        m.sendNotificationMail(e.getEmail(), e.getNombre(), n1.getTexto());
                    }                    
                    if(r.isEmailNot()){
                        m.sendNotificationMail(r.getEmail(), r.getNombre(), n2.getTexto());
                    }                    
                }
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doSuperlike(){
        try{
            if(session.containsKey("user")){
                Usuario e = (Usuario)session.get("user");
                Usuario r = dao.getUsuario(this.getId());
                dao.doLike(e, r, true);
                Notificacion n = dao.newNotificacion(r, e, null, "Superlike");
                if(r.isEmailNot()){
                    m.sendNotificationMail(r.getEmail(), r.getNombre(), n.getTexto());
                }
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doDislike(){
        try{
            if(session.containsKey("user")){
                Usuario e = (Usuario)session.get("user");
                Usuario r = dao.getUsuario(this.getId());
                dao.doDislike(e, r);
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    
    // Mensajes  
    public String goMensajes(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                this.setUsuarios(dao.getUsuariosMatch(user.getId()));
                if(this.getId() != null){
                    Usuario u2 = dao.getUsuario(this.getId());
                    if(!dao.hasMatch(user, u2)){
                        return this.PERMISSION;
                    }
                    this.setNombre(u2.getNombre());
                    this.setMensajes(dao.getConversation(user.getId(), u2.getId()));
                }
                List<Notificacion> not = dao.getNoLeidas(user);
                this.setNumNoLeidas(not.size());
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String newMsg(){
        try{
            if(session.containsKey("user")){
                if(this.getMensaje().isEmpty()){
                    this.setId(Integer.parseInt(this.getReceptor()));
                    return ActionSupport.INPUT;
                }
                Usuario user = (Usuario)session.get("user");
                Usuario receptor_aux = dao.getUsuario(Integer.parseInt(this.getReceptor()));
                
                dao.newMsg(user, receptor_aux, this.getMensaje());
                Notificacion n = dao.newNotificacion(receptor_aux, user, null, "Mensaje");
                if(receptor_aux.isEmailNot()){
                    m.sendNotificationMail(receptor_aux.getEmail(), receptor_aux.getNombre(), n.getTexto());
                }
                
                this.setUsuarios(dao.getUsuariosMatch(user.getId()));
                this.setMensajes(dao.getConversation(user.getId(), receptor_aux.getId()));
                this.setId(receptor_aux.getId());
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doDeleteMsg(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                Mensaje m = dao.getMensaje(this.getId());
                if(user.getId() == m.getUsuarioByEmisor().getId()){
                    dao.deleteMensaje(m);
                    this.setId(m.getUsuarioByReceptor().getId());
                    return ActionSupport.SUCCESS;
                }else{
                    return this.PERMISSION;
                }                
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    
    
    // Notificaciones
    public String goNotificaciones(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                this.setNotificaciones(dao.getLastNot(user));
                dao.markNotAsRead(user);
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doEliminarNotificaciones(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                dao.deleteNotificaciones(user);
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    
    
    // Fotos
    public String goFoto(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                Foto f = dao.getFoto(this.getId());
                
                Boolean match = dao.hasMatch(user, f.getUsuario());
                
                if(!match && user.getId()!=f.getUsuario().getId()){
                    return this.PERMISSION;
                }else{
                    this.setFoto(f);
                    this.setComentarios(dao.getComentariosFoto(f));
                    this.setReacciones(dao.getReactionsFoto(f));
                    this.setHasreaccion(dao.hasReactionFoto(f, user));
                    List<Notificacion> not = dao.getNoLeidas(user);
                    this.setNumNoLeidas(not.size());
                    return ActionSupport.SUCCESS;
                }
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String newComentarioFoto(){
        try{
            if(session.containsKey("user")){
                if(this.getTexto().isEmpty()){
                    return ActionSupport.INPUT;
                }
                Foto f = dao.getFoto(this.getId());
                Usuario u = (Usuario)session.get("user");
                
                dao.newComentarioFoto(f, u, this.getTexto());
                
                if(u.getId() != f.getUsuario().getId()){
                    Notificacion n = dao.newNotificacion(f.getUsuario(), u, f, "ComentarioFoto");
                    if(f.getUsuario().isEmailNot()){
                        m.sendNotificationMail(f.getUsuario().getEmail(), f.getUsuario().getNombre(), n.getTexto());
                    }
                }
                
                this.setFoto(f);
                this.setComentarios(dao.getComentariosFoto(f));
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doReactionFoto(){
        try{
            if(session.containsKey("user")){
                Usuario u = (Usuario)session.get("user");
                Foto f = dao.getFoto(this.getId());
                dao.doReactionFoto(f, u);
                if(u.getId() != f.getUsuario().getId()){
                    Notificacion n = dao.newNotificacion(f.getUsuario(), u, f, "ReaccionFoto");
                    if(f.getUsuario().isEmailNot()){
                        m.sendNotificationMail(f.getUsuario().getEmail(), f.getUsuario().getNombre(), n.getTexto());
                    }
                }
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doDeleteReactionFoto(){
        try{
            if(session.containsKey("user")){
                Usuario u = (Usuario)session.get("user");
                Foto f = dao.getFoto(this.getId());
                dao.deleteReactionFoto(f, u);
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doDeleteComentario(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                Comentario c = dao.getComentario(this.getId());
                if(user.getId() == c.getUsuario().getId()){
                    dao.deleteComentario(c);
                    this.setId(c.getFoto().getId());
                    return ActionSupport.SUCCESS;
                }else{
                    return this.PERMISSION;
                }                
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    
    
    // Matches
    public String goMatches(){
        try{
            if(session.containsKey("user")){
                Usuario u = (Usuario)session.get("user");
                this.setMatches(dao.getMatches(u));
                List<Notificacion> not = dao.getNoLeidas(u);
                this.setNumNoLeidas(not.size());
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doDeleteMatch(){
        try{
            if(session.containsKey("user")){
                Usuario u = (Usuario)session.get("user");
                Usuario u2 = dao.getUsuario(this.getId());
                dao.deleteMatch(u, u2);
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    
    
    // Denuncias
    public String goDenuncia(){
        try{
            if(session.containsKey("user")){
                Usuario user = (Usuario)session.get("user");
                this.setTiposDenuncia(dao.getTiposDenuncia());
                Usuario u = dao.getUsuario(this.getId());
                this.setNombre(u.getNombre() + " " + u.getApellidos());
                List<Notificacion> not = dao.getNoLeidas(user);
                this.setNumNoLeidas(not.size());
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    public String doDenuncia(){
        try{
            if(session.containsKey("user")){
                if(this.getDeclaracion().isEmpty()){
                    return ActionSupport.INPUT;
                }
                Usuario user = (Usuario)session.get("user");
                Usuario u = dao.getUsuario(this.getId());
                Denuncia d = new Denuncia();
                d.setTipoDenuncia(dao.getTipoDenuncia(this.getTipoDenuncia()));
                d.setDeclaracion(this.getDeclaracion());
                d.setUsuarioByDenunciado(u);
                d.setUsuarioByUsuario(user);
                d.setFechaDenuncia(new Date(System.currentTimeMillis()));
                dao.newDenuncia(d);
                
                String path = servletRequest.getSession().getServletContext().getRealPath("/pdf");
                m.sendDenunciaMail(user.getEmail(), user.getNombre(), user.getNombre() + " " + user.getApellidos(),
                        u.getNombre() + " " + u.getApellidos(), d.getTipoDenuncia().getNombre(), d.getDeclaracion(), path);
                return ActionSupport.SUCCESS;
            }else{
                return ActionSupport.LOGIN;
            }            
        }catch(Exception e){
            e.printStackTrace();
            return ActionSupport.ERROR;
        }
    }
    
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<TipoSexo> getSexos() {
        return sexos;
    }

    public void setSexos(List<TipoSexo> sexos) {
        this.sexos = sexos;
    }

    public List<Titulacion> getTitulaciones() {
        return titulaciones;
    }

    public void setTitulaciones(List<Titulacion> titulaciones) {
        this.titulaciones = titulaciones;
    }

    @Override
    public void setSession(Map<String, Object> map) {
        this.session = map;
    }

    public int getQuebusca() {
        return quebusca;
    }

    public void setQuebusca(int quebusca) {
        this.quebusca = quebusca;
    }

    public int getTitulacion() {
        return titulacion;
    }

    public void setTitulacion(int titulacion) {
        this.titulacion = titulacion;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getFechanac() {
        return fechanac;
    }

    public void setFechanac(String fechanac) {
        this.fechanac = fechanac;
    }

    public boolean isEnlaupo() {
        return enlaupo;
    }

    public void setEnlaupo(boolean enlaupo) {
        this.enlaupo = enlaupo;
    }

    public String getRutafoto() {
        return rutafoto;
    }

    public void setRutafoto(String rutafoto) {
        this.rutafoto = rutafoto;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public List<Foto> getFotos() {
        return fotos;
    }

    public void setFotos(List<Foto> fotos) {
        this.fotos = fotos;
    }

    public Usuario getUsuarioCompatible() {
        return usuarioCompatible;
    }

    public void setUsuarioCompatible(Usuario usuarioCompatible) {
        this.usuarioCompatible = usuarioCompatible;
    }

    public List<Usuario> getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(List<Usuario> usuarios) {
        this.usuarios = usuarios;
    }

    public List<Mensaje> getMensajes() {
        return mensajes;
    }

    public void setMensajes(List<Mensaje> mensajes) {
        this.mensajes = mensajes;
    }

    public String getReceptor() {
        return receptor;
    }

    public void setReceptor(String receptor) {
        this.receptor = receptor;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public Integer getNumNoLeidas() {
        return numNoLeidas;
    }

    public void setNumNoLeidas(Integer numNoLeidas) {
        this.numNoLeidas = numNoLeidas;
    }

    public List<Notificacion> getNotificaciones() {
        return notificaciones;
    }

    public void setNotificaciones(List<Notificacion> notificaciones) {
        this.notificaciones = notificaciones;
    }

    public boolean isMuestraLike() {
        return muestraLike;
    }

    public void setMuestraLike(boolean muestraLike) {
        this.muestraLike = muestraLike;
    }

    public Foto getFoto() {
        return foto;
    }

    public void setFoto(Foto foto) {
        this.foto = foto;
    }

    public List<Comentario> getComentarios() {
        return comentarios;
    }

    public void setComentarios(List<Comentario> comentarios) {
        this.comentarios = comentarios;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public List<Reaccion> getReacciones() {
        return reacciones;
    }

    public void setReacciones(List<Reaccion> reacciones) {
        this.reacciones = reacciones;
    }

    public boolean isHasreaccion() {
        return hasreaccion;
    }

    public void setHasreaccion(boolean hasreaccion) {
        this.hasreaccion = hasreaccion;
    }

    public List<Match> getMatches() {
        return matches;
    }

    public void setMatches(List<Match> matches) {
        this.matches = matches;
    }

    public List<TipoDenuncia> getTiposDenuncia() {
        return tiposDenuncia;
    }

    public void setTiposDenuncia(List<TipoDenuncia> tiposDenuncia) {
        this.tiposDenuncia = tiposDenuncia;
    }

    public int getTipoDenuncia() {
        return tipoDenuncia;
    }

    public void setTipoDenuncia(int tipoDenuncia) {
        this.tipoDenuncia = tipoDenuncia;
    }

    public String getDeclaracion() {
        return declaracion;
    }

    public void setDeclaracion(String declaracion) {
        this.declaracion = declaracion;
    }

    public HttpServletRequest getServletRequest() {
        return servletRequest;
    }

    public void setServletRequest(HttpServletRequest servletRequest) {
        this.servletRequest = servletRequest;
    }

    public String getNotiEmail() {
        return notiEmail;
    }

    public void setNotiEmail(String notiEmail) {
        this.notiEmail = notiEmail;
    }

    public String getTitulacion_nombre() {
        return titulacion_nombre;
    }

    public void setTitulacion_nombre(String titulacion_nombre) {
        this.titulacion_nombre = titulacion_nombre;
    }

    public String getToast() {
        return toast;
    }

    public void setToast(String toast) {
        this.toast = toast;
    }
    
    
}
