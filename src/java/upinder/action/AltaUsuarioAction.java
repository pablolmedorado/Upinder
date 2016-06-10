/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package upinder.action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.validator.annotations.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import upinder.dao.UpinderDAO;
import upinder.modelo.Usuario;

import org.mindrot.jbcrypt.BCrypt;
import upinder.util.Mailer;

/**
 *
 * @author neopablinho
 */
public class AltaUsuarioAction extends ActionSupport {
    private int quebusca;
    private int sexo;
    private int titulacion;
    private String password;
    private String email;
    private String nombre;
    private String apellidos;
    private String fechanac;
    
    private UpinderDAO dao;
    private Mailer m;
    private SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
    
    public AltaUsuarioAction() {
        dao = new UpinderDAO();
        m = new Mailer();
    }
    
    public String execute() {
        try{
            if(!dao.existeUsuario(this.getEmail())){
                Usuario u = new Usuario();

                u.setNombre(this.getNombre());
                u.setApellidos(this.getApellidos());
                u.setPassword(BCrypt.hashpw(this.getPassword(), BCrypt.gensalt()));
                u.setEmail(this.getEmail());
                u.setFechanac(this.formato.parse(this.getFechanac()));
                u.setFechaalta(new Date(System.currentTimeMillis()));
                u.setCodAct(String.valueOf(System.currentTimeMillis()));
                u.setEmailNot(true);

                u.setTipoSexoByQueBusca(dao.getSexo(this.getQuebusca()));
                u.setTipoSexoBySexo(dao.getSexo(this.getSexo()));
                u.setTitulacion(dao.getTitulacion(this.getTitulacion()));
            
                dao.altaUsuario(u);
                m.sendAltaMail(u.getEmail(), u.getNombre(), this.getPassword(), u.getCodAct());
                return ActionSupport.SUCCESS;
            }else{
                addActionError("Usuario ya registrado");
                return ActionSupport.ERROR;
            }            
        }catch(Exception e){
            return ActionSupport.ERROR;
        }
    }

    public int getQuebusca() {
        return quebusca;
    }

    @RequiredFieldValidator(message="Campo sexo buscado obligatorio")
    public void setQuebusca(int quebusca) {
        this.quebusca = quebusca;
    }

    public int getSexo() {
        return sexo;
    }

    @RequiredFieldValidator(message="Campo sexo obligatorio")
    public void setSexo(int sexo) {
        this.sexo = sexo;
    }

    public int getTitulacion() {
        return titulacion;
    }
    
    @RequiredFieldValidator(message="Campo titulación obligatorio")
    public void setTitulacion(int titulacion) {
        this.titulacion = titulacion;
    }

    public String getPassword() {
        return password;
    }
    
    @RequiredStringValidator(message="Campo password obligatorio")
    @StringLengthFieldValidator(minLength="8" , maxLength = "20", message = "Longitud minima de la contraseña: 8 caracteres")
    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    @RequiredStringValidator(message="Campo email obligatorio")
    //@RegexFieldValidator(message="Sólo se aceptan direcciones de email upo.es", regex = "^.+@(.+\\.)?upo\\.es$")
    public void setEmail(String email) {
        this.email = email;
    }

    public String getNombre() {
        return nombre;
    }
    
    @RequiredStringValidator(message="Campo nombre obligatorio")
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }
    
    @RequiredStringValidator(message="Campo apellidos obligatorio")
    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getFechanac() {
        return fechanac;
    }
    
    @RequiredStringValidator(message="Campo fecha de nacimiento obligatorio")
    public void setFechanac(String fechanac) {
        this.fechanac = fechanac;
    }

    
    
}
