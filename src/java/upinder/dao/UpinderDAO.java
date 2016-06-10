package upinder.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import upinder.modelo.*;

import org.mindrot.jbcrypt.BCrypt;

public class UpinderDAO {

    private Session sesionhb;
    private Transaction tx;
    private Query q;
    private Criteria c;

    public UpinderDAO() {
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
    }

    // Usuarios
    
    public Usuario login(String user, String password) {
        try {
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Usuario.class);
            c.add(Restrictions.eq("email", user));
            Usuario usuario = (Usuario) c.uniqueResult();
            tx.commit();

            if (BCrypt.checkpw(password, usuario.getPassword())) {
                return usuario;
            } else {
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    public Boolean existeUsuario(String email) {
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Usuario.class);
            c.add(Restrictions.eq("email", email));
            List<Usuario> usuarios = (List<Usuario>) c.list();
            tx.commit();
            
            return usuarios.size()>0;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public void altaUsuario(Usuario u) {
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        sesionhb.save(u);
        tx.commit();
    }    
    public void modifyUsuario(Usuario u) {
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        sesionhb.saveOrUpdate(u);
        tx.commit();
    }
    public Usuario getUsuario(Integer id) {
        Usuario u = null;
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        u = (Usuario) sesionhb.get(Usuario.class, id);
        tx.commit();
        return u;
    }
    public Usuario getUsuarioByEmail(String email){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Usuario.class);
            c.add(Restrictions.eq("email", email));
            Usuario u = (Usuario)c.uniqueResult();
            tx.commit();
            return u;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public void deleteUsuario(Usuario u){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.delete(u);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    
    // GET Sexo y Titulacion

    public TipoSexo getSexo(Integer id) {
        TipoSexo sexo = null;
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        sexo = (TipoSexo) sesionhb.get(TipoSexo.class, id);
        tx.commit();
        return sexo;
    }
    public List<TipoSexo> getSexos() {
        List<TipoSexo> sexos = null;
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        c = sesionhb.createCriteria(TipoSexo.class);
        sexos = c.list();
        tx.commit();

        return sexos;
    }
    public Titulacion getTitulacion(Integer id) {
        Titulacion titulacion = null;
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            titulacion = (Titulacion) sesionhb.get(Titulacion.class, id);
            tx.commit();
            return titulacion;
        }catch(Exception e){
            e.printStackTrace();
            return titulacion;
        }
    }
    public List<Titulacion> getTitulaciones() {
        List<Titulacion> titulaciones = new ArrayList();
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Titulacion.class);
            c.addOrder(Order.asc("nombre"));
            titulaciones = c.list();
            tx.commit();
            return titulaciones;
        }catch(Exception e){
            e.printStackTrace();
            return titulaciones;
        }
    }  

    
    // Matches e interacciones
    
    public List<Match> getMatches(Usuario u){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Match.class);
            c.add(Restrictions.eq("usuarioByUsuario1", u));
            List<Match> l = c.list();
            tx.commit();
            return l;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }    
    public void deleteMatch(Usuario u, Usuario u2){
        try{
            Match m = new Match();
            
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Match.class);
            c.add(Restrictions.eq("usuarioByUsuario1", u));
            c.add(Restrictions.eq("usuarioByUsuario2", u2));
            m = (Match)c.uniqueResult();
            sesionhb.delete(m);
            c = sesionhb.createCriteria(Match.class);
            c.add(Restrictions.eq("usuarioByUsuario1", u2));
            c.add(Restrictions.eq("usuarioByUsuario2", u));
            m = (Match)c.uniqueResult();
            sesionhb.delete(m);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public Usuario getRandomUsuarioCompatible(Usuario u) {
        try{
            Random aleatorio = new Random(System.currentTimeMillis());
            
            List<Integer> l = new ArrayList<>();
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            q = sesionhb.createSQLQuery(
                    "SELECT DISTINCT `id` FROM `usuario` WHERE `id` != :id AND "
                            + "`sexo` = :sexo AND `que_busca` = :queBusca AND `activado`='1' AND "
                            + "`id` NOT IN (SELECT DISTINCT `receptor` FROM `interaccion` WHERE `emisor`= :id)")
                    .setParameter("id", u.getId())
                    .setParameter("sexo", u.getTipoSexoByQueBusca())
                    .setParameter("queBusca", u.getTipoSexoBySexo());
            l = q.list();
            tx.commit();

            if (l.size() > 0) {
                return this.getUsuario(l.get(aleatorio.nextInt(l.size())));
            }else{
                return null;
            }
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    
    public void doLike(Usuario emisor, Usuario receptor, Boolean isSuperlike){
        try {
            Interaccion i = new Interaccion();
            i.setUsuarioByEmisor(emisor);
            i.setUsuarioByReceptor(receptor);
            i.setFecha(new Date(System.currentTimeMillis()));
            if(isSuperlike){
                i.setTipo("superlike");
            }else{
                i.setTipo("like");
            }
            
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(i);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
            tx.rollback();
        }
    }
    
    public void newMatch(Usuario u1, Usuario u2){
        try{
            Match m = new Match(u1, u2, new Date(System.currentTimeMillis()));
            Match m2 = new Match(u2, u1, new Date(System.currentTimeMillis()));

            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(m);
            sesionhb.save(m2);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public Notificacion newNotificacion(Usuario u, Usuario usu_aux, Foto foto_aux, String tipo) throws Exception{
        try{
            Notificacion n = new Notificacion();
            switch(tipo){
                case "Match":
                    n.setTipo("Match");
                    n.setTexto("¡Nuevo match con " + usu_aux.getNombre() + "!");
                    break;
                case "Superlike":
                    n.setTipo("Superlike");
                    n.setTexto("Has recibido un superlike de " + usu_aux.getNombre());
                    break;
                case "Mensaje":
                    n.setTipo("Mensaje");
                    n.setTexto("Tienes un nuevo mensaje de " + usu_aux.getNombre());
                    break;
                case "ComentarioFoto":
                    n.setTipo("ComentarioFoto");
                    n.setTexto("Tienes un nuevo comentario de " + usu_aux.getNombre() +" en una de tus fotos");
                    n.setFoto(foto_aux);
                    break;
                case "ReaccionFoto":
                    n.setTipo("ReaccionFoto");
                    n.setTexto(usu_aux.getNombre() +" ha reaccionado a una de tus fotos");
                    n.setFoto(foto_aux);
                    break;
                default:
                    throw new Exception();
            }
            n.setUsuarioByUsuario(u);
            n.setUsuarioByUsuarioAux(usu_aux);
            n.setFechaCreacion(new Date(System.currentTimeMillis()));

            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(n);
            tx.commit();
            return n;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    
    public void doDislike(Usuario emisor, Usuario receptor){
        try{
            Interaccion i = new Interaccion();
            i.setUsuarioByEmisor(emisor);
            i.setUsuarioByReceptor(receptor);
            i.setFecha(new Date(System.currentTimeMillis()));
            i.setTipo("dislike");

            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(i);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    public boolean hasLike(Usuario emisor, Usuario receptor){
        List<Interaccion> l = new ArrayList<>();
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        c = sesionhb.createCriteria(Interaccion.class);
        c.add(Restrictions.eq("usuarioByEmisor", emisor));
        c.add(Restrictions.eq("usuarioByReceptor", receptor));
        c.add(Restrictions.eq("tipo", "like"));
        l = c.list();
        tx.commit();
        
        return l.size()>0;
    }
    
    public boolean hasSuperlike(Usuario emisor, Usuario receptor){
        List<Interaccion> l = new ArrayList<>();
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        c = sesionhb.createCriteria(Interaccion.class);
        c.add(Restrictions.eq("usuarioByEmisor", emisor));
        c.add(Restrictions.eq("usuarioByReceptor", receptor));
        c.add(Restrictions.eq("tipo", "superlike"));
        l = c.list();
        tx.commit();
        
        return l.size()>0;
    }
    
    public boolean hasDislike(Usuario emisor, Usuario receptor){
        List<Interaccion> l = new ArrayList<>();
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        c = sesionhb.createCriteria(Interaccion.class);
        c.add(Restrictions.eq("emisor", emisor));
        c.add(Restrictions.eq("receptor", receptor));
        c.add(Restrictions.eq("tipo", "dislike"));
        l = c.list();
        tx.commit();
        
        return l.size()>0;
    }
    
    public boolean hasMatch(Usuario usuario, Usuario usuario2){
        List<Match> l = new ArrayList<>();
        
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        c = sesionhb.createCriteria(Match.class);
        c.add(Restrictions.eq("usuarioByUsuario1", usuario));
        c.add(Restrictions.eq("usuarioByUsuario2", usuario2));
        l = c.list();
        tx.commit();
        
        return l.size()>0;
    }
    
    public void clearDislikes(Integer id){
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        q = sesionhb.createSQLQuery("DELETE FROM `interaccion` WHERE `emisor` = :id and `tipo` = 'dislike'")
                .setParameter("id", id);
        q.executeUpdate();
        tx.commit();
    }
    
    public List<Usuario> getUsuariosMatch(Integer id){
        try{
            List<Integer> lista_id = new ArrayList<>();
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            
            q = sesionhb.createSQLQuery(
                    "SELECT DISTINCT `usuario2` FROM `match` WHERE `usuario1` = :id")
                    .setParameter("id", id);
            lista_id = q.list();
            
            List<Usuario> lista_users = new ArrayList();
            if(lista_id.size()>0){
                c = sesionhb.createCriteria(Usuario.class);
                c.add(Restrictions.in("id", lista_id));
                lista_users = c.list();
            }
            
            tx.commit();
            return lista_users;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    
    
    
    // Mensajes
    
    public List<Mensaje> getConversation(Integer usuario1, Integer usuario2){
        try{
            List<Mensaje> mensajes = new ArrayList();
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            q = sesionhb.createSQLQuery(
                    "SELECT * FROM `mensaje` WHERE ( `emisor` = :usuario1 AND `receptor`= :usuario2 ) OR (`receptor` = :usuario1 AND `emisor`= :usuario2 ) "
                            + "ORDER BY `fecha_envio` DESC LIMIT 50")
                    .addEntity(Mensaje.class)
                    .setParameter("usuario1", usuario1)
                    .setParameter("usuario2", usuario2);
            mensajes = q.list();
            tx.commit();

            return mensajes;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }    
    public Mensaje newMsg(Usuario emisor, Usuario receptor, String texto){
        try{
            Mensaje m = new Mensaje();
            m.setUsuarioByEmisor(emisor);
            m.setUsuarioByReceptor(receptor);
            m.setTexto(texto);
            m.setFechaEnvio(new Date(System.currentTimeMillis()));
            
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(m);
            tx.commit();
            return m;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public Mensaje getMensaje(Integer id){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            Mensaje m = (Mensaje)sesionhb.get(Mensaje.class, id);
            tx.commit();
            return m;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public void deleteMensaje(Mensaje m){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.delete(m);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    
    
    // Notificaciones
    
    public List<Notificacion> getNoLeidas(Usuario u){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Notificacion.class);
            c.add(Restrictions.eq("usuarioByUsuario", u));
            c.add(Restrictions.isNull("fechaLectura"));
            c.addOrder(Order.desc("fechaCreacion"));
            List <Notificacion> l = c.list();
            tx.commit();
            return l;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }    
    public List<Notificacion> getLastNot(Usuario u){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Notificacion.class);
            c.add(Restrictions.eq("usuarioByUsuario", u));
            c.addOrder(Order.desc("fechaCreacion"));
            c.setMaxResults(20);
            List <Notificacion> l = c.list();
            tx.commit();
            return l;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }    
    public void markNotAsRead(Usuario u){
        List<Notificacion> nots = getNoLeidas(u);
        
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        for(Notificacion n : nots){
            n.setFechaLectura(new Date(System.currentTimeMillis()));
            sesionhb.saveOrUpdate(n);
        }
        tx.commit();
    }
    public void deleteNotificaciones(Usuario u){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            q = sesionhb.createSQLQuery("DELETE FROM `notificacion` WHERE `usuario` = :id")
                .setParameter("id", u.getId());
            q.executeUpdate();
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    
    // Foto
    
    public Foto getFoto(Integer id){
        Foto f = null;
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            f = (Foto) sesionhb.get(Foto.class, id);
            tx.commit();
            return f;
        }catch(Exception e){
            e.printStackTrace();
            return f;
        }
    }
    public void newFoto(Foto f) {
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(f);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public void deleteFoto(Foto f) {
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        sesionhb.delete(f);
        tx.commit();
    }
    public List<Foto> getFotos(Usuario u){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Foto.class);
            c.add(Restrictions.eq("usuario", u));
            c.addOrder(Order.desc("id"));
            List<Foto> l = c.list();
            tx.commit();
            return l;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public void setFotoPerfil(Usuario u, Foto f){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Foto.class);
            c.add(Restrictions.eq("usuario", u));
            c.add(Restrictions.eq("dePerfil", true));
            List<Foto> l = c.list();
            
            Iterator itr = l.iterator();
            while(itr.hasNext()) {
                Foto aux = (Foto)itr.next();
                aux.setDePerfil(false);
                sesionhb.saveOrUpdate(aux);
            }
            
            f.setDePerfil(true);
            sesionhb.saveOrUpdate(f);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    
    
    // Comentarios
    
    public List<Comentario> getComentariosFoto(Foto f){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Comentario.class);
            c.add(Restrictions.eq("foto", f));
            c.addOrder(Order.desc("fechaPublicacion"));
            List <Comentario> l = c.list();
            tx.commit();
            return l;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }    
    public Comentario newComentarioFoto(Foto foto, Usuario usuario, String texto){
        try{
            Comentario com = new Comentario();
            com.setFoto(foto);
            com.setUsuario(usuario);
            com.setTexto(texto);
            com.setFechaPublicacion(new Date(System.currentTimeMillis()));            
            
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(com);            
            tx.commit();
            return com;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public Comentario getComentario(Integer id){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            Comentario c = (Comentario)sesionhb.get(Comentario.class, id);
            tx.commit();
            return c;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
    public void deleteComentario(Comentario c){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.delete(c);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    
    
    
    // Reacciones
    
    public void doReactionFoto(Foto foto, Usuario usuario){
        try{
            Reaccion r = new Reaccion();
            r.setFoto(foto);
            r.setUsuario(usuario);
            
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(r);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }    
    public void deleteReactionFoto(Foto foto, Usuario usuario){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Reaccion.class);
            c.add(Restrictions.eq("foto", foto));
            c.add(Restrictions.eq("usuario", usuario));
            Reaccion r = (Reaccion)c.uniqueResult();
            sesionhb.delete(r);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }    
    public List<Reaccion> getReactionsFoto(Foto foto){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Reaccion.class);
            c.add(Restrictions.eq("foto", foto));
            List<Reaccion> l = c.list();
            tx.commit();
            
            return l;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }    
    public boolean hasReactionFoto(Foto foto, Usuario usuario){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(Reaccion.class);
            c.add(Restrictions.eq("foto", foto));
            c.add(Restrictions.eq("usuario", usuario));
            List<Reaccion> l = c.list();
            tx.commit();
            
            return l.size()>0;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
    

    
    // Denuncia  
    
    public void newDenuncia(Denuncia d){
        try{
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            sesionhb.save(d);
            tx.commit();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public List<TipoDenuncia> getTiposDenuncia() {
        try{
            List<TipoDenuncia> denuncias = null;
            sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
            tx = sesionhb.beginTransaction();
            c = sesionhb.createCriteria(TipoDenuncia.class);
            denuncias = c.list();
            tx.commit();

            return denuncias;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }    
    public TipoDenuncia getTipoDenuncia(Integer id) {
        TipoDenuncia d = null;
        sesionhb = HibernateUtil.getSessionFactory().getCurrentSession();
        tx = sesionhb.beginTransaction();
        d = (TipoDenuncia) sesionhb.get(TipoDenuncia.class, id);
        tx.commit();
        return d;
    }
}
