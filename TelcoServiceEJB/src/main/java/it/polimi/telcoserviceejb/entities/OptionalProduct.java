package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;

@Entity
@Table(name = "optional_product")
@NamedQueries({ @NamedQuery(name = "OptionalProduct.findAll", query = "SELECT op FROM OptionalProduct op")})
public class OptionalProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_optional_product", nullable = false)
    private Integer id;

    @Column(name = "name", length = 45)
    private String name;

    @Column(name = "monthly_fee")
    private Integer monthlyFee;

    public OptionalProduct() {
    }

    public OptionalProduct(String name, Integer monthlyFee) {
        this.name = name;
        this.monthlyFee = monthlyFee;
    }

    public Integer getMonthlyFee() {
        return monthlyFee;
    }

    public void setMonthlyFee(Integer monthlyFee) {
        this.monthlyFee = monthlyFee;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
}