package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "employee", schema = "db_telco_service")
@NamedQuery(name = "Employee.checkCredentials", query = "SELECT r FROM Employee r  WHERE r.username = ?1 and r.password = ?2")

public class Employee implements Serializable {
    private static final long serialVersionUID = 7855071578000718209L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idemployee;

    private String username;
    private String password;


    public Employee() {
    }

    public int getId() {
        return idemployee;
    }

    public void setId(int id) {
        this.idemployee = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
