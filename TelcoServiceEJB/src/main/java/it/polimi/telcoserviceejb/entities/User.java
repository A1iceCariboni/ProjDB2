package it.polimi.telcoserviceejb.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "user", schema = "db_telco_service")
@NamedQueries({
@NamedQuery(name = "User.checkCredentials", query = "SELECT r FROM User r  WHERE r.username = ?1 and r.password = ?2"),
    @NamedQuery(name = "User.getUserByUsername", query = "SELECT r FROM User r  WHERE r.username = ?1"),
    @NamedQuery(name = "User.getInsolventUsers", query="SELECT u FROM User u WHERE u.insolvent = true ")})

public class User implements Serializable{
    private static final long serialVersionUID = 4688314470343184384L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_user;

    private String username;

    private String email;

    private String password;

    private boolean insolvent;


    public User(){}

    public User(String username, String email, String password){
        this.username = username;
        this.email = email;
        this.password = password;
        this.insolvent = false;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

    public boolean isInsolvent() {
        return insolvent;
    }

    public void setInsolvent(boolean insolvent) {
        this.insolvent = insolvent;
    }

    public int getId() {
        return id_user;
    }

    public void setId(int id) {
        this.id_user = id;
    }

    @Override
    public String toString() {
        return "User{" +
                "id_user=" + id_user +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", insolvent=" + insolvent +
                '}';
    }
}
