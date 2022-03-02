package it.polimi.telcoserviceejb.entities;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class SalesReportId implements Serializable {
    private static final long serialVersionUID = 5040862365917846131L;
    @Column(name = "id_service_package", nullable = false)
    private Integer idServicePackage;
    @Column(name = "id_validity_period", nullable = false)
    private Integer idValidityPeriod;

    public Integer getIdValidityPeriod() {
        return idValidityPeriod;
    }

    public void setIdValidityPeriod(Integer idValidityPeriod) {
        this.idValidityPeriod = idValidityPeriod;
    }

    public Integer getIdServicePackage() {
        return idServicePackage;
    }

    public void setIdServicePackage(Integer idServicePackage) {
        this.idServicePackage = idServicePackage;
    }

    @Override
    public int hashCode() {
        return Objects.hash(idServicePackage, idValidityPeriod);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        SalesReportId entity = (SalesReportId) o;
        return Objects.equals(this.idServicePackage, entity.idServicePackage) &&
                Objects.equals(this.idValidityPeriod, entity.idValidityPeriod);
    }
}