package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;

@Entity
@Table(name = "validity_period")
public class ValidityPeriod {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_validity_period", nullable = false)
    private Integer id;

    @Column(name = "months")
    private Integer months;

    @Column(name = "fee")
    private Integer fee;

    public ValidityPeriod(Integer months, Integer fee) {
        this.months = months;
        this.fee = fee;
    }

    public ValidityPeriod() {

    }

    public Integer getFee() {
        return fee;
    }

    public void setFee(Integer fee) {
        this.fee = fee;
    }

    public Integer getMonths() {
        return months;
    }

    public void setMonths(Integer months) {
        this.months = months;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

}