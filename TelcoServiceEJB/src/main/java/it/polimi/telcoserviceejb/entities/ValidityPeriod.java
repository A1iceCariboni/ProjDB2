package it.polimi.telcoserviceejb.entities;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "validity_period")
@NamedQueries({@NamedQuery(name = "ValidityPeriod.findAll", query = "SELECT vp FROM ValidityPeriod vp"),
        @NamedQuery(name = "ValidityPeriod.findById", query = "SELECT vp FROM ValidityPeriod vp WHERE vp.id = ?1")})
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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ValidityPeriod that = (ValidityPeriod) o;
        return Objects.equals(id, that.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}