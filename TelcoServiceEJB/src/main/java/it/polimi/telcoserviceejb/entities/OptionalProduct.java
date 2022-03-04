package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;

@Entity
@Table(name = "optional_product")
@NamedQueries({@NamedQuery(name = "OptionalProduct.findAll", query = "SELECT op FROM OptionalProduct op"),
        @NamedQuery(name = "OptionalProduct.findById", query = "SELECT op FROM OptionalProduct op WHERE op.id = ?1")})
public class OptionalProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_optional_product", nullable = false)
    private Integer id;

    @Column(name = "name", length = 45)
    private String name;

    @Column(name = "monthly_fee")
    private Float monthlyFee;

    public OptionalProduct() {
    }

    public OptionalProduct(String name, Float monthlyFee) {
        this.name = name;
        this.monthlyFee = monthlyFee;
    }

    public Float getMonthlyFee() {
        return monthlyFee;
    }

    public void setMonthlyFee(Float monthlyFee) {
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